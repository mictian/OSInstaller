#!/bin/bash

## Swap Caps Lock by Esc
xmodmap /home/mictian/.config.custom/keySwapper &

## Start BitTorrent Sync
# . /home/mictian/programs/bittorrent_sync_x64/btsync &

## Configure dual monitors
. /home/mictian/.config.custom/screenLayout.sh &

blueman-applet &

