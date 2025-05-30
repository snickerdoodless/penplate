#!/bin/bash

# Color formatting
HEADER="\e[1;34m"
SUBHEADER="\e[1;33m"
COMMAND="\e[0;36m"
RESET="\e[0m"

clear
echo -e "${HEADER}#==============================#"
echo -e "#     SHELL STABILIZATION     #"
echo -e "#==============================#${RESET}"

echo -e "\n${SUBHEADER}#-> Spawn a TTY shell${RESET}"
echo -e "${COMMAND}python3 -c 'import pty; pty.spawn(\"/bin/bash\")'${RESET}"

echo -e "\n${SUBHEADER}#-> Set PATH${RESET}"
echo -e "${COMMAND}export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/tmp${RESET}"

echo -e "\n${SUBHEADER}#-> Set terminal type${RESET}"
echo -e "${COMMAND}export TERM=xterm-256color${RESET}"

echo -e "\n${SUBHEADER}#-> Useful alias${RESET}"
echo -e "${COMMAND}alias ll='clear ; ls -lsaht --color=auto'${RESET}"

echo -e "\n${SUBHEADER}#-> Background shell (PRESS CTRL + Z)${RESET}"
echo -e "${COMMAND}# Press CTRL + Z to background shell${RESET}"

echo -e "\n${SUBHEADER}#-> Regain full terminal${RESET}"
echo -e "${COMMAND}stty raw -echo ; fg ; reset${RESET}"

echo -e "\n${SUBHEADER}#-> Fix terminal dimensions${RESET}"
echo -e "${COMMAND}stty columns 200 rows 200${RESET}"

echo ""
echo -e "${HEADER}End of stabilization notes.${RESET}"
