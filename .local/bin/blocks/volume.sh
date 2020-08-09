#!/bin/sh

volume="$(amixer -c 0 get Master | tail -1 | awk '{print $4}' | sed 's/[^0-9]*//g')"
state="$(amixer -c 0 get Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"

if [[ "$state" == "off" ]]; then
	icon="🔇"
	color="\x0f"
elif [[ $volume -eq 0 ]]; then
	icon="🔈"
	color="\x0f"
elif [[ $volume -lt 25 ]]; then
	icon="🔈"
	color="\x0e"
elif [[ $volume -lt 75 ]]; then
	icon="🔉"
	color="\x0e"
else
	icon="🔊"
	color="\x11"
fi

echo -e "$color $icon \x0b"
