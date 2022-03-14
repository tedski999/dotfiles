local function config()
	vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. "ctags"
	vim.g.gutentags_generate_on_new = 1
	vim.g.gutentags_generate_on_missing = 1
	vim.g.gutentags_generate_on_write = 1
	vim.g.gutentags_generate_on_empty_buffer = 0
	vim.g.gutentags_ctags_extra_args = { "--tag-relative=yes", "--fields=+ailmnS" }
	vim.g.gutentags_ctags_exclude = {
	    "build", "dist", "bin", "obj",
	    "node_modules", "*-lock.json", "*.lock",
	    "*.bmp", "*.gif", "*.ico", "*.jpg", "*.png"
	}
end

return { "ludovicchabant/vim-gutentags", event = "BufRead", config = config }
