local function config()
	vim.api.nvim_set_keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>", {noremap=true,silent=true})
end

return { "mbbill/undotree", event = "BufReadPre", config = config }
