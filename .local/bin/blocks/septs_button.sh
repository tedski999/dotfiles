#!/bin/bash

sendWebsiteStatusNotification() {
		dunstify "todo" "tjsj.dev website status"
}

sendServerStatusNotification() {
		dunstify "todo" "septs server status"
}

case "$1" in
	1) sendWebsiteStatusNotification ;;
	2) st -t "ssh connection to $USER@septs" -c centered-term -g 150x50 -e ssh tjsj.dev ;;
	3) sendServerStatusNotification ;;
esac
