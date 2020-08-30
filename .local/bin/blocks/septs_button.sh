#!/bin/bash

sendWebsiteStatusNotification() {
	dunstify -i "globe" -r "142860" -a "removeFromHistory" -t 0 "Testing www.tjsj.dev Website Health..." "Please be patient :)"
	notifMessage="$(curl https://www.tjsj.dev -so /dev/null -w "%{url_effective} (%{remote_ip}:%{remote_port})\nAverage %{speed_download} bytes/sec\n\nDNS Name Lookup:  %{time_namelookup}sec\nInitial Response: %{time_connect}sec\nTransfer Setup:   %{time_starttransfer}sec\nTotal Duration:   %{time_total}sec\n")"
	dunstify -i "globe" -r "142860" -t 0 "Health Check for www.tjsj.dev" "$notifMessage"
}

sendServerStatusNotification() {
	dunstify -i "network-modem" -r "142860" -a "removeFromHistory" -t 0 "Testing Septs Server Health..." "Please be patient :)"
	notifMessage="$(ssh tjsj.dev serverstatus)"
	dunstify -i "network-modem" -r "142860" -t 0 "Health Check for Septs" "$notifMessage"
}

case "$1" in
	1) sendWebsiteStatusNotification ;;
	2) st -t "ssh connection to $USER@septs" -c centered-term -g 150x50 -e ssh tjsj.dev ;;
	3) sendServerStatusNotification ;;
esac
