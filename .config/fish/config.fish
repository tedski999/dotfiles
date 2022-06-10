
set -gx GPG_TTY (tty)

function __fish_command_not_found_handler --on-event fish_command_not_found
	functions --erase __fish_command_not_found_setup
	echo "fish: Unknown command '$argv'"
end

if status is-interactive
	set -g __fish_git_prompt_show_informative_status 1
	set -g __fish_git_prompt_hide_untrackedfiles 1
	set -g __fish_git_prompt_color_branch magenta
	set -g __fish_git_prompt_showupstream "informative"
	set -g __fish_git_prompt_char_upstream_ahead "↑"
	set -g __fish_git_prompt_char_upstream_behind "↓"
	set -g __fish_git_prompt_char_upstream_prefix ""
	set -g __fish_git_prompt_char_stagedstate "●"
	set -g __fish_git_prompt_char_dirtystate "○"
	set -g __fish_git_prompt_char_untrackedfiles "…"
	set -g __fish_git_prompt_char_conflictedstate "✖"
	set -g __fish_git_prompt_char_cleanstate "✔"
	set -g __fish_git_prompt_color_dirtystate blue
	set -g __fish_git_prompt_color_stagedstate green
	set -g __fish_git_prompt_color_invalidstate brred
	set -g __fish_git_prompt_color_untrackedfiles brred
	set -g __fish_git_prompt_color_cleanstate brgreen
end

if status is-login
	set -gxa PATH "$HOME/.local/bin"

	# Default programs
	set -gx TERMINAL "kitty"
	set -gx EDITOR "nvim"
	set -gx VISUAL "nvim"
	set -gx BROWSER "brave"
	set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

	# Program settings
	set -gx CM_LAUNCHER "rofi"
	set -gx SXHKD_SHELL "/bin/bash"
	set -gx _JAVA_AWT_WM_NONREPARENTING 1
	set -gx LIBVIRT_DEFAULT_URI "qemu:///system"
	set -gx LESSHISTFILE "-"
	set -gx NNN_OPTS "aeHiUx"
	set -gx NNN_BMS ".:~/.config;d:~/Documents;p:~/Projects;P:~/Pictures;v:~/Videos;g:~/Games"
	set -gx NNN_PLUG "p:preview-tui"

	# SSH Agent
	set -gx SSH_AGENT_PID
	set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

	# GTK Theming
	set -gx GTK_THEME "Materia:dark"
	set -gx GTK2_RC_FILES "/usr/share/themes/Materia-dark/gtk-2.0/gtkrc"

	# XDG_CONFIG_HOME
	set -gx HISTFILE "$HOME/.local/share/bash/history"
	set -gx TEXMFVAR "$HOME/.cache/texlive/"
	set -gx TEXMFCONFIG "$HOME/.config/texlive/"
	set -gx WINEPREFIX "$HOME/.local/share/wine/"
	set -gx R_ENVIRON_USER "$HOME/.config/R/Renviron"
	set -gx NODE_REPL_HISTORY "$HOME/.local/share/node/repl_history"
	set -gx PYTHONSTARTUP "$HOME/.config/python/startup"
	set -gx GRADLE_USER_HOME "$HOME/.local/share/gradle/"
	set -gx CARGO_HOME "$HOME/.local/share/cargo"
	set -gx GOPATH "$HOME/.local/share/go"
	set -gx STACK_ROOT "$HOME/.local/share/stack"
	set -gx npm_config_userconfig "$HOME/.config/npm/npmrc"
	set -gx MONO_REGISTRY_PATH "$HOME/.local/share/mono/registry"
	set -gx CALCHISTFILE "$HOME/.local/share/calc/history"
	set -gx CALCPATH ".:./cal:~/.local/share/calc:/usr/share/calc:/usr/share/calc/custom"
	set -gx CALCRC "./.calcinit:~/.config/calc/startup:/usr/share/calc/startup"

	# Start X server when logging in on tty1
	if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
		exec startx -- -keeptty >/dev/null 2>&1
	end
end
