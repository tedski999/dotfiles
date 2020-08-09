#!/bin/sh

sendNetworkNotification() {
	notifTitle="Not connected to any network!"
	notifMessage="alas, no internet :("
	notifIcon="network-wired-unavailable"
	for devStatus in $(nmcli -t -f STATE,DEVICE,TYPE dev status); do
		if [[ "$(awk -F':' '{print $1}' <<< $devStatus)" == "connected" ]]; then
			devName="$(awk -F':' '{print $2}' <<< $devStatus)"
			devType="$(awk -F':' '{print $3}' <<< $devStatus)"
			notifTitle="Network Connected, No Internet"
			notifMessage="Using device $devName ($devType)"
			wget -q --spider http://google.com
			if [[ $? -eq 0 ]]; then
				notifTitle="Connected to the Internet!"
				notifIcon="network-wired"
			fi
		fi
	done
	dunstify -i "$notifIcon" -r "142857" -a "removeFromHistory" "$notifTitle" "$notifMessage"
}

performInternetSpeedTest() {
	dunstify -i "network-wired" -r "142858" -a "removeFromHistory" -t 0 "Performing Internet Speed Test..." "Please be patient :)"
	dunstify -i "network-wired" -r "142858" -t 0 "Internet Speed Test Results" "$(speedtest-cli --simple)"
}

case "$1" in
	1) sendNetworkNotification ;;
	2) performInternetSpeedTest ;;
	3) st -c centered-term -g 150x50 -e nmtui ;;
esac
