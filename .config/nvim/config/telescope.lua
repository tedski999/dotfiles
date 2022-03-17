local function config()
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			borderchars = {"─","│","─","│","┌","┐","┘","└"},
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<esc>"] = actions.close,
				}
			}
		}
	})
end

return { "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim", config = config }
