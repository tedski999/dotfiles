local function config()
	require("gitsigns").setup({
		current_line_blame_opts = { delay = 0 },
		signs = {
			add = {text = "𑗅", numhl="GitSignsAddNr", linehl="GitSignsAddLn"},
			change = {text = "𑗅", numhl="GitSignsChangeNr", linehl="GitSignsChangeLn"}
		}
	})
end

return { "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim", config = config }
