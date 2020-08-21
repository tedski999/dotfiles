#!/bin/sh

volume="$(pamixer --get-volume)"
if [[ "$(pamixer --get-mute)" == "true" ]]; then
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
