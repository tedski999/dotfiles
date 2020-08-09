#!/bin/bash

notificationID="142857"
state="$(playerctl status)"
track="$(playerctl metadata title)"
artist="$(playerctl metadata artist)"

if [[ "$state" == "Playing" ]]; then
	title="Playing '$track'..."
	message="$artist"
	icon="audio-radio"
elif [[ "$state" == "Paused" ]]; then
	title="Paused '$track'."
	message="$artist"
	icon="media-playback-paused"
else
	title="Toggling media..."
	message=""
	icon="audio-radio"
fi

dunstify -a "removeFromHistory" -u "low" -i "$icon" -r "$notificationID" "$title" "$message"

