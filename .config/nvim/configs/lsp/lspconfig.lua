local function config()

	vim.cmd([[
	augroup lsp_open_window
		autocmd CursorHold * lua vim.diagnostic.open_float({focusable=false})
	augroup end
	]])

	vim.api.nvim_set_keymap("n", "gd",        "<cmd>lua vim.lsp.buf.definition()<cr>",     {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "gD",        "<cmd>lua vim.lsp.buf.declaration()<cr>",    {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "gr",        "<cmd>lua vim.lsp.buf.references()<cr>",     {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "gi",        "<cmd>lua vim.lsp.buf.implementation()<cr>", {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "ga",        "<cmd>lua vim.lsp.buf.code_action()<cr>",    {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "<c-k>",     "<cmd>lua vim.lsp.buf.hover()<cr>",          {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "<c-K>",     "<cmd>lua vim.lsp.buf.signature_help()<cr>", {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "<leader>R", "<cmd>lua vim.lsp.buf.rename()<cr>",         {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.setloclist()<cr>",  {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "[e",        "<cmd>lua vim.diagnostic.goto_prev()<cr>",   {noremap=true, silent=true})
	vim.api.nvim_set_keymap("n", "]e",        "<cmd>lua vim.diagnostic.goto_next()<cr>",   {noremap=true, silent=true})

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

	local _open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or {
			{"┌", "FloatBorder"}, {"─", "FloatBorder"}, {"┐", "FloatBorder"}, {"│", "FloatBorder"},
			{"┘", "FloatBorder"}, {"─", "FloatBorder"}, {"└", "FloatBorder"}, {"│", "FloatBorder"}
		}
		return _open_floating_preview(contents, syntax, opts, ...)
	end

	local lsp_installer = require("nvim-lsp-installer")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	local function on_attach(client)
		-- TODO: lua lsp breaks
		if client.resolved_capabilities.document_highlight then
			vim.cmd([[
			augroup lsp_highlight
				autocmd!
				"autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				"autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
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
		local opts = {capabilities=capabilities, on_attach = on_attach}
		if server_opts[server.name] then server_opts[server.name](opts) end
		server:setup(opts)
	end)

end

return {
	"neovim/nvim-lspconfig",
	requires = { "williamboman/nvim-lsp-installer", "hrsh7th/cmp-nvim-lsp" },
	config = config
}
