#!/bin/sh

case "$1" in
	1) xdotool key XF86AudioLowerVolume ;;
	2) xdotool key XF86AudioMute        ;;
	3) xdotool key XF86AudioRaiseVolume ;;
esac
