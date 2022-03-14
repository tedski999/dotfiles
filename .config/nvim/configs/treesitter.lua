local function config()
	require("nvim-treesitter.configs").setup({
		highlight = { enable = true },
		-- matchup = { enable = true },
		-- indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<leader>vv",
				node_incremental = "<leader>vn",
				scope_incremental = "<leader>vs",
				node_decremental = "<leader>vN"
			}
		}
	})
end

return { "nvim-treesitter/nvim-treesitter", config = config }
