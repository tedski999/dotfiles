#!/bin/sh

# environment vars
export PATH=$PATH:"/home/tedski999/.local/bin/"
export TERM="xterm-256color"
export EDITOR="nvim"
export BROWSER="firefox"
export GTK_THEME="Materia:dark"
export GTK2_RC_FILES="/usr/share/themes/Materia-dark/gtk-2.0/gtkrc"
export LESSHISTFILE="-"
export TEXMFVAR="$HOME/.cache/texlive/"
export TEXMFCONFIG="$HOME/.config/texlive/"
export WINEPREFIX="$HOME/.local/share/wine/"
export R_ENVIRON_USER="$HOME/.config/R/Renviron"
export PYTHONSTARTUP="$HOME/.cache/python/startup"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot='.config/java' -Dorg.basex.path='.local/share/basex'"
export _JAVA_AWT_WM_NONREPARENTING=1

# start xinitrc.d programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# input config
xset r rate 250 30
setxkbmap -option caps:escape
xinput --set-prop "DELL086F:00 06CB:7E92 Touchpad" "libinput Natural Scrolling Enabled" 1
xinput --set-prop "DELL086F:00 06CB:7E92 Touchpad" "libinput Tapping Enabled" 1

# start i3 & co.
exec i3

