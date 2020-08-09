#!/bin/sh

ordinal () {
	case "$1" in
		*1[0-9] | *[04-9]) echo "$1"th ;;
		*1) echo "$1"st ;;
		*2) echo "$1"nd ;;
		*3) echo "$1"rd ;;
	esac
}

sendDetailedNotification() {
	notifTitle="The time is $(date "+%T %Z (%:z)")"
	notifMessage="It is $(date "+%A the $(ordinal $(date '+%-d')) of %B, %Y")"
	dunstify -a "removeFromHistory" -i "clock" -r "142857" "$notifTitle" "$notifMessage"
}

sendVerboseNotification() {
	notifTitle="$(date "+%T.%3N %Z (%:z)")"
	notifMessage="$(date "+%x - $(ordinal $(date '+%-d')) of %B, %Y (%a)%n$(ordinal $(date '+%-q')) Quarter, $(ordinal $(date '+%-W')) Week, $(ordinal $(date '+%-j')) Day")"
	dunstify -a "removeFromHistory" -i "clock" -r "142857" "$notifTitle" "$notifMessage"
}

openTimeDateChanger() {
	notify-send "TODO: changing the time and date"
}

case "$1" in
	1) sendDetailedNotification ;;
	2) openTimeDateChanger ;;
	3) sendVerboseNotification ;;
esac

