local function config()
	require("colorizer").setup({"css","scss","javascript","html"})
end

return { "norcalli/nvim-colorizer.lua", config = config }
