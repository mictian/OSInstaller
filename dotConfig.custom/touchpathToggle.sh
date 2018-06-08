#!/bin/bash
TOUCHPATH_DRIVER="SYNA2B29:00 06CB:77C6"

TOUCHPATH_ENABLE_STATE=`xinput list-props "$TOUCHPATH_DRIVER" | grep -oP 'Device Enabled[^:]*:[^0-9]*\K([0-9]+)'`

if [ $TOUCHPATH_ENABLE_STATE = "0" ]
then
	xinput set-prop "$TOUCHPATH_DRIVER" "Device Enabled" 1
else
	xinput set-prop "$TOUCHPATH_DRIVER" "Device Enabled" 0
fi