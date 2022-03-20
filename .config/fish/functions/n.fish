function n --wraps=nnn --description "alias for nnn"
	set NNN_TMPFILE "$HOME/.config/nnn/.lastd"
	rm -f $NNN_TMPFILE
	nnn $argv
	test -e $NNN_TMPFILE && source $NNN_TMPFILE
	return 0
end
