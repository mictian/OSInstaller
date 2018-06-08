#!/bin/bash

# Based on:
# https://wiki.archlinux.org/index.php/backlight

RULE_CONTENT=""
for i in $( ls  /sys/class/backlight/ ); do
	new_rule="ACTION==\"add\", SUBSYSTEM==\"backlight\", KERNEL==\"$i\", RUN+=\"/bin/chgrp video /sys/class/backlight/%k/brightness\"
ACTION==\"add\", SUBSYSTEM==\"backlight\", KERNEL==\"$i\", RUN+=\"/bin/chmod g+w /sys/class/backlight/%k/brightness\""

	RULE_CONTENT="$RULE_CONTENT"$'\n'"$new_rule"
done

if [ ! -f "/etc/udev/rules.d/backlight.rules" ]; then
	sudo touch /etc/udev/rules.d/backlight.rules
fi

echo "$RULE_CONTENT"$'\n' | sudo tee -a /etc/udev/rules.d/backlight.rules > /dev/null
