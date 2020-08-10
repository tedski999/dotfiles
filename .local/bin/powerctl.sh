#!/bin/bash

choice=$(echo -e "Lock\nSuspend\nLogout\nReboot\nShutdown" | dmenu -i -c -l 12 -bw 0 -fn "xos4 Terminus:size=10" -nf "#bbbbbb" -sf "#eeeeee" -nb "#000000" -sb "#800060")

dwmpid=$(pgrep dwm)
case "$choice" in
	
	Lock)
		slock &
		;;
	
	Suspend)
		systemctl suspend
		;;
	
	Logout)
		kill -TERM $dwmpid
		;;

	#Reload)
		#kill -HUP $dwmpid
		#;;	
	
	Reboot)
		kill -TERM $dwmpid
		shutdown -r now
		;;
	
	Shutdown)
		kill -TERM $dwmpid
		shutdown -h now
		;;
esac
