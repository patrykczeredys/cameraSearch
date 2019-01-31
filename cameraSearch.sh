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
HOSTS_DUMP_PATH="Host"
VERSION=1.0
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
	echo -e $GREEN"\nExample: sudo ./cameraSearch.sh\n\n"
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

function CheckRequireTools {
	echo -e $YELLOW"\n[*] Checking and instaling requires tools...\n"$DEFAULT
	if [ ! -d "hikka" ]; then 
		echo -e $RED"[!] Hikka does not exist"
		exit=1
	else
		echo -e $GREEN"[*] Hikka is installed"$DEFAULT
	fi
	sleep 0.025
	
	if ! hash masscan 2>/dev/null; then
		echo -e $RED"[!] Masscan is not installed"
		exit=1
	else
		echo -e $GREEN"[*] Masscan is installed"$DEFAULT
	fi
	sleep 0.025
	
	if [ "$exit" = "1" ]; then
		echo -e "\nYou should install require packed. To do that type: sudo ./install.sh"$DEFAULT
		exit 1
	fi
	sleep 1
}
initLogo
CheckRequireTools

#---------- CREATE DIR -----------
if [ ! -d $HOSTS_DUMP_PATH ]; then
	mkdir -p $HOSTS_DUMP_PATH
fi

function displayHeader {
	clear
	sleep 0.080 && echo -e $RED" @@@@@@@   @@@@@@   @@@@@@@@@@   @@@@@@@@  @@@@@@@    @@@@@@   " && sleep 0.080
	echo "@@@@@@@@  @@@@@@@@  @@@@@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  " && sleep 0.080
	echo "!@@       @@!  @@@  @@! @@! @@!  @@!       @@!  @@@  @@!  @@@  " && sleep 0.080
	echo "!@!       !@!  @!@  !@! !@! !@!  !@!       !@!  @!@  !@!  @!@  " && sleep 0.080
	echo "!@!       @!@!@!@!  @!! !!@ @!@  @!!!:!    @!@!!@!   @!@!@!@!  " && sleep 0.080
	echo "!!!       !!!@!!!!  !@!   ! !@!  !!!!!:    !!@!@!    !!!@!!!!  " && sleep 0.080
	echo ":!!       !!:  !!!  !!:     !!:  !!:       !!: :!!   !!:  !!!  " && sleep 0.080
	echo ":!:       :!:  !:!  :!:     :!:  :!:       :!:  !:!  :!:  !:!  " && sleep 0.080
	echo "::: :::  ::   :::  :::     ::    :: ::::  ::   :::  ::   :::	 " && sleep 0.080
	echo ":: :: :   :   : :   :      :    : :: ::    :   : :   :   : :   " && sleep 0.040
	echo "																 " && sleep 0.040
	echo "																 " && sleep 0.080
	echo " @@@@@@   @@@@@@@@   @@@@@@   @@@@@@@    @@@@@@@  @@@  @@@ 	 " && sleep 0.080
	echo "@@@@@@@   @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@  @@@     " && sleep 0.080
	echo "!@@       @@!       @@!  @@@  @@!  @@@  !@@       @@!  @@@  	 " && sleep 0.080
	echo "!@!       !@!       !@!  @!@  !@!  @!@  !@!       !@!  @!@  	 " && sleep 0.080
	echo "!!@@!!    @!!!:!    @!@!@!@!  @!@!!@!   !@!       @!@!@!@!  	 " && sleep 0.080
	echo " !!@!!!   !!!!!:    !!!@!!!!  !!@!@!    !!!       !!!@!!!!  	 " && sleep 0.080
	echo "     !:!  !!:       !!:  !!!  !!: :!!   :!!       !!:  !!!  " && sleep 0.080
	echo "    !:!   :!:       :!:  !:!  :!:  !:!  :!:       :!:  !:!  " && sleep 0.080
	echo ":::: ::    :: ::::  ::   :::  ::   :::   ::: :::  ::   :::  " && sleep 0.080
	echo ":: : :    : :: ::    :   : :   :   : :   :: :: :   :   : :  " && sleep 0.040
	echo -e $YELLOW"\t\tVersion: "$VERSION" By "$AUTHOR && sleep 1.25
}
function configure {
	while true; do
		echo -ne $GREEN"[?] Do you want to auto scan host y/n #> "$DEFAULT
		read anw
		case $anw in
			'y') echo -e "\nadd to crone";break;;
			'Y') echo -e "\nadd to crone";break;;
			'n') echo -e "\ndon't add to crone";break;;
			'N') echo -e "\ndon't add to crone";break;;
			*) echo -e "\nUnknow option! Select again.";clear;;
		esac
	done
}
displayHeader
configure


