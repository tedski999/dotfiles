local function config()
	vim.cmd([[colorscheme gotham]])
	vim.o.termguicolors = true
end

return { "whatyouhide/vim-gotham", config = config }
