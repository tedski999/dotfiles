## Huzzah, dotfiles

My personal Linux scripts and configs, all in one place.

```bash
git clone --bare https://github.com/tedski999/dotfiles.git $HOME/.local/dots
alias dots="git --git-dir=$HOME/.local/dots/ --work-tree=$HOME"
dots config --local status.showUntrackedFiles no
dots checkout
```
