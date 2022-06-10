#!/bin/bash

trap "$TERMINAL -e yay" 10 # USR1 to do system update
trap ":" 12 # USR2 to force refresh update counter

while true; do
	updates_arch="$(checkupdates 2>/dev/null | wc -l)"
	updates_aur="$(yay -Qum 2>/dev/null | wc -l)"
	updates="$(( ${updates_arch:-0} + ${updates_aur:-0} ))"
	[ "$updates" -ne 0 ] && echo "$updates " || echo ""
	sleep 600 &
	wait
done
