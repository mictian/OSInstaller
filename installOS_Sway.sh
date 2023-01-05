#!/bin/bash

#######################
# DOCUMENTATION
#######################

# General Guide covering all cases
# https://blog.aktsbot.in/swaywm-on-debian-11.html

#######################
# VARIABLES DEFINITION
#######################

SOFTWAREPATH="${HOME}/programs"
CONFIGPATH="${HOME}/.config"
CUSTOMCONFIGPATH="${HOME}/.config.custom"
CURRENTPATH=`pwd`

OSNAME=`cat /etc/issue | head -n +1 | awk '{print $1}' | awk '{print toupper($0)}'`
# OSNAME_LOWER=`echo $OSNAME | awk '{print tolower($0)}'`
# OSCODENAME=`lsb_release -sc`

INST_CHROME="TRUE"
# INST_FIREFOX="TRUE"
# INST_DOCKER="FALSE"
# INST_INSYNC="TRUE"
# INST_NODE="TRUE"
# INST_VIRTUALBOX="TRUE"
# INST_LIBREOFFICE="TRUE"

# TODO
# Generate nice configuration for Sway
# Install my extra software from list abocve
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


# General System Utils
# Window Manager:
#  sway                          # tail windows manager
#  terminator                    # terminal
#  i3status                      # system status bar
# Basic:
#  mako-notifier                 # system notifications
#  gdebi                         # installer of .deb files
#  htop                          # process manager
#  software-properties-common    # apt & system abstractions
#  wireless-tools                # manage wireless settings
#  trash-cli                     # rm sends to trash
#  curl                          # download http content from cli
#  brightnessctl                 # manage bright settings
#  pavucontrol                   # manage audio/volume settings
#  git                           # software versioning control
# Menu Launcher - bemenu depencies (More info: https://github.com/Cloudef/bemenu):
#  scdoc                         # tool to make writing man pages more friendly
#  wayland-protocols             # add functionality not available in the Wayland core protocol
#  libcairo-5c-dev               # exposes most of the cairo API (Cairo is a 2D graphics library with support for multiple output devices)
#  libpango1.0-dev               #
#  libxkbcommon-dev              #
#  libwayland-dev                #
# Mount Andriod Devices:
#  jmtpfs                        #
# FileSystem Manager:
#  thunar                        #
#  thunar-archive-plugin         #
# Utilities
#  zathura                       # PDF Viewer
#  imv                           # image viewer
#  vim                           # console test editor
# Ofimatica
#  libreoffice                   #
#  libreoffice-java-common       #
#  default-jdk                   #
#  libreoffice-gtk3              #
sudo apt-get -qq install \
    sway terminator i3status \
    mako-notifier gdebi htop software-properties-common wireless-tools trash-cli curl brightnessctl pavucontrol git \
    scdoc wayland-protocols libcairo-5c-dev libpango1.0-dev libxkbcommon-dev libwayland-dev \
    jmtpfs \
    thunar thunar-archive-plugin \
    zathura \
    libreoffice libreoffice-java-common default-jdk libreoffice-gtk3 \
    -y

# Create sway config folder and copy default configs
mkdir -p ~/.config/sway
mkdir -p ~/.config/i3status
cp $CURRENTPATH/dotConfig/sway/config ~/.config/sway/config
cp $CURRENTPATH/dotConfig/i3status/config ~/.config/i3status/config

# Launcher (Bemenu)
mkdir $CURRENTPATH/temp
cd $CURRENTPATH/temp
git clone https://github.com/Cloudef/bemenu.git
cd bemenu
make clients wayland
sudo make install
cd $CURRENTPATH

# Network (Internet/Wi-Fi)
sudo apt install network-manager network-manager-gnome -y --no-install-recommends

# PDF Viewer Configuration
# xdg-mime default evince.desktop application/pdf

# CHROME
if [ $INST_CHROME = "TRUE" ]
then
    # Chrome
    #  xwayland                      # Compatiblity layer for software that needs X to make them run on Wayland
    #  fonts-liberations             # System fonts used by Google Chrome
    sudo apt-get -qq install xwayland fonts-liberations -y

	echo 'Google Chrome'

	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --no-check-certificate
	sudo gdebi google-chrome-stable_current_amd64.deb --n
	rm google-chrome-stable_current_amd64.deb
fi




