
# Start X at login
if status is-login
	if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
		exec startx -- -keeptty >/dev/null 2>&1
	end
end

# Custom git prompt
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

# spoof commenly supported terminal
set -x TERM "xterm-256color"

# bat as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Override command not found handler
function __fish_command_not_found_handler --on-event fish_command_not_found
	functions --erase __fish_command_not_found_setup
    echo "fish: Unknown command '$argv'"
end

