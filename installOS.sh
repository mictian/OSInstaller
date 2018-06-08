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

INST_CHROME="FALSE"
INST_CHROMIUM="TRUE"
INST_DOCKER="FALSE"
INST_INSYNC="TRUE"
INST_NODE="TRUE"
INST_VIRTUALBOX="TRUE"
INST_SUBLIME="TRUE"
INST_LIBREOFFICE="1"
	# FALSE = Nope
	# 1 = From Store (apt-get)
	# 2 = From site (last fresh)
INST_FIREFOX="TRUE"
INST_NEOVIM="TRUE"

#TODO
INST_PLAYERCTL="FALSE"

#######################
# INSTALL SYSTEM BASIC
#######################

echo 'START SYSTEM BASIC'
if [ $OSNAME = "DEBIAN" ]
then
	sudo ./extraUtils/debian/debian_non-free.sh
fi

sudo apt-get -qq update
sudo apt-get -qq -y upgrade

sudo apt-get -q install xorg i3 terminator -y


# LIST OF REQUIRE APPLICATIONS
# General System Utils
sudo apt-get -q install git gdebi htop software-properties-common arandr xbacklight gnome-icon-theme xfce4-screenshooter wireless-tools gsettings-desktop-schemas lxappearance trash-cli xinput -y
# mount Andriod devices
sudo apt-get -1 install jmtpfs -y
# handle touchpad
sudo apt-get -1 install xinput -y
# LAN/WAN Connection
sudo apt-get -q install network-manager-gnome network-manager-openvpn* curl -y
# File System
sudo apt-get -q install thunar thunar-archive-plugin -y
# Instant messages
sudo apt-get -q install pidgin libnotify-bin dunst pidgin-libnotify -y
# PDF Viewer
sudo apt-get -q install mirage evince -y
# Media
# Image viewer & editor
sudo apt-get -q install pinta -y
# Video players
sudo apt-get -q install vlc mpv -y
# Sound
sudo apt-get -q install alsa-base -y
sudo apt-get -q install alsa-utils pulseaudio -y
# Development
# Neo/VIM Related Stuff
sudo apt-get -q install exuberant-ctags ack-grep build-essential ncurses-term cmake  -y
sudo apt-get -q install python-neovim python3-neovim xsel -y
# vim:YouCompleteMe
sudo apt-get -q install python-dev python-pip python3-dev python3-pip -y
# Miscellaneous
# needed in debian for apt-key
sudo apt-get -q install dirmngr -y
# Wiki
sudo apt-get -q install zim -y
# Handle JSON in the command line
sudo apt-get -q install jq -y
# Handling BlueThoot
sudo apt-get -q install blueman pavucontrol -y
sudo apt-get -q install pulseaudio-module-bluetooth -y


#######################
# INSTALL EXTRA SOFT
#######################

echo 'START EXTRA SOFT'

if [ -d "${SOFTWAREPATH}" ]; then
	# Control will enter here if $DIRECTORY exists.
	rm -rf ${SOFTWAREPATH}
fi
mkdir ${SOFTWAREPATH}

# LIBREOFFICE "Stable"
if [ $INST_LIBREOFFICE = "1" ]
then
	sudo apt-get -q install libreoffice libreoffice-gtk -y
fi

#FIREFOX
if [ $INST_FIREFOX = "TRUE" ]
then
	echo 'Firefox ESR from store'
	sudo apt-get -q install firefox-esr -y
	sudo apt-get -q install browser-plugin-freshplayer-pepperflash -y
fi

# CHROME
if [ $INST_CHROME = "TRUE" ]
then
	echo 'Google Chrome'

	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --no-check-certificate
	sudo gdebi google-chrome-stable_current_amd64.deb --n
	rm google-chrome-stable_current_amd64.deb
fi

# CHROMIUM
if [ $INST_CHROMIUM = "TRUE" ]
then
	echo 'Chromium from store'

	if [ $OSNAME = "UBUNTU" ]
	then
		sudo apt-get install chromium-browser -y
		sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list
		sudo apt-get update
		sudo apt-get install adobe-flashplugin -y
	else
		sudo apt-get install chromium -y
	fi
fi

# DOCKER
if [ $INST_DOCKER = "TRUE" ]
then
	echo 'Docker'

	sudo apt-get -qq update
	sudo apt-get -y install apt-transport-https ca-certificates
	curl -fsSL get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
	rm get-docker.sh
	#Manage docker as a non-root user
	sudo usermod -aG docker $USER
	#Auto start docker
	sudo systemctl enable docker
fi

# INSYNC
if [ $INST_INSYNC = "TRUE" ]
then
	echo 'Insync'

	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C
	sudo touch /etc/apt/sources.list.d/insync.list
	echo "deb http://apt.insynchq.com/$OSNAME_LOWER $OSCODENAME non-free contrib" | sudo tee -a /etc/apt/sources.list.d/insync.list > /dev/null
	sudo apt-get update > /dev/null
	sudo apt-get install insync-headless -y
fi

# NODEJS
if [ $INST_NODE = "TRUE" ]
then
	echo 'NodeJS'

	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

	# install the last version of node
	export NVM_DIR="$HOME/.nvm"
	. ${NVM_DIR}/nvm.sh
	. ${NVM_DIR}/bash_completion

	nvm install node
fi

# VIRTUALBOX
if [ $INST_VIRTUALBOX = "TRUE" ]
then
	echo 'VirtuaBox'

	cat /etc/apt/sources.list | grep virtualbox
	if [ $? -eq 1 ]
	then
		echo "deb http://download.virtualbox.org/virtualbox/debian $OSCODENAME contrib" | sudo tee -a /etc/apt/sources.list > /dev/null
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
	fi

	wget http://download.virtualbox.org/virtualbox/LATEST.TXT --no-check-certificate
	VIRTUALBOX_VER=`cat LATEST.TXT | cut -d '.' -f 1,2`
	sudo apt-get -qq update
	sudo apt-get -y -qq upgrade
	sudo apt-get install virtualbox-${VIRTUALBOX_VER} -y

	sudo rm LATEST.TXT
fi

# SUBLIME TEXT 3
if [ $INST_SUBLIME = "TRUE" ]
then
	echo 'Sublime'

	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-get install apt-transport-https -y
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get install sublime-text -y
fi


# LIBREOFFICE FRESH
if [ $INST_LIBREOFFICE = "2" ]
then
	echo 'LibreOffice'

	wget http://download.documentfoundation.org/libreoffice/stable/ -O index.html

	LIBREOFFICE_VERSION=`cat index.html | grep -oP 'href="\K([0-9]\.[0-9]\.[0-9])' | tail -1`
	wget http://ftp.ussg.indiana.edu/tdf/libreoffice/stable/${LIBREOFFICE_VERSION}/deb/x86_64/LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb.tar.gz --no-check-certificate
	tar xfz LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb.tar.gz
	rm LibreOffice_${LIBREOFFICE_VERSION}_Linux_x86-64_deb.tar.gz
	cd LibreOffice_${LIBREOFFICE_VERSION}*
	cd DEBS
	sudo dpkg -i *.deb

	cd ../../
	rm -rf LibreOffice_${LIBREOFFICE_VERSION}*
	rm index.html
fi

# NEOVIM
if [ $INST_NEOVIM = "TRUE" ]
then
	echo 'NeoVim'
	if [ $OSNAME = "UBUNTU" ]
	then
		sudo add-apt-repository ppa:neovim-ppa/stable -y
		sudo apt-get update
		sudo apt-get -q install neovim -y
	else
		NEOVIM_URL=`curl -s 'https://api.github.com/repos/neovim/neovim/releases/latest' | jq '.assets[] | select(.name =="nvim.appimage") | .browser_download_url'`
		NEOVIM_URL=`echo $NEOVIM_URL | tail -c +2 | head -c -2`
		wget $NEOVIM_URL --no-check-certificate
		sudo chmod u+x nvim.appimage
		sudo mv nvim.appimage /usr/bin
		pip install neovim
	fi
fi

#PLAYER_CTL
if [ $INST_PLAYERCTL = "TRUE" ]
then
	echo 'PlayerCtl'


	#PLAYERCTRL_URL=`curl -s 'https://api.github.com/repos/acrisci/playerctl/releases/latest' | jq '.assets[] | select(.name | contains(".deb")) | .browser_download_url'`

	#wget https://api.github.com/repos/acrisci/playerctl/releases/latest --no-check-certificate
	#underscore -i latest select '.browser_download_url' | underscore filter 'value.indexOf(".deb") >= 0' | underscore process 'data[0]' | underscore process 'console.log(data)' > downloadurl
	#wget -i downloadurl --no-check-certificate
	#sudo gdebi playerctl* --n
	#rm latest
	#rm downloadurl
	#rm playerctl*
fi


#######################
#CONFIGURATION
#######################

echo 'CONFIGURATION'

# Standard Configuration
#######################

if [ ! -d "${CONFIGPATH}" ]; then
	mkdir ${CONFIGPATH}
fi

if [ ! -d "${CUSTOMCONFIGPATH}" ]; then
	mkdir ${CUSTOMCONFIGPATH}
fi

#Copy Configuration
cp -rf ./dotConfig/*  ${CONFIGPATH}/
cp -rf ./dotConfig.custom/*  ${CUSTOMCONFIGPATH}/

echo "
# Start-up logic
exec --no-startup-id ${CUSTOMCONFIGPATH}/onStartup.sh" >> ${CONFIGPATH}/i3/config

sudo chmod +x ${CUSTOMCONFIGPATH}/onStartup.sh
sudo chmod +x ${CUSTOMCONFIGPATH}/onBash.sh
sudo chmod +x ${CUSTOMCONFIGPATH}/screenBright.sh

echo ". ${CUSTOMCONFIGPATH}/onBash.sh" >> ${HOME}/.bashrc

#Set mictian as the owner of all the files in this folder
sudo chown -R mictian:mictian ${CUSTOMCONFIGPATH}/

#Install brightness rules
sudo sh ./dotConfig.custom/screenBrightInstall.sh

# Resource Configuration
#######################

#NeoVIM JS Autocompletition
cp -rf ./resources/nvim/.tern-config  ${HOME}/

#Keyboard Settings
sudo cp ./resources/keyboard/keyboard  /etc/default/keyboard

#General Theme
sudo tar xfz ./resources/theme/Bunsen-Blackish.tar.gz -C /usr/share/themes/
sudo tar xfz ./resources/theme/bunsenBlackishRemixTheme.tar.gz -C /usr/share/themes/
sudo tar xfz ./resources/theme/equiluxTheme.tar.gz -C /usr/share/themes/
sudo tar xfz ./resources/theme/mistakeTheme.tar.gz -C /usr/share/themes/



#Configure Updater
#cd ${CUSTOMCONFIGPATH}/updater/
#npm i
#cd ${CURRENTPATH}
#(crontab -l 2>/dev/null; echo "0 19 * * * node ${CUSTOMCONFIGPATH}/updater/updater.js") | crontab -

