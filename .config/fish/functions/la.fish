# Defined in - @ line 1
function la --wraps='exa -lahs=name --git --group-directories-first' --wraps=ls --description 'alias la exa -lahs=name --git --group-directories-first'
  exa -lahs=name --git --group-directories-first $argv;
end
