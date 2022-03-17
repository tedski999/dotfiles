local function config()
	vim.g.tagbar_compact = 2
	vim.g.tagbar_autofocus = 1
	vim.g.tagbar_show_data_type = 1
	vim.g.tagbar_silent = 1
end

return { "preservim/tagbar", config = config }
