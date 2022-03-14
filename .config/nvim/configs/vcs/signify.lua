
local function config()
	vim.cmd([[highlight GitSignsAdd guibg=#11151c guifg=#009900]])
	vim.cmd([[highlight GitSignsChange guibg=#11151c guifg=#bbbb00]])
	require("gitsigns").setup({

		current_line_blame_opts = { delay = 0 },

		signs = {
			add = {text = "𑗅", numhl="GitSignsAddNr", linehl="GitSignsAddLn"},
			change = {text = "𑗅", numhl="GitSignsChangeNr", linehl="GitSignsChangeLn"}
		},

		on_attach = function()
			vim.api.nvim_buf_set_keymap("n", "]c",          "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", {expr=true})
			vim.api.nvim_buf_set_keymap("n", "[c",          "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", {expr=true})
			vim.api.nvim_buf_set_keymap("n", "<leader>ghs", ":Gitsigns stage_hunk<cr>",                     {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("v", "<leader>ghs", ":Gitsigns stage_hunk<cr>",                     {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("n", "<leader>ghr", ":Gitsigns reset_hunk<cr>",                     {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("v", "<leader>ghr", ":Gitsigns reset_hunk<cr>",                     {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("n", "<leader>ghS", "<cmd>Gitsigns stage_buffer<cr>",               {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("n", "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>",            {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<cr>",               {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>",               {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("n", "<leader>gb",  "<cmd>Gitsigns toggle_current_line_blame<cr>",  {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("n", "<leader>gd",  "<cmd>Gitsigns diffthis<cr>",                   {noremap=true,silent=true})
			vim.api.nvim_buf_set_keymap("n", "<leader>td",  "<cmd>Gitsigns toggle_deleted<cr>",             {noremap=true,silent=true})
		end
	})
end

return {
	"lewis6991/gitsigns.nvim",
	requires = "nvim-lua/plenary.nvim",
	event = "BufRead",
	config = config
}
