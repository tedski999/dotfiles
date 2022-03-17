local function config()

	-- TODO: coloring is sketchy
	vim.cmd([[
	highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
	highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
	highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
	highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
	highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
	highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
	highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
	highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
	highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
	highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
	highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
	]])

	local cmp = require("cmp")

	local mapping = {
		["<up>"] = cmp.mapping.scroll_docs(-4),
		["<down>"] = cmp.mapping.scroll_docs(4),
		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, {"i","c"}),
		["<s-tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, {"i","c"}),
		["<space>"] = function(fallback)
			if cmp.visible() and cmp.get_selected_entry() then
				cmp.confirm({select = true})
			else
				fallback()
			end
		end
	}

	cmp.setup({
		mapping = mapping,

		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end
		},

		enabled = function()
			local context = require("cmp.config.context")
			return not context.in_syntax_group("Comment")
		end,

		formatting = {
			fields = {"abbr", "kind"},
			format = function(_, vim_item)
				vim_item.abbr = string.sub(vim_item.abbr, 1, 40)
				vim_item.kind = ({
					Text = "",      Method = "f",  Function = "f",  Constructor = "f", Field = "m",
					Variable = "x", Class = "C",   Interface = "I", Module = "M",      Property = "m",
					Unit = "?2",     Value = "=",   Enum = "e",      Keyword = "k",     Snippet = "~",
					Color = "?3",    File = ".",    Reference = "@", Folder = "/",      EnumMember = "e",
					Constant = "#", Struct = "C",  Event = "?5",     Operator = "*",    TypeParameter = "T"
				})[vim_item.kind] or ""
				return vim_item
			end
		},

		window = {
			completion = { border = {"┌", "─", "┐", "│", "┘", "─", "└", "│" } },
			documentation = { border = {"┌", "─", "┐", "│", "┘", "─", "└", "│" } }
		},

		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" }
		}),

		experimental = {
			ghost_text = true
		}
	})

	cmp.setup.cmdline(":", { sources = { { name = "cmdline" } } })
	cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })
end

return {
	"hrsh7th/nvim-cmp",
	config = config,
	requires = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/luasnip",
		"saadparwaiz1/cmp_luasnip"
	}
}
