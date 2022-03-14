local function config()
	require("Comment").setup()
end

return { "numToStr/Comment.nvim", event = "BufRead", config = config }
