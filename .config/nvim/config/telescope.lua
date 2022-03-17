local function config()
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			borderchars = {"─","│","─","│","┌","┐","┘","└"},
			file_ignore_patterns = {"^node_modules/","^./.git/"},
			mappings = {
				i = {
					["<tab>"] = actions.move_selection_previous,
					["<s-tab>"] = actions.move_selection_next,
					["<down>"] = actions.preview_scrolling_down,
					["<up>"] = actions.preview_scrolling_up,
					["<c-space>"] = actions.select_default,
					["<c-s>"] = actions.select_horizontal,
					["<esc>"] = actions.close,
				}
			}
		},
		pickers = {
			find_files = { hidden = true },
			git_files = { hidden = true },
			live_grep = { additional_args = function() return {"--hidden"} end }
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true
			}
		}
	})

	require("telescope").load_extension("fzf")
end

return {
	"nvim-telescope/telescope.nvim",
	config = config,
	requires = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	}
}
