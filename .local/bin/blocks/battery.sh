#!/bin/sh

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)
filePath="$HOME/.local/batteryinfo"
previousCapacity=$(cat "$filePath" 2>/dev/null || echo 100)
echo "$capacity" > "$filePath"

if [[ "$status" == "Full" ]]; then
	color="\x10"
	icon="🔌"
elif [[ "$status" == "Charging" ]]; then
	color="\x0e"
	icon="🗲"
elif [[ "$status" == "Discharging" ]]; then
	if [[ $capacity -gt 20 ]]; then
		color="\x0e"
		icon="🔋"
	else
		color="\x11"
		icon="🗲 !"
		if [[ $capacity -le 10 && $previousCapacity -gt 10 ]]; then
			dunstify -u critical -i "battery-010" "Battery Low!" "10% remaining! Maybe consider looking for the charger?"
		elif [[ $capacity -le 5 && $previousCapacity -gt 5 ]]; then
			dunstify -u critical -i "battery-000" "Battery Very Low!" "5% remaining! I'm literially about to fucking die, please send hel"
		elif [[ $capacity -le 3 ]]; then
			dunstify -u critical -i "battery-000" "Entering emergency suspended state..." "screw you, im out"
			systemctl suspend
		fi
	fi
else
	color="\x0f"
	icon="🗲 ?"
fi

echo -e "$color $icon \x0b"

