local function config()
	vim.g.lion_map_left = "<leader>l"
	vim.g.lion_map_right = "<leader>L"
	vim.g.lion_squeeze_spaces = 1
end

return { "tommcdo/vim-lion", config = config }
