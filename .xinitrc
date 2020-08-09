#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrandr --output eDP1 --auto --right-of HDMI-0
xset r rate 250 30
feh --no-fehbg --no-xinerama --bg-fill '/media/TheAnes/Pictures/Backgrounds/lain-wide.png'
xautolock -time 30 -locker "systemctl suspend" -detectsleep &
picom &
dwmblocks &
xbindkeys
xclickroot -r $HOME/.local/bin/xmenu.sh &
exec dwm

