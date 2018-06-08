#!/bin/bash

#Based on:
#	https://wiki.archlinux.org/index.php/backlight
#	https://unix.stackexchange.com/questions/301724/xbacklight-not-working
#Extra info:
# https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder/715310
# https://unix.stackexchange.com/questions/301724/xbacklight-not-working/340926
# https://unix.stackexchange.com/questions/270347/xbacklight-not-working-on-debian-jessie-lenovo-s10
#	I did not tryed this

BRIGHT_PERCENTAGE=20

if [ "$#" -eq 1 ]
then
	for i in $( ls  /sys/class/backlight/ ); do
		MAX_BRIGHT=`cat /sys/class/backlight/$i/max_brightness`
		ACTUAL_BRIGHT=`cat /sys/class/backlight/$i/actual_brightness`
		BRIGHT_CHANGE=$(( (BRIGHT_PERCENTAGE*MAX_BRIGHT) / 100 ))
		
		if [ $1 = "up" ]
		then
			NEW_BRIGHT=$(( ACTUAL_BRIGHT+BRIGHT_CHANGE ))
			NEW_BRIGHT=`[ "$NEW_BRIGHT" -gt "$MAX_BRIGHT" ] && echo $MAX_BRIGHT || echo $NEW_BRIGHT`

		elif [ $1 = "down" ]
		then
			NEW_BRIGHT=$(( ACTUAL_BRIGHT-BRIGHT_CHANGE ))
			NEW_BRIGHT=`[ "$NEW_BRIGHT" -lt 0 ] && echo $ACTUAL_BRIGHT || echo $NEW_BRIGHT`
			
		fi
		tee /sys/class/backlight/$i/brightness <<< $NEW_BRIGHT
	done
else
	echo "Usage: $0 up | $0 down"
fi
