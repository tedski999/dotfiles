# Defined in - @ line 1
function spss --wraps='sudo pacman -Ss' --description 'alias spss sudo pacman -Ss'
  sudo pacman -Ss $argv;
end
