function fish_greeting
	set_color $fish_color_greeting
	echo ""
	eventoftheday random | shuf -n 1
	set_color normal
end
