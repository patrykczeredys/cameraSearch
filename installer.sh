#!/bin/bash                                                  
#  ##                          ##                 #   
# #    ## ### ### ###  ##     #   ###  ## ### ### ### 
# #   # # ### ##  #   # #      #  ##  # # #   #   # # 
# #   ### # # ### #   ###       # ### ### #   ### # # 
#  ##                         ##                      
# version 1.0 by 2DPac

#---------- < CONFIG > ------------
USER=$EUID
AUTHOR="2DPac"
WORK_DIR="pwd"
HOSTS_DUMP_PATH="~"
VERSION=1
#----------------------------------

#------------- COLORS -------------
DEFAULT="\e[39m"
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLINK="\e[5m"
BLUE="\e[34m"
#----------------------------------

#---------- CHECK ADMIN -----------
if [ $USER -ne 0 ]; then
	clear
	echo -e $RED"\nYou must run as root. Exiting...\n"
	echo -e $GREEN"\nExample: sudo ./installer.sh\n\n"
	exit 1
fi
#----------------------------------

function initLogo() { 
	echo -e $RED"  ##                          ##                 #   "
	echo " #    ## ### ### ###  ##     #   ###  ## ### ### ### "
	echo " #   # # ### ##  #   # #      #  ##  # # #   #   # # "
	echo " #   ### # # ### #   ###       # ### ### #   ### # # "
	echo -e "  ##                         ##                      "$DEFAULT
}

initLogo
echo -e $GREEN"[*] Update your system..."$DEFAULT
apt-get install update -y
echo -e $GREEN"[*] Done..."$DEFAULT
sleep 1.25
clear

function InstallRequireTools {
	echo -e $YELLOW"\n[*] Instaling requires tools...\n"$DEFAULT
	echo -e $YELLOW"[*] Installing masscan..."$DEFAULT
	apt-get install -y masscan
	if hash masscan 2>/dev/null; then 
		echo -e $GREEN"[*] Masscan is now installed"
	fi
	echo -e $YELLOW"[*] Downloading and installing hikka..."$DEFAULT
	git clone "https://github.com/superhacker777/hikka.git"
	if [ -d "hikka" ]; then
		echo -e $GREEN"[*] Hikka is now downloaded"$DEFAULT
	fi
}
initLogo
InstallRequireTools


