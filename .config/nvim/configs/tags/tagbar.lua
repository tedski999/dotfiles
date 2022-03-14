local function config()
	vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>TagbarToggle<cr>", {noremap=true,silent=true})
end

return { "preservim/tagbar", event = "BufRead", config = config }
