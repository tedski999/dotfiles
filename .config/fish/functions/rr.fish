function rr
set PREV_OUTPUT (eval (history | head -1))
echo $PREV_OUTPUT | xclip -selection c
echo "Copied '$PREV_OUTPUT'."
end
