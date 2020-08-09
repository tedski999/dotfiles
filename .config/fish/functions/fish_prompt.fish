function fish_prompt --description "Write out the left-hand prompt"
	echo ""

	# write name and host
    set_color $fish_color_user
    echo -n $USER@(prompt_hostname)" "

	# write working directory
    set_color $fish_color_cwd
    echo (prompt_pwd)

	# input prompt
    set_color normal
    echo -n "> "
end

