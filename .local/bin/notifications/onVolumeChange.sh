#!/bin/bash

notificationID="142857"
volume="$(pamixer --get-volume)"
if [[ $volume == 0 || "$(pamixer --get-mute)" == "true" ]]; then
	title="Volume: muted"
	message="no music :("
	icon="audio-volume-muted"
else
	title="Volume: $(pamixer --get-volume-human)"
	if [[ $volume -lt 25 ]]; then
		icon="audio-volume-low"
	elif [[ $volume -lt 75 ]]; then
		icon="audio-volume-medium"
	else
		icon="audio-volume-high"
	fi

	unset message
	for i in {0..100..4}
	do
		if [[ $volume -gt $i ]]; then message=$message"▆ "; fi
	done
fi

sigdwmblocks 3
dunstify -a "removeFromHistory" -u "low" -i "$icon" -r "$notificationID" "$title" "$message"

