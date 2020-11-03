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

# environment vars
export _JAVA_AWT_WM_NONREPARENTING=1
export R_ENVIRON_USER="$HOME/.config/R/Renviron"
export LESSHISTSIZE=0
export WINEPREFIX="$HOME/.local/share/wine/"
export PYLINTHOME="$HOME/.local/share/pylint/"
export CARGO_HOME="$HOME/.cache/cargo/"
export EMACSDIR="$HOME/.config/emacs/"
export DOOMDIR="$HOME/.config/doom/"
export DOOMLOCALDIR="$HOME/.config/emacs/.local/"
export TEXMFVAR="$HOME/.cache/texlive/"
export TEXMFCONFIG="$HOME/.config/texlive/"

# programs
xrandr --output eDP1 --auto --right-of HDMI-0 --primary
xset r rate 250 30
setxkbmap -option caps:escape
feh --no-fehbg --no-xinerama --bg-fill '/media/TheAnes/Pictures/Backgrounds/background.png'
xautolock -time 30 -locker "systemctl suspend" -detectsleep &
picom &
dwmblocks &
xbindkeys -f $HOME/.config/xbindkeys/xbindkeysrc
xclickroot -r $HOME/.local/bin/xmenu.sh &
exec dwm

