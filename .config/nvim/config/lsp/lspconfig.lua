local function config()

	-- TODO: reference highlight
	vim.cmd([[
	highlight! LspReferenceRead guibg=#11151c
	highlight! link LspReferenceText LspReferenceRead
	highlight! link LspReferenceWrite LspReferenceRead
	highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
	highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
	highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
	highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold
	sign define DiagnosticSignError text= texthl=DiagnosticSignError numhl=DiagnosticLineNrError
	sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn numhl=DiagnosticLineNrWarn
	sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo numhl=DiagnosticLineNrInfo
	sign define DiagnosticSignHint text= texthl=DiagnosticSignHint numhl=DiagnosticLineNrHint
	]])

	local wrapped_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or {"┌","─","┐","│","┘","─","└","│"}
		return wrapped_open_floating_preview(contents, syntax, opts, ...)
	end

	local lsp_installer = require("nvim-lsp-installer")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	local function on_attach(client)

		vim.cmd([[
		augroup lsp_open_window
			autocmd!
			autocmd CursorHold * lua vim.diagnostic.open_float({focusable=false})
		augroup end
		]])

		if client.resolved_capabilities.document_highlight then
			vim.cmd([[
			augroup lsp_highlight
				autocmd!
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup end
			]])
		end

	end

	local server_opts = {
		["sumneko_lua"] = function(opts)
			opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
		end,
		["tsserver"] = function(opts)
			opts.init_options = { preferences = { disableSuggestions = true } }
		end
	}

	lsp_installer.on_server_ready(function(server)
		local opts = {capabilities = capabilities, on_attach = on_attach}
		if server_opts[server.name] then
			server_opts[server.name](opts)
		end
		server:setup(opts)
	end)
end

return { "neovim/nvim-lspconfig", requires = { "williamboman/nvim-lsp-installer", "hrsh7th/cmp-nvim-lsp" }, config = config }
