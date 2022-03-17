local function config()
	vim.g.mkdp_auto_close = 0
	vim.g.mkdp_command_for_global = 1
end

return { "iamcco/markdown-preview.nvim", run = "cd app && yarn install", ft = "markdown", config = config }
