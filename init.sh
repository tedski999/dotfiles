#!/usr/bin/env sh

DOTS_HOME="$HOME/.local/dots"
DOTS_GITREPO="https://github.com/tedski999/dotfiles"

hash git || exit 1
alias dots="git --git-dir "$HOME/.local/dots" --work-tree "$HOME""

filter=""
while [ -z "$filter" ]; do
	printf "Installation type (all / min): "
	read input
	case "$input" in
		all) filter=".config .gnupg .local .xinitrc" ;;
		min) filter=".config/fish .config/git .config/nvim .config/user-dirs.dirs .config/user-dirs.locale .gnupg" ;;
	esac
done

mkdir -p $DOTS_HOME || { 2>&1 echo "Error: Unable to create dots home directory!"; exit 1; }
if ! dots status &>/dev/null; then
	git clone --bare $DOTS_GITREPO $DOTS_HOME || { 2>&1 echo "Error: Unable to clone dotfiles!"; exit 1; }
fi
dots checkout --theirs master -- $filter || { 2>&1 echo "Error: Unable to checkout dotfiles!"; exit 1; }
dots reset . 1>/dev/null
dots update-index --assume-unchanged $(dots diff --name-only)

# TODO: should this script handle installing required packages?
#WORKSTATION_PACKAGES="acpi bat betterdiscord-installer borg brave-bin bspwm
#btop calc clipmenu didyoumean-bin diff-so-fancy discord dunst efibootmgr exa
#fish hsetroot jq kitty lf light mpv neofetch neovim networkmanager
#noto-fonts noto-fonts-cjk noto-fonts-emoji nvidia nvtop otf-latin-modern
#pacman-contrib picom pipewire pipewire-alsa pipewire-jack pipewire-pulse
#polybar pulsemixer rofi rsync socat steam sxhkd terminus-font-ttf
#ttf-nerd-fonts-symbols-2048-em wireplumber xautolock xclip xorg-xinit
#xorg-xinput xorg-xset xorg-xsetroot zathura zathura-pdf-mupdf zip"
#MINIMAL_PACKAGES="fish gnupg neovim exa gcc"

# chsh -s /usr/bin/fish
