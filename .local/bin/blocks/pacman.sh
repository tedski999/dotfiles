#!/bin/bash

count="$(checkupdates | wc -l)"
if [[ "$count" != 0 ]]; then
	color="\x0e"
	if [[ "$count" -gt "9" ]]; then
		color="\x11"
	fi
	echo -e "$color $count 📦 \x0b"
else
	echo -e ""
fi
