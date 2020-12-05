
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Customization
export HISTFILE=${HOME}/.local/share/bash/history
alias ls='ls --color=auto'
alias la='ls -la'
alias anes='cd /media/TheAnes/'
alias projects='cd /media/TheAnes/Projects/'
alias septs='ssh tjsj.dev'
shopt -s autocd histappend
PS1="\[\033[38;5;1m\]\n\u@\H \[$(tput sgr0)\]\[\033[38;5;4m\]\w \[$(tput sgr0)\]\n> \[$(tput sgr0)\]"

echo -e "\033[33;3m"
fortune -sn 50 $(find /usr/share/fortune/ -type f ! -name "*.*"  ! -name "zippy" ! -name "translate-me" ! -name "sports" ! -name "goedel" ! -name "definitions")
echo -e "\033[0m"

