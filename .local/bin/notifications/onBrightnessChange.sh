#!/bin/bash

notificationID="142857"
brightness="$(xbacklight | cut -d. -f1)"
title="Brightness: $brightness%"

if [[ $brightness -eq 0 ]]; then
	icon="flashlight-off"
	message="ah help im blind"
else
	icon="flashlight-on"
	unset message
	for i in {0..100..4}
	do
		if [[ $brightness -gt $i ]]; then message=$message"▆ "; fi
	done
fi

dunstify -a "removeFromHistory" -u "low" -i "$icon" -r "$notificationID" "$title" "$message"
