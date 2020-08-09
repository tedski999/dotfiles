#!/bin/sh

color="\x0e"
ping -qc 1 -w 2 tjsj.dev &> /dev/null
if [[ "$?" -eq "0" ]]; then
	color="\x10"
else
	color="\x11"
fi

echo -e "$color ⌂ \x0b"

