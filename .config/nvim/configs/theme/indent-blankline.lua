local function config()
	require("indent_blankline").setup({
		viewport_buffer = 30,
		filetype_exclude = {"lspinfo","help","man","startify"},
		show_trailing_blankline_indent = false,
		char_highlight_list = {"SpecialKey"},
		char = "𑗅"
	})
end

return { "lukas-reineke/indent-blankline.nvim", event = "BufRead", config = config }
