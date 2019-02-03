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
	echo -e $YELLOW"\n[*] Checking requires tools...\n"$DEFAULT
	if [ ! -d "hikka" ]; then 
		echo -e $RED"[!] Hikka does not exist"
		exit=1
	else
		echo -e $GREEN"[*] Hikka is installed"$DEFAULT
	fi
	sleep 0.025
	
	if ! hash masscan 2>/dev/null; then
		echo -e $RED"[!] Masscan is not installed"$DEFAULT
		exit=1
	else
		echo -e $GREEN"[*] Masscan is installed"$DEFAULT
	fi
	sleep 0.025
	
	if [ "$exit" = "1" ]; then
		echo -e "\nYou should install require packed. To do that type: sudo ./installer.sh"$DEFAULT
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
	echo -e $YELLOW"\t\tVersion: "$VERSION" By "$AUTHOR"" && sleep 1.30
}
function configure {
	clear
	initLogo
	#echo -ne $RED"[?] Do you want to auto scan host with cronetab [Y/n] #> "$DEFAULT
	echo -e $DEAFULT
	read -r -p "Are you want to scan host automaticly with crone? Answer [Y/n] " response
	response=${response,,}
	if [[ "$response" =~ ^(yes|y|Y)$ ]]; then
		echo "Add to crone"
	elif [[ "$response" =~ ^(no|n|N)$ ]]; then
		echo "Don't add to crone"
	else
		configure
	fi
	#---------- OLD METHOD TO CHECK IF USER WANT TO SEARCH AUTOMATICLY HOST -----------
	#read -N1 autoscan
	#autoscan=${autoscan:-"Y"}
	
	#if [ "$autoscan" = "Y" ] || [ "$autoscan" = "y" ]; then
	#	echo "" > 
	#elif [ "$autoscan" = "N" ] || [ "$autoscan" = "n" ]; then
	#	echo "Don't use cronTab"
	#else
	#	clear
	#	echo -e $RED"\nUnkown option. Please choose again!"$DEFAULT
	#	read -n 1 -s -r -p "Press any key to continue"
	#	configure
	#fi
}
displayHeader
configure


