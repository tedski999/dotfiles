#!/bin/sh

SSPATH="/tmp/screenshot.png"

if [[ "$1" == "" ]]; then
	maim $SSPATH
elif [[ "$1" == "sel" ]]; then
	maim -uslc 1,1,1,0.05 $SSPATH
else
	echo "Usage: cutscreen [sel]" 2>&1
	exit 1
fi

xclip $SSPATH -selection clipboard -t image/png
dunstify -a "removeFromHistroy" -i $SSPATH "Screenshot saved to clipboard!" "$(identify -precision 4 -format '%b - %G %m' $SSPATH)"

