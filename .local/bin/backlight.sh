#!/bin/sh

BACKLIGHT_PATH="/sys/class/backlight/intel_backlight"
CUR_BRIGHTNESS="$(cat $BACKLIGHT_PATH/brightness)"
MAX_BRIGHTNESS="$(cat $BACKLIGHT_PATH/max_brightness)"

if [[ "$1" == "" ]]; then
	echo "$(( $(( $CUR_BRIGHTNESS * 100 )) / $MAX_BRIGHTNESS ))"
else
	BRIGHTNESS_STEP=$(( $(( $MAX_BRIGHTNESS / 100 )) * $1 ))
	NEW_BRIGHTNESS=$(( $CUR_BRIGHTNESS + $BRIGHTNESS_STEP ))
	if [[ "$NEW_BRIGHTNESS" -lt 0 ]]; then
		NEW_BRIGHTNESS=0
	elif [[ "$NEW_BRIGHTNESS" -gt "$MAX_BRIGHTNESS" ]]; then
		NEW_BRIGHTNESS="$MAX_BRIGHTNESS"
	fi
	echo "$NEW_BRIGHTNESS" > "$BACKLIGHT_PATH/brightness"
fi

