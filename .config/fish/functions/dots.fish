function dots --wraps=git --description "git-versioned dotfiles"
	git --git-dir=$HOME/.local/dots/ --work-tree=$HOME $argv
end
