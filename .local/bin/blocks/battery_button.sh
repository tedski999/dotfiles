#!/bin/sh

sendBatteryNotification() {
	stats="$(acpi -b | awk -F': ' '{print $2}')"
	notifTitle="$(awk -F', ' '{print "Battery at "$2}' <<< $stats)"
	notifMessage="$(awk -F', ' '{print $3}' <<< $stats)"
	if [[ -z "$notifMessage" ]]; then
		notifMessage="$(awk -F', ' '{print $1}' <<< $stats)"
	fi
	dunstify -a "removeFromHistory" -i "battery-100" -r "142857" "$notifTitle" "$notifMessage"
}

case "$1" in
	1) xdotool key XF86MonBrightnessDown ;;
	2) sendBatteryNotification ;;
	3) xdotool key XF86MonBrightnessUp ;;
esac