#!/bin/bash

# Color formatting
HEADER="\e[1;34m"
SUBHEADER="\e[1;33m"
COMMAND="\e[0;36m"
RESET="\e[0m"

clear
echo -e "${HEADER}#=============================#"
echo -e "#        FILE UPLOADS        #"
echo -e "#=============================#${RESET}"

echo -e "\n${SUBHEADER}#-> Bypassing File Upload Restrictions${RESET}"
echo -e "${COMMAND}https://github.com/malware-d/template/blob/master/example_attack/Bypassing%20File%20Upload%20Restrictions.md${RESET}"

echo -e "\n${SUBHEADER}#-> Gist: Payload Tricks & Bypasses${RESET}"
echo -e "${COMMAND}https://gist.github.com/kljunowsky/9735865641ce67e56d38ae5465df3aae${RESET}"

echo -e "\n${SUBHEADER}#-> Hacktricks${RESET}"
echo -e "${COMMAND}http://book.hacktricks.wiki/en/pentesting-web/file-upload/index.html${RESET}\n"

echo -e "${HEADER}#=============================#"
echo -e "#        SQL INJECTION        #"
echo -e "#=============================#${RESET}"

echo -e "\n${SUBHEADER}#-> Payloadbox SQLi Payload${RESET}"
echo -e "${COMMAND}https://github.com/payloadbox/sql-injection-payload-list${RESET}"

echo ""
echo -e "${HEADER}End of payloads notes.${RESET}"
