#!/bin/sh

#DUAL Monitor (one next to the other)
#xrandr --output HDMI1 --off --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP1 --mode 1920x1080 --pos 1920x0 --rotate normal --output VIRTUAL1 --off
#xrandr --output HDMI1 --off --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP1 --mode 1600x900 --pos 1920x180 --rotate normal --output VIRTUAL1 --off

# sleep 1
#xrandr --output HDMI1 --off --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP1 --mode 1600x900 --pos 1920x180 --rotate normal --output VIRTUAL1 --off

#sleep 2
#xrandr --output HDMI1 --off --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP1 --mode 1600x900 --pos 1920x180 --rotate normal --output VIRTUAL1 --off

#DUAL Monitor (one on top of the other)
xrandr --output HDMI1 --off --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP1 --mode 1920x1080 --pos 0x1080 --rotate normal --output VIRTUAL1 --off

sleep 1
xrandr --output HDMI1 --off --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP1 --mode 1920x1080 --pos 0x1080 --rotate normal --output VIRTUAL1 --off

sleep 2
xrandr --output HDMI1 --off --output DP1 --mode 1920x1080 --pos 0x0 --rotate normal --output eDP1 --mode 1920x1080 --pos 0x1080 --rotate normal --output VIRTUAL1 --off



#SINGLE Monitor
#sleep 1
#xrandr --output HDMI1 --off --output DP1 --off --output eDP1 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

#sleep 2
#xrandr --output HDMI1 --off --output DP1 --off --output eDP1 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

exit
