#!/bin/sh

# environment vars
export TERM="xterm-256color"
export TERMINAL="alacritty"
export EDITOR="emacsclient -qca emacs -nw"
export VISUAL="emacsclient -qca emacs"
export BROWSER="brave"
export GTK_THEME="Materia:dark"
export GTK2_RC_FILES="/usr/share/themes/Materia-dark/gtk-2.0/gtkrc"
export _JAVA_AWT_WM_NONREPARENTING=1
export PATH=$PATH:$HOME/.local/bin
GPG_TTY=$(tty)
export GPG_TTY

# part of the never-ending quest for a clean home directory
export LESSHISTFILE="-"
export TEXMFVAR="$HOME/.cache/texlive/"
export TEXMFCONFIG="$HOME/.config/texlive/"
export WINEPREFIX="$HOME/.local/share/wine/"
export R_ENVIRON_USER="$HOME/.config/R/Renviron"
export NODE_REPL_HISTORY="$HOME/.local/share/node/repl_history"
export PYTHONSTARTUP="$HOME/.config/python/startup"
export GRADLE_USER_HOME="$HOME/.local/share/gradle/"
export CARGO_HOME="$HOME/.local/share/cargo"
export GOPATH="$HOME/.local/share/go"
export STACK_ROOT="$HOME/.local/share/stack"

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

exec mman display start
