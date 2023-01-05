#!/bin/bash

#######################
# VARIABLES DEFINITION
#######################

SOFTWAREPATH="${HOME}/programs"
CONFIGPATH="${HOME}/.config"
CUSTOMCONFIGPATH="${HOME}/.config.custom"
CURRENTPATH=`pwd`

OSNAME=`cat /etc/issue | head -n +1 | awk '{print $1}' | awk '{print toupper($0)}'`
OSNAME_LOWER=`echo $OSNAME | awk '{print tolower($0)}'`
OSCODENAME=`lsb_release -sc`

INST_CHROME="TRUE"
INST_FIREFOX="TRUE"
INST_DOCKER="FALSE"
INST_INSYNC="TRUE"
INST_NODE="TRUE"
INST_VIRTUALBOX="TRUE"
INST_LIBREOFFICE="TRUE"

#TODO
INST_PLAYERCTL="FALSE"

#######################
# INSTALL BASICS
#######################

echo 'STARTING to INSTALL BASIC SYSTEM Utils'

if [ $OSNAME = "DEBIAN" ]
then
	sudo ./extraUtils/debian/debian_non-free.sh
fi

sudo apt-get -qq update
sudo apt-get -qq -y upgrade



# LIST OF REQUIRE APPLICATIONS

# Window manager (i3), terminal (terminator)
sudo apt-get -qq install xorg i3 terminator -y

# General System Utils
# Basic:
#  gdebi                         # installer of .deb files
#  htop                          # process manager
#  software-properties-common    # apt & system abstractions
#  wireless-tools                # manage wireless settings
#  trash-cli                     # rm sends to trash
sudo apt-get -qq install gdebi htop software-properties-common wireless-tools trash-cli -y

# Video:
#  arandr                        # set video settings
#  lxappearance                  # set theme
#  xbacklight                    # allows to set the backlight
#  xfce4-screenshooter           # select region and take screenshoot (maim is an alternative)
sudo apt-get -qq install arandr lxappearance xbacklight xfce4-screenshooter -y

# NEEDED ?
# gnome-icon-theme
# gsettings-desktop-schemas

# mount Andriod devices
sudo apt-get -qq install jmtpfs -y

# handle touchpad
sudo apt-get -qq install xinput -y

# LAN/WAN Connection
sudo apt-get -qq install network-manager-gnome network-manager-openvpn* curl -y

# File System
sudo apt-get -qq install thunar thunar-archive-plugin -y

# Notification (dunst)
sudo apt-get -qq install libnotify-bin dunst -y

# PDF Viewer
sudo apt-get -qq install  evince -y
xdg-mime default evince.desktop application/pdf

# Media
# Image viewer & editor (Mirage: Image viewer, Pinta: Basic image editor)
sudo apt-get -qq install mirage pinta -y

# Video players (VLC GUI videos, MPV: Command line music)
sudo apt-get -qq install vlc mpv -y

# Sound (drivers)
sudo apt-get -qq install alsa-base -y
sudo apt-get -qq install alsa-utils pulseaudio -y

# Handling Bluethoot
sudo apt-get -qq install blueman pavucontrol -y
sudo apt-get -qq install pulseaudio-module-bluetooth -y

# Development
# Neo/VIM Related Stuff
sudo apt-get -qq install git -y
sudo apt-get -qq install ack-grep build-essential cmake  -y
sudo apt-get -qq install vim  -y
# sudo apt-get -q install exuberant-ctags ncurses-term -y
# sudo apt-get -q install python-neovim python3-neovim xsel -y
# vim:YouCompleteMe deps
# sudo apt-get -q install python-dev python-pip python3-dev python3-pip -y

# Miscellaneous
# Wiki
sudo apt-get -qq install zim -y

# needed in debian for apt-key
sudo apt-get -qq install dirmngr -y

# Handle JSON in the command line
sudo apt-get -qq install jq -y


# --------------------------------


# #######################
# # INSTALL EXTRA SOFTWARE
# #######################

# echo 'STARTING  to INSTALL EXTRA SOFTWARE'

# if [ -d "${SOFTWAREPATH}" ]; then
# 	# Control will enter here if $DIRECTORY exists.
# 	rm -rf ${SOFTWAREPATH}
# fi
# mkdir ${SOFTWAREPATH}


# # LIBREOFFICE FRESH
# if [ $INST_LIBREOFFICE = "TRUE" ]
# then
# 	echo 'LibreOffice  Fresh (from site)'

# 	wget http://download.documentfoundation.org/libreoffice/stable/ -O index.html

# 	LIBREOFFICE_VERSION=`cat index.html | grep -oP 'href="\K([0-9]\.[0-9]\.[0-9])' | tail -1`
# 	wget http://ftp.ussg.indiana.edu/tdf/libreoffice/stable/${LIBREOFFICE_VERSION}/deb/x86_64/LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb.tar.gz --no-check-certificate
# 	tar xfz LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb.tar.gz
# 	rm LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb.tar.gz
# 	cd LibreOffice_${LIBREOFFICE_VERSION}*
# 	cd DEBS
# 	sudo dpkg -i *.deb

# 	cd ../../
# 	rm -rf LibreOffice_${LIBREOFFICE_VERSION}*
# 	rm index.html
# fi

# # FIREFOX
# if [ $INST_FIREFOX = "TRUE" ]
# then
# 	echo 'Firefox ESR from store'
# 	sudo apt-get -q install firefox-esr -y
# 	sudo apt-get -q install browser-plugin-freshplayer-pepperflash -y
# fi

# # CHROME
# if [ $INST_CHROME = "TRUE" ]
# then
# 	echo 'Google Chrome'

# 	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --no-check-certificate
# 	sudo gdebi google-chrome-stable_current_amd64.deb --n
# 	rm google-chrome-stable_current_amd64.deb
# fi

# # DOCKER
# if [ $INST_DOCKER = "TRUE" ]
# then
# 	echo 'Docker'

# 	sudo apt-get -qq update
# 	sudo apt-get -y install apt-transport-https ca-certificates
# 	curl -fsSL get.docker.com -o get-docker.sh
# 	sudo sh get-docker.sh
# 	rm get-docker.sh
# 	#Manage docker as a non-root user
# 	sudo usermod -aG docker $USER
# 	#Auto start docker
# 	sudo systemctl enable docker
# fi

# # INSYNC
# if [ $INST_INSYNC = "TRUE" ]
# then
# 	echo 'Insync'

# 	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C
# 	sudo touch /etc/apt/sources.list.d/insync.list
# 	echo "deb http://apt.insynchq.com/$OSNAME_LOWER $OSCODENAME non-free contrib" | sudo tee -a /etc/apt/sources.list.d/insync.list > /dev/null
# 	sudo apt-get update > /dev/null
# 	sudo apt-get install insync-headless -y
# fi

# # NODEJS
# if [ $INST_NODE = "TRUE" ]
# then
# 	echo 'NodeJS'

# 	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.0/install.sh | bash

# 	# install the last version of node
# 	export NVM_DIR="$HOME/.nvm"
# 	. ${NVM_DIR}/nvm.sh
# 	. ${NVM_DIR}/bash_completion

# 	nvm install node
# fi

# # VIRTUALBOX
# if [ $INST_VIRTUALBOX = "TRUE" ]
# then
# 	echo 'VirtuaBox'

# 	cat /etc/apt/sources.list | grep virtualbox
# 	if [ $? -eq 1 ]
# 	then
# 		echo "deb http://download.virtualbox.org/virtualbox/debian $OSCODENAME contrib" | sudo tee -a /etc/apt/sources.list > /dev/null
# 		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
# 	fi

# 	wget http://download.virtualbox.org/virtualbox/LATEST.TXT --no-check-certificate
# 	VIRTUALBOX_VER=`cat LATEST.TXT | cut -d '.' -f 1,2`
# 	sudo apt-get -qq update
# 	sudo apt-get -y -qq upgrade
# 	sudo apt-get install virtualbox-${VIRTUALBOX_VER} -y

# 	sudo rm LATEST.TXT
# fi

# #PLAYER_CTL
# if [ $INST_PLAYERCTL = "TRUE" ]
# then
# 	echo 'PlayerCtl'


# 	#PLAYERCTRL_URL=`curl -s 'https://api.github.com/repos/acrisci/playerctl/releases/latest' | jq '.assets[] | select(.name | contains(".deb")) | .browser_download_url'`

# 	#wget https://api.github.com/repos/acrisci/playerctl/releases/latest --no-check-certificate
# 	#underscore -i latest select '.browser_download_url' | underscore filter 'value.indexOf(".deb") >= 0' | underscore process 'data[0]' | underscore process 'console.log(data)' > downloadurl
# 	#wget -i downloadurl --no-check-certificate
# 	#sudo gdebi playerctl* --n
# 	#rm latest
# 	#rm downloadurl
# 	#rm playerctl*
# fi


# #######################
# #CONFIGURATION
# #######################

# echo 'CONFIGURATION'

# # Standard Configuration
# #######################

# if [ ! -d "${CONFIGPATH}" ]; then
# 	mkdir ${CONFIGPATH}
# fi

# if [ ! -d "${CUSTOMCONFIGPATH}" ]; then
# 	mkdir ${CUSTOMCONFIGPATH}
# fi

# #Copy Configuration
# cp -rf ./dotConfig/*  ${CONFIGPATH}/
# cp -rf ./dotConfig.custom/*  ${CUSTOMCONFIGPATH}/


# sudo chmod +x ${CUSTOMCONFIGPATH}/onStartup.sh
# sudo chmod +x ${CUSTOMCONFIGPATH}/onBash.sh
# sudo chmod +x ${CUSTOMCONFIGPATH}/screenBright.sh

# echo ". ${CUSTOMCONFIGPATH}/onBash.sh" >> ${HOME}/.bashrc

# #Set mictian as the owner of all the files in this folder
# sudo chown -R mictian:mictian ${CUSTOMCONFIGPATH}/

# #Install brightness rules
# sudo sh ./dotConfig.custom/screenBrightInstall.sh

# # Resource Configuration
# #######################

# #Keyboard Settings
# sudo cp ./resources/keyboard/keyboard  /etc/default/keyboard

# #General Theme
# sudo tar xfz ./resources/theme/Bunsen-Blackish.tar.gz -C /usr/share/themes/
# sudo tar xfz ./resources/theme/bunsenBlackishRemixTheme.tar.gz -C /usr/share/themes/
# sudo tar xfz ./resources/theme/equiluxTheme.tar.gz -C /usr/share/themes/
# sudo tar xfz ./resources/theme/mistakeTheme.tar.gz -C /usr/share/themes/



# #Configure Updater
# #cd ${CUSTOMCONFIGPATH}/updater/
# #npm i
# #cd ${CURRENTPATH}
# #(crontab -l 2>/dev/null; echo "0 19 * * * node ${CUSTOMCONFIGPATH}/updater/updater.js") | crontab -

