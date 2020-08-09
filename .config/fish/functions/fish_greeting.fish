function fish_greeting
    set_color $fish_color_greeting
    echo ""
    fortune -sn 50 (find /usr/share/fortune/ -type f ! -name "*.*"  ! -name "zippy" ! -name "translate-me" ! -name "sports" ! -name "goedel" ! -name "definitions")
    set_color normal
end
