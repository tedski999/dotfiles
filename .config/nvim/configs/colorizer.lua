local function config()
	vim.o.termguicolors = true
	require("colorizer").setup({"css","scss","javascript","html"})
end

return { "norcalli/nvim-colorizer.lua", event = "BufRead", config = config }
