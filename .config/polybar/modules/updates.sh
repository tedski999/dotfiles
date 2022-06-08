#!/bin/bash

trap "do_update" 10 # USR1
function do_update {
	$TERMINAL -e yay
}

trap "refresh" 12 # USR2
function refresh {
	: # Do nothing
}

while true; do
	updates_arch="$(checkupdates 2>/dev/null | wc -l)"
	updates_aur="$(yay -Qum 2>/dev/null | wc -l)"
	updates="$(( ${updates_arch:-0} + ${updates_aur:-0} ))"
	[ "$updates" -ne 0 ] && echo "$updates " || echo ""
	sleep 600 &
	wait
done
