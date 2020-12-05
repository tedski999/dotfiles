# Defined in - @ line 1
function sps --wraps='sudo pacman -Syu' --description 'alias sps sudo pacman -Syu'
  sudo pacman -Syu $argv;
end
