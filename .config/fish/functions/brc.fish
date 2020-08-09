# Defined in - @ line 1
function brc --wraps='vim ~/.bashrc' --description 'alias brc vim ~/.bashrc'
	vim ~/.bashrc $argv;
end
