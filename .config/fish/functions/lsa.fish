# Defined in - @ line 1
function lsa --wraps='ls --color=auto -la' --description 'alias lsa ls --color=auto -la'
	ls --color=auto -la $argv;
end
