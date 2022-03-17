local function config()
	vim.cmd([[
	colorscheme gotham
	highlight EndOfBuffer guifg=bg
	highlight! link Pmenu NormalFloat
	highlight! link Pmenu FloatBorder
	highlight! link MatchParen Visual
	]])
end

return { "whatyouhide/vim-gotham", config = config }
