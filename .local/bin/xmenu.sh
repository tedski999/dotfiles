#!/bin/sh

icons="/usr/share/icons/Adwaita/16x16"

cat <<EOF | xmenu | sh &
apps
	Firefox		firefox
	VSCode		code
	Spotify		spotify
	Discord		discord
games
	NetHack		st -c centered-term -g 150x50 nethack
	OpenTTD		st -c centered-term -g 150x50 openttd
	CC:DDA		st -c centered-term -g 150x50 cataclysm
utils
	ranger		xdotool key alt+f
	scratchpad	xdotool key alt+p
	calculator	xdotool key alt+c
	htop		st -c centered-term -g 150x50 htop
	vim			st -c centered-term -g 150x50 vim

dmenu			xdotool key alt+space
terminal		xdotool key alt+t
system
	Control			xdotool key Super_L+Escape
	Lock			slock &
	Suspend			systemctl suspend
	Logout			killall dwm
	Reboot			shutdown -r now
	Shutdown		shutdown -h now
EOF
