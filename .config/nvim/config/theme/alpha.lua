local function config()
	local winheight = vim.api.nvim_win_get_height(0)

	local width = 16
	local header = {"", "💻"}

	if winheight >= 32 then
		header = {
			[[                    .--..     ]],
			[[                 .-===-----.. ]],
			[[               .-=====--------]],
			[[  ..         .========--------]],
			[[.----.     .========='.-------]],
			[['-=====-.-========'   .-------]],
			[[  '-===========-'     .-------]],
			[[    -=========:       .-------]],
			[[  .=+++========-.     .-------]],
			[[.=+++++=''========-   .-------]],
			[['=++='     '========-..-------]],
			[[  ''         '-========-------]],
			[[               '-======-------]],
			[[                 '-====-----' ]],
			[[                              ]]
		}
		width = header[1]:len()
	elseif winheight >= 24 then
		header = {
			[[             :=:.   ]],
			[[          .-===-----]],
			[[ ..     .-=====-----]],
			[[:===-.:=====-' -----]],
			[[ '=======:'    -----]],
			[[ .++=====:.    -----]],
			[[-+++-':-====-. -----]],
			[[ ''     '-=====-----]],
			[[          '-===----']],
			[[            '-=--'  ]]
		}
		width = header[1]:len()
	end

	local function button(shortcut, txt, keybind)
		local opts = {
			position = "center",
			width = width,
			shortcut = shortcut,
			align_shortcut = "right",
			hl_shortcut = "Keyword",
			keymap = {"n", shortcut, keybind, {}}
		}
		local function on_press()
			local key = vim.api.nvim_replace_termcodes(keybind, true, true, true)
			vim.api.nvim_feedkeys(key, "t", true)
		end
		return {type = "button", val = txt, on_press = on_press, opts = opts}
	end

	local buttons = {
		button("e", "New file",       "<cmd>enew<cr>"),
		button("o", "Open recent",    "<cmd>Telescope oldfiles<cr>"),
		button("p", "Open project",   "<cmd>Telescope projects<cr>"),
		button("u", "Update plugins", "<cmd>PackerSync<cr>"),
		button("f", "Search file",    "<cmd>Telescope find_files<cr>"),
		button("s", "Search text",    "<cmd>Telescope live_grep<cr>"),
		button("q", "Quit",           "<cmd>quit<cr>")
	}

	local v = vim.version()
	local plugin_footer = "Loaded " .. #vim.tbl_keys(packer_plugins) .. " plugins"
	local version_footer = string.format("Neovim v%s.%s.%s", v.major, v.minor, v.patch)

	require("alpha").setup({
		opts = {},
		layout = {
			{type = "text", val = header, opts = {position = "center", hl = "Keyword"}},
			{type = "padding", val = 1},
			{type = "group", val = buttons, opts = {spacing = 1}},
			{type = "padding", val = 1},
			{type = "text", val = plugin_footer, opts = {position = "center"}},
			{type = "text", val = version_footer, opts = {position = "center", hl = "Keyword"}}
		},
	})
end

return { "goolord/alpha-nvim", config = config }
