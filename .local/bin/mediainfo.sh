#!/bin/bash

notificationID="142857"
icon="audio-radio"
title="$(playerctl metadata title)"
message="$(playerctl metadata artist)"

if [[ -z "$title"  ]] || [[ -z "$message" ]]; then
	title="No media information found!"
	message="Are you sure somethings playing?"
fi

dunstify -a "removeFromHistory" -u "low" -i "$icon" -r "$notificationID" "$title" "$message"

