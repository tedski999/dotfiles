#!/bin/bash

if [[ "$(playerctl status 2>/dev/null)" == "Playing" ]]; then
	title=$(playerctl metadata title)
	artist=$(playerctl metadata artist)
	if   [[ -n "$title" && -n "$artist" ]]; then
		echo "  $title <$artist> "
	elif [[ -n "$title" || -n "$artist" ]]; then
		echo "  $title$artist "
	else
		echo "  Unknown media playing "
	fi
else
	echo ""
fi
