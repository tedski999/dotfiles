local function config()
	require("lsp_signature").setup{
		hi_parameter = "Visual",
		hint_enable = false,
		handler_opts = {border = "single"}
	}
end

return { "ray-x/lsp_signature.nvim", config = config }
