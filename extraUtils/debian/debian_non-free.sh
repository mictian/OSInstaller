#!/bin/bash
#
# Writes sources.list in order to add non-free repository
#


DEBIAN_RELEASE=`cat /etc/*-release 2> /dev/null | grep PRETTY_NAME | awk -F "=" {'print $2'} | awk -F "(" {'print $2'} | awk -F ")" {'print $1'}`

echo "Writes /etc/apt/sources.list in order to add $DEBIAN_RELEASE non-free repository"

echo "# deb http://http.debian.net/debian $DEBIAN_RELEASE main" > /etc/apt/sources.list
echo "" >> /etc/apt/sources.list
echo "deb http://http.debian.net/debian $DEBIAN_RELEASE main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://http.debian.net/debian $DEBIAN_RELEASE main contrib non-free" >> /etc/apt/sources.list
echo "" >> /etc/apt/sources.list
echo "deb http://security.debian.org/ $DEBIAN_RELEASE/updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/ $DEBIAN_RELEASE/updates main contrib non-free" >> /etc/apt/sources.list
echo "" >> /etc/apt/sources.list
echo "# $DEBIAN_RELEASE-updates, previously known as "volatile"" >> /etc/apt/sources.list
echo "deb http://http.debian.net/debian $DEBIAN_RELEASE-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://http.debian.net/debian $DEBIAN_RELEASE-updates main contrib non-free" >> /etc/apt/sources.list
