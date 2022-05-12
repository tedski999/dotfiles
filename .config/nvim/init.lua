
-- TODO:
-- fix bootstrapping (+ list dependencies for mman)
-- fix reloading this file on save (lsp servers duplicated)
-- treesiter stability? + horizontal scrolling
-- add git keybindings as i need them

pcall(require, "impatient")

local initfile = vim.fn.resolve(vim.fn.stdpath("config") .. "/init.lua")

-- Install packer.nvim if not already
local packer_bootstrap = false
local packer_installdir = vim.fn.resolve(vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim")
if vim.fn.empty(vim.fn.glob(packer_installdir)) > 0 then
	packer_bootstrap = vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_installdir})
	vim.cmd([[packadd packer.nvim]])
end

-- Plugins
require("packer").startup({

	function(use)

		-- Plugin management and optimisation --

		use({"wbthomason/packer.nvim", config = function()
			vim.keymap.set({"n","v"}, "<leader>pp", "<cmd>PackerStatus<cr>")
			vim.keymap.set({"n","v"}, "<leader>pc", "<cmd>PackerCompile<cr>")
			vim.keymap.set({"n","v"}, "<leader>ps", "<cmd>PackerSync<cr>")
		end})

		use({"lewis6991/impatient.nvim"})

		use({"nathom/filetype.nvim"})

		-- Theming and presentation --

		use({"whatyouhide/vim-gotham", config = function()
			vim.cmd([[
				colorscheme gotham
				" Spelling
				highlight SpellBad guibg=NONE guifg=NONE gui=undercurl guisp=Red
				highlight SpellCap guibg=NONE guifg=NONE gui=undercurl guisp=Blue
				highlight SpellRare guibg=NONE guifg=NONE gui=undercurl guisp=Purple
				highlight SpellLocal guibg=NONE guifg=NONE gui=undercurl guisp=Yellow
				" Popup windows
				highlight Pmenu ctermfg=14 ctermbg=8 guifg=#599cab guibg=#11151c
				highlight link NormalFloat Pmenu
				highlight link FloatBorder Pmenu
				highlight link TelescopeNormal Pmenu
				highlight link TelescopeBorder Pmenu
				highlight link TelescopePromptBorder Pmenu
				highlight link TelescopeResultsBorder Pmenu
				highlight link TelescopePreviewBorder Pmenu
				" Code errors and warnings
				highlight DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
				highlight DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
				highlight DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
				highlight DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold
				sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
				sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
				sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
				sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
				" Highlight trailing and misplaced whitespace
				highlight ExtraWhitespace guibg=Red guifg=Red
				match ExtraWhitespace /\s\+$\| \+\ze\t/
				autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
				autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/
				autocmd InsertLeave * match ExtraWhitespace /\s\+$\| \+\ze\t/
				autocmd BufWinLeave * call clearmatches()
				" Misc
				highlight StatusLine guibg=#0c1014
				highlight StatusLineNC guibg=#0c1014
				highlight EndOfBuffer guifg=bg
			]])
		end})

		use({"nvim-lualine/lualine.nvim", config = function()
			require("lualine").setup({
				extensions = {"fugitive"},
				options = {
					icons_enabled = false,
					section_separators = "",
					component_separators = "",
					disabled_filetypes = {"alpha"},
					theme = {
						normal =   {a = {bg = "#195466", fg = "#d3ebe9", gui = "bold"}, b = {bg = "#091f2e", fg = "#599cab"}, c = {bg = "#0c1014", fg = "#1e6479"}},
						insert =   {a = {bg = "#2aa889", fg = "#d3ebe9", gui = "bold"}, b = {bg = "#091f2e", fg = "#599cab"}, c = {bg = "#0c1014", fg = "#1e6479"}},
						visual =   {a = {bg = "#d25010", fg = "#d3ebe9", gui = "bold"}, b = {bg = "#091f2e", fg = "#599cab"}, c = {bg = "#0c1014", fg = "#1e6479"}},
						replace =  {a = {bg = "#d21117", fg = "#d3ebe9", gui = "bold"}, b = {bg = "#091f2e", fg = "#599cab"}, c = {bg = "#0c1014", fg = "#1e6479"}},
						command =  {a = {bg = "#4e5166", fg = "#d3ebe9", gui = "bold"}, b = {bg = "#091f2e", fg = "#599cab"}, c = {bg = "#0c1014", fg = "#1e6479"}},
						inactive = {a = {bg = "#11151c", fg = "#d3ebe9", gui = "bold"}, b = {bg = "#091f2e", fg = "#599cab"}, c = {bg = "#0c1014", fg = "#1e6479"}}
					}
				},
				sections = {
					lualine_a = {{"mode", fmt = function(mode) return mode:sub(1,1) end}},
					lualine_b = {"diff", "branch"},
					lualine_c = {{"filename", symbols = {modified = " *", readonly = " -"}}},
					lualine_x = {},
					lualine_y = {{"diagnostics", sections = {"error", "warn"}}, "filetype"},
					lualine_z = {"location", "progress"},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {{"filename", symbols = {modified = " *", readonly = " -"}}},
					lualine_x = {{"diagnostics", sections = {"error", "warn"}}},
					lualine_y = {},
					lualine_z = {}
				}
			})
		end})

		use({"goolord/alpha-nvim", config = function()
			local v = vim.version()
			local height = math.max(0, math.floor((vim.api.nvim_win_get_height(0) - 17) / 2))
			local header = {}
			if height > 0 then
				header = {
					[[             :=:.]],
					[[          .-===-----]],
					[[ ..     .-=====-----]],
					[[:===-.:=====-' -----]],
					[[ '=======:'    -----]],
					[[ .++=====:.    -----]],
					[[-+++-':-====-. -----]],
					[[ ''     '-=====-----]],
					[[          '-===----']],
					[[            '-=--']],
				}
			end
			require("alpha").setup({
				opts = {},
				layout = {
					{type = "padding", val = height},
					{type = "text", opts = {position = "center", hl = "Keyword"}, val = header},
					{type = "padding", val = 1},
					{type = "button", opts = {position = "center"}, val = "New File", on_press = function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>n", true, true, true), "t", true) end},
					{type = "button", opts = {position = "center"}, val = "Recent", on_press = function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>fo", true, true, true), "t", true) end},
					{type = "button", opts = {position = "center"}, val = "Update", on_press = function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>ps", true, true, true), "t", true) end},
					{type = "button", opts = {position = "center"}, val = "Quit", on_press = function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>q", true, true, true), "t", true) end},
					{type = "padding", val = 1},
					{type = "text", opts = {position = "center"}, val = #vim.tbl_keys(packer_plugins) .. " plugins"},
					{type = "text", opts = {position = "center", hl = "Keyword"}, val = string.format("Neovim v%s.%s.%s", v.major, v.minor, v.patch)}
				}
			})
		end})

		use({"psliwka/vim-smoothie", config = function()
			vim.g.smoothie_speed_constant_factor = 25
			vim.g.smoothie_speed_linear_factor = 25
			vim.g.smoothie_speed_exponentiation_factor = 0.9
		end})

		use({"norcalli/nvim-colorizer.lua", config = function()
			require("colorizer").setup({"css","scss","javascript","html","lua"})
		end})

		use({"iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, ft = "markdown", config = function()
			vim.keymap.set({"n","v"}, "<leader>m", "<cmd>MarkdownPreviewToggle<cr>")
			vim.g.mkdp_auto_close = 0
		end})


		-- File management --

		use({"tpope/vim-vinegar"})

		use({"lambdalisue/suda.vim", config = function()
			vim.api.nvim_create_user_command("S", "SudaWrite", {})
		end})


		-- Telescope --

		use({"nvim-telescope/telescope.nvim", requires = {"nvim-lua/plenary.nvim", {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}}, config = function()
			local ts = require("telescope")
			local tsbi = require("telescope.builtin")
			local actions = require("telescope.actions")

			vim.keymap.set({"n","v"}, "<leader><space>", tsbi.find_files)
			vim.keymap.set({"n","v"}, "<leader>ff", tsbi.live_grep)
			vim.keymap.set({"n","v"}, "<leader>fo", tsbi.oldfiles)
			vim.keymap.set({"n","v"}, "<leader>jd", tsbi.lsp_definitions)
			vim.keymap.set({"n","v"}, "<leader>jr", tsbi.lsp_references)
			vim.keymap.set({"n","v"}, "<leader>ji", tsbi.lsp_implementations)
			vim.keymap.set({"n","v"}, "<leader>e", tsbi.diagnostics)
			vim.keymap.set({"n","v"}, "<leader>s", tsbi.spell_suggest)
			vim.keymap.set({"n","v"}, "<leader>h", function() tsbi.man_pages({sections={"1","2","3","4","5","7"}}) end)
			vim.keymap.set({"n","v"}, "<leader>H", tsbi.help_tags)

			ts.setup({
				defaults = {
					layout_config = {scroll_speed = 5},
					path_display = {"truncate"},
					borderchars = {"─","│","─","│","┌","┐","┘","└"},
					file_ignore_patterns = {"/%.git/","/node_modules/","/package%-lock%.json","/%.cache/"},
					mappings = {
						i = {
							["<c-space>"] = actions.select_default,
							["<c-s>"] = actions.select_horizontal,
						}
					}
				},
				pickers = {
					find_files = {hidden = true},
					git_files = {hidden = true},
					live_grep = {additional_args = function() return {"--hidden","--glob","!{.git,node_modules,package-lock.json}"} end}
				},
				extensions = {
					fzf = {fuzzy = true, override_generic_sorter = true, override_file_sorter = true},
				}
			})

			ts.load_extension("fzf")
		end})


		-- Languages and syntax --

		use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {enable = true},
				ensure_installed = {
					"bash", "c", "cmake", "comment", "cpp", "css", "dockerfile", "fish", "glsl",
					"go", "help", "html", "java", "javascript", "jsdoc", "json", "latex", "lua",
					"make", "python", "rust", "scss", "toml", "typescript", "vim", "vue", "yaml"
				}
			})
		end})

		use({"hrsh7th/nvim-cmp", requires = {"neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip"}, config = function()
			local cmp = require("cmp")

			local g = vim.api.nvim_create_augroup("cmp_disable_in_telescope", {})
			vim.api.nvim_create_autocmd("FileType", {group = g, pattern = "TelescopePrompt", callback = function() cmp.setup.buffer({enabled = false}) end})

			cmp.setup({
				enabled = function()
					local context = require("cmp.config.context")
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return
							not context.in_treesitter_capture("comment") and
							not context.in_syntax_group("Comment")
					end
				end,
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end
				},
				mapping = {
					["<c-n>"] = cmp.mapping(function()
						if cmp.visible() then cmp.select_next_item() else cmp.complete() end
					end, {"i", "s", "c"}),
					["<c-p>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						else
							cmp.complete()
						end
					end, {"i", "s", "c"}),
					["<c-space>"] = cmp.mapping(function(fallback)
						if vim.fn["vsnip#available"](1) == 1 then
							local key = vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true)
							vim.api.nvim_feedkeys(key, "", true)
						elseif cmp.visible() then
							cmp.confirm({select = true})
						else
							fallback()
						end
					end, {"i", "s", "c"}),
					["<c-u>"] = cmp.mapping.scroll_docs(-4),
					["<c-d>"] = cmp.mapping.scroll_docs(4),
				},
				window = {
					completion = {border = "single"},
					documentation = {border = "single"}
				},
				experimental = {
					ghost_text = true
				},
				sources = cmp.config.sources({
					{name = "nvim_lsp"},
					{name = "vsnip"},
					{name = "buffer", option = {get_bufnrs = function() return vim.api.nvim_list_bufs() end, keyword_length = 2}}
				})
			})

			cmp.setup.cmdline("/", {
				sources = {
					{name = "buffer", option = {keyword_length = 2}}
				}
			})

			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({
					{name = "path"},
					{name = "cmdline"}
				})
			})
		end})

		use({"neovim/nvim-lspconfig", requires = "williamboman/nvim-lsp-installer", config = function()
			vim.keymap.set({"n","v"}, "<c-k>", vim.lsp.buf.hover)
			vim.keymap.set({"n","v"}, "[e", vim.diagnostic.goto_prev)
			vim.keymap.set({"n","v"}, "]e", vim.diagnostic.goto_next)

			local lsp_win = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or {"┌","─","┐","│","┘","─","└","│"}
				return lsp_win(contents, syntax, opts, ...)
			end

			local lspconfig_win = require("lspconfig.ui.windows")
			local lspconfig_win_opts = lspconfig_win.default_opts
			function lspconfig_win.default_opts(opts)
				local win_opts = lspconfig_win_opts(opts)
				win_opts.border = "single"
				return win_opts
			end

			local function on_attach()
				local g = vim.api.nvim_create_augroup("lsp_open_window", {})
				vim.api.nvim_create_autocmd("CursorHold", {group = g, callback = function() vim.diagnostic.open_float(nil, {focusable=false}) end})
			end

			local server_opts = {
				["sumneko_lua"] = function(opts)
					opts.settings = {Lua = {diagnostics = {globals = {"vim"}}, completion = {callSnippet = "Replace"}}}
				end,
				["tsserver"] = function(opts)
					opts.init_options = {preferences = {disableSuggestions = true}}
				end
			}

			require("nvim-lsp-installer").on_server_ready(function(server)
				local opts = {on_attach = on_attach}
				if server_opts[server.name] then
					server_opts[server.name](opts)
				end
				server:setup(opts)
			end)
		end})


		-- Text editing --

		use({"tpope/vim-sensible"})

		use({"tpope/vim-surround"})

		use({"tpope/vim-repeat"})

		use({"numToStr/Comment.nvim", config = function()
			require("Comment").setup()
		end})

		use({"tommcdo/vim-lion", config = function()
			vim.g.lion_map_left = "<leader>l"
			vim.g.lion_map_right = "<leader>L"
			vim.g.lion_squeeze_spaces = 1
		end})

		use({"mbbill/undotree", config = function()
			vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
			vim.g.undotree_ShortIndicators = 1
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_TreeNodeShape = "┼"
			vim.g.undotree_TreeVertShape = "│"
			vim.g.undotree_TreeSplitShape = "⡐"
			vim.g.undotree_TreeReturnShape = "⠢"
			vim.g.undotree_DiffAutoOpen = 0
			vim.g.undotree_HelpLine = 0
		end})

		-- VCS --

		use({"tpope/vim-fugitive", config = function()
			vim.keymap.set({"n","v"}, "<leader>gg", "<cmd>vertical G<cr>")
			vim.keymap.set({"n","v"}, "<leader>gl", "<cmd>vertical G log<cr>")
			vim.keymap.set({"n","v"}, "<leader>gc", "<cmd>vertical G commit<cr>")
			vim.keymap.set({"n","v"}, "<leader>gp", "<cmd>vertical G push<cr>")
		end})

		use({"lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim", config = function()
			require("gitsigns").setup({current_line_blame_opts = {delay = 0}})
		end})

		if packer_bootstrap then
			require("packer").sync()
		end
	end,

	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({border = "single"})
			end
		}
	}
})

-- Autocmds
local g = vim.api.nvim_create_augroup("vimrc", {})
vim.api.nvim_create_autocmd("TextYankPost", {group = g, callback = function() vim.highlight.on_yank({higroup="Visual", timeout=150}) end})
vim.api.nvim_create_autocmd("BufEnter",     {group = g, command = "set formatoptions-=c formatoptions-=o"})
vim.api.nvim_create_autocmd("FileType",     {group = g, pattern = "netrw", command = "nmap <buffer> <c-space> <cr>"})
vim.api.nvim_create_autocmd("FileType",     {group = g, pattern = "lua,vim", command = "set keywordprg="})
vim.api.nvim_create_autocmd("BufWritePost", {group = g, pattern = initfile, command = "source <afile> | PackerCompile"})
vim.api.nvim_create_autocmd("BufReadPost",  {group = g, command = [[
	if expand('%:p') !~# '\m/\.git/' && line("'\"") > 0 && line("'\"") <= line("$") |
		exe "normal! g`\"" |
	endif
]]})

-- Settings
vim.o.title = true
vim.o.shell = "sh"
vim.o.updatetime = 100
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.modeline = false
vim.o.ignorecase = true
vim.o.smartcase= true
vim.o.undofile = true
vim.o.swapfile = true
vim.o.lazyredraw = true
vim.o.completeopt = "menuone,preview"
-- Editing
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.virtualedit = "onemore"
-- UI
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.showmode = false
vim.o.pumheight = 6
vim.o.list = true
vim.o.listchars = "tab:› ,trail:•,precedes:<,extends:>,nbsp:␣"
vim.o.guicursor="n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait400-blinkoff400-blinkon400"
vim.opt.shortmess:append("I")
vim.o.foldenable = false
vim.o.wrap = false

-- Keymappings
vim.g.mapleader = " "
vim.keymap.set({"n","v"}, "<leader>", "")
vim.keymap.set({"n","v"}, "<leader>w", "<cmd>w<cr>")
vim.keymap.set({"n","v"}, "<leader>W", "<cmd>wq<cr>")
vim.keymap.set({"n","v"}, "<leader>q", "<cmd>q<cr>")
vim.keymap.set({"n","v"}, "<leader>Q", "<cmd>q!<cr>")
vim.keymap.set({"n","v"}, "<leader>n", "<cmd>enew<cr>")
vim.keymap.set({"n","v"}, "<leader>c", "<cmd>tabedit " .. initfile .. "<cr>")
vim.keymap.set({"n","v"}, "<c-j>", "i<cr><esc>l")
vim.keymap.set({"n","v"}, "Q", "", {nowait = true})
-- Toggle settings
vim.keymap.set({"n","v"}, "<leader>tw", "<cmd>set wrap!<cr>")
vim.keymap.set({"n","v"}, "<leader>ts", "<cmd>set spell!<cr>")
vim.keymap.set({"n","v"}, "<leader>tr", "<cmd>set relativenumber!<cr>")
-- Movement
vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")
vim.keymap.set("", "<down>", "gj")
vim.keymap.set("", "<up>", "gk")
vim.keymap.set("i", "<down>", "<c-o>gj")
vim.keymap.set("i", "<up>", "<c-o>gk")
-- Replacement
vim.keymap.set("n", "<leader>rr", "*:%s///gcI<left><left><left><left>")
vim.keymap.set("n", "<leader>r'", "<cmd>%s/'/\"/gc<cr>")
vim.keymap.set("n", "<leader>r\"", "<cmd>%s/\"/'/gc<cr>")
vim.keymap.set("n", "<leader>r<tab>", "<cmd>%s/\t/ /gc<cr>")
vim.keymap.set("n", "<leader>r<space>", "<cmd>%s/ /\t/gc<cr>")
