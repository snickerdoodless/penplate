#!/bin/bash

# Color variables
HEADER="\e[1;34m"
SUBHEADER="\e[1;33m"
COMMAND="\e[0;36m"
RESET="\e[0m"

clear
echo -e "${HEADER}REFERENCED BY S1REN${RESET}"
echo ""
echo -e "${SUBHEADER}Glossary:${RESET}"
echo "<sometext> = need adjustment"
echo ""

# Section: NMAP
echo -e "\n${HEADER}#==========================#"
echo -e "#           NMAP           #"
echo -e "#==========================#${RESET}"

echo -e "\n${SUBHEADER}#-> Aggresive${RESET}"
echo -e "${COMMAND}nmap -T5 -p- -A -O $IP${RESET}"

echo -e "\n${SUBHEADER}#-> Usual Command${RESET}"
echo -e "${COMMAND}nmap -p- $IP -sCV --open${RESET}"

echo -e "\n${SUBHEADER}#-> UDP Scan${RESET}"
echo -e "${COMMAND}nmap -sU $IP -sCV --open${RESET}"

echo -e "\n${SUBHEADER}#-> Chisel Scan${RESET}"
echo -e "${COMMAND}proxychains nmap -sT -Pn -p- $IP ${RESET}"


# Section: FUZZING
echo -e "\n${HEADER}#==========================#"
echo -e "#         FUZZING          #"
echo -e "#==========================#${RESET}"

echo -e "\n${SUBHEADER}#-> wFuzz - Files${RESET}"
echo -e "${COMMAND}wfuzz -c -z file,/opt/SecLists/Discovery/Web-Content/raft-medium-files.txt --hc 404 $URL${RESET}"

echo -e "\n${SUBHEADER}#-> wFuzz - Directory${RESET}"
echo -e "${COMMAND}wfuzz -c -z file,/opt/SecLists/Discovery/Web-Content/raft-medium-directories.txt --hc 404 $URL${RESET}"

echo -e "\n${SUBHEADER}#-> dirSearch - Files${RESET}"
echo -e "${COMMAND}dirsearch -u $URL -w /opt/SecLists/Discovery/Web-Content/raft-large-files.txt -t 100 -x 400-500${RESET}"

echo -e "\n${SUBHEADER}#-> dirSearch - Directory${RESET}"
echo -e "${COMMAND}dirsearch -u $URL -x 400-500 -r # try with no wordlists first!${RESET}"

echo -e "\n${SUBHEADER}#-> FFuF - Files${RESET}"
echo -e "${COMMAND}ffuf -w /opt/SecLists/Discovery/Web-Content/raft-large-files.txt -u \"$URL\" -fc 404 -c -v${RESET}"

echo -e "\n${SUBHEADER}#-> FFuF - Directories${RESET}"
echo -e "${COMMAND}ffuf -w /opt/SecLists/Discovery/Web-Content/raft-large-directories.txt -u \"$URL\" -fc 404 -c -v"
echo -e "ffuf -u https://target/FUZZ -w wordlist.txt -t 200 -fc 404 -o /dev/null -rate 1000 -noninteractive -http2${RESET}"

echo -e "\n${SUBHEADER}#-> FFuF - Parameter FUZZ${RESET}"
echo -e "${COMMAND}ffuf -u '${URL}/?FUZZ=test' -w /opt/SecLists/Discovery/Web-Content/common.txt -t 50 ${RESET}"

echo -e "\n${SUBHEADER}#-> FFuF - Brute Login${RESET}"
echo -e "${COMMAND}Get the POST request and response to ChatGPT to help generate ffuf payloads (complex case).${RESET}"

echo -e "\n${SUBHEADER}#-> feroxBuster - Files & Directory${RESET}"
echo -e "${COMMAND}feroxbuster -u "$URL" -w /opt/SecLists/Discovery/Web-Content/raft-large-files.txt -t 50 -r --filter-status 404${RESET}"
echo -e "${COMMAND}> continue session: feroxbuster --resume-from <statefile>${RESET}"
echo -e "${COMMAND}> options: -S 0 (content-length-filter) | --dont-scan css | --no-recursion | --cookie='PHPSESS=cookie'${RESET}"

echo -e "\n${SUBHEADER}#-> feroxBuster - Parameter FUZZ ${RESET}"
echo -e "${COMMAND}feroxbuster -u '${URL}/<page>?FUZZ=test' -w /opt/SecLists/Discovery -t 50 --quiet${RESET}"

# Section: WPSCAN
echo -e "\n${HEADER}#==========================#"
echo -e "#          WPSCAN          #"
echo -e "#==========================#${RESET}"

echo -e "\n${SUBHEADER}#-> All Enumeration${RESET}"
echo -e "${COMMAND}export URL=\"http://<IP>:80/wordpress/\""
echo -e "wpscan --url \"$URL\" -e p,t,u${RESET}"

echo -e "\n${SUBHEADER}#-> Brute Force Login Page${RESET}"
echo -e "${COMMAND}export URL=\"http://<IP>:80/wordpress/wp-admin.php\""
echo -e "wpscan --url \"$URL\" -U <user> -P /usr/share/wordlists/rockyou.txt"
echo -e "wpscan --url \"$URL\" -U /opt/SecLists/Usernames/Names/names.txt -P <pass>${RESET}"

# Section: HYDRA
echo -e "\n${HEADER}#==========================#"
echo -e "#           HYDRA          #"
echo -e "#==========================#${RESET}"

echo -e "\n${SUBHEADER}#-> Brute Login${RESET}"
echo -e "${COMMAND}hydra -L <path> -P /opt/SecLists/Passwords/<path> -f -v $IP http-post-form \"/login.php:<field_user>=^USER^&<field_pass>=^PASS^:Login failed\" -o hydra.log -s <port>"
echo -e "> hydra -R # restore session${RESET}"

echo -e "\n${SUBHEADER}#-> Enum Username${RESET}"
echo -e "${COMMAND}hydra -L <path> -p test123 $IP http-post-form \"/login:username=^USER^&password=test123:Invalid username\" -s <PORT>${RESET}"

echo -e "\n${SUBHEADER}#-> Brute FTP${RESET}"
echo -e "${COMMAND}hydra -L <path> -P <path> \"ftp://$IP\"${RESET}"

echo -e "\n${SUBHEADER}#-> Brute SSH${RESET}"
echo -e "${COMMAND}hydra -L <path> -P <path> \"ssh://$IP\"${RESET}"

# Section: SUFFIX
echo -e "\n${HEADER}#==========================#"
echo -e "#          SUFFIX          #"
echo -e "#==========================#${RESET}"

echo -e "\n${SUBHEADER}#-> Wordlist Suffix Append${RESET}"
echo -e "${COMMAND}sed 's/\$/<word>/' wordlist.txt > modified_wordlist.txt${RESET}"

echo -e "\n${SUBHEADER}#-> Replace ALl Words${RESET}"
echo -e "${COMMAND}sed -i 's/<original-word>/<new-word>/g' filename.txt${RESET}"

# Section: SNMP
echo -e "\n${HEADER}#==========================#"
echo -e "#           SNMP           #"
echo -e "#==========================#${RESET}"

echo -e "\n${SUBHEADER}#-> snmpwalk${RESET}"
echo -e "${COMMAND}snmpwalk -c public -v1 $IP${RESET}"
echo -e "${COMMAND}snmpwalk -v2c -c public $IP 1${RESET}"


# Section: SQLMAP
echo -e "\n${HEADER}#==========================#"
echo -e "#           SQLMAP         #"
echo -e "#==========================#${RESET}"

echo -e "\n${SUBHEADER}#-> Aggresive${RESET}"
echo -e "${COMMAND}sqlmap -u $URL --threads=2 --time-sec=10 --level=4 --risk=3 --dump --dbms=mysql -dbs${RESET}"
echo -e "${COMMAND}${RESET}"


echo -e ""
echo -e "${HEADER}End of notes.${RESET}"
