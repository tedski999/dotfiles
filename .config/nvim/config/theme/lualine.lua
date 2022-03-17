local function config()
	local theme = require("lualine.themes.auto")
	theme.insert.c, theme.insert.b = theme.insert.b, theme.insert.c
	theme.visual.c, theme.visual.b = theme.visual.b, theme.visual.c
	theme.replace.c, theme.replace.b = theme.replace.b, theme.replace.c
	theme.command.c, theme.command.b = theme.command.b, theme.command.c
	theme.inactive.c, theme.inactive.b = theme.inactive.b, theme.inactive.c
	require("lualine").setup({
		extensions = { "fzf" },
		options = {
			theme = theme,
			icons_enabled = false,
			section_separators = "",
			component_separators = ""
		},
		sections = {
			lualine_a = { {"mode", fmt = function(mode) return mode:sub(1,1) end} },
			lualine_b = { "diff", "branch" },
			lualine_c = { { "filename", symbols = { modified = " *", readonly = " -" } } },
			lualine_x = {},
			lualine_y = { { "diagnostics", sections = { "error", "warn" } }, "filetype" },
			lualine_z = { "location", "progress" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { "filename", symbols = { modified = " *", readonly = " -" } } },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {}
		},
	})
end

return { "nvim-lualine/lualine.nvim", after = "vim-gotham", config = config }
