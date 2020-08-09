function fish_right_prompt --description "Write out the right-hand prompt"
	set lastStatus $status

	# write git repo status
	fish_git_prompt

	# write previous commands error code
	if test $lastStatus != 0
		set_color $fish_color_error
		echo -n " $lastStatus"
	end

	set_color normal
end
