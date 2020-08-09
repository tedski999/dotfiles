#!/bin/sh

if [[ "$(checkupdates | wc -l)" -eq "0" ]]; then
	dunstify -i "cloudstatus" "No Updates Available" "Maybe you've already updated the system?"
else
	case "$1" in
		1) st -t "pacman update" -c "centered-term" -g "150x50" -e sudo pacman -Syu && sigdwmblocks 7 ;;
		2) sigdwmblocks 7 && dunstify -i "cloudstatus" "Refreshed Pacman Dwmblock" "maybe its magically disappeared?" ;;
		3) dunstify -i "cloudstatus" "Updates available:" "$(checkupdates)" ;;
	esac
fi
