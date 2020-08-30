#!/bin/sh

sendBatteryNotification() {
	batMax="$(cat /sys/class/power_supply/BAT0/charge_full)"
	batNow="$(cat /sys/class/power_supply/BAT0/charge_now)"
	percent="$(echo $batNow / $batMax * 100 | bc -l)"
	notifTitle="Battery at ${percent::-17}%"
	notifMessage="$(acpi -b | awk -F', ' '{print $3}')"
	if [[ -z "$notifMessage" ]]; then
		notifMessage="$(acpi -b | awk -F': ' '{print $2}')"
	fi
	dunstify -a "removeFromHistory" -i "battery-100" -r "142857" "$notifTitle" "$notifMessage"
}

case "$1" in
	1) xdotool key XF86MonBrightnessDown ;;
	2) sendBatteryNotification ;;
	3) xdotool key XF86MonBrightnessUp ;;
esac
