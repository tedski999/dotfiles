# Defined in - @ line 1
function ls --wraps='COLUMNS=80 exa -as=name --group-directories-first' --description 'alias ls COLOUMNS=80 exa -as=name --group-directories-first'
	COLUMNS=80 exa -as=name --group-directories-first $argv;
end
