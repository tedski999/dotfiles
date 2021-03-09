function fish_greeting
	set_color $fish_color_greeting
	echo ""
	eventoftheday -t events,holidays
	set_color normal
end
