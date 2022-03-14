local function config()
	vim.g.fzf_command_prefix = "Find"
	vim.g.fzf_tags_command = "GutentagsUpdate"
	vim.g.fzf_history_dir = vim.fn.stdpath("cache") .. "fzf-history"
	vim.g.fzf_history_dir = vim.fn.stdpath("cache") .. "fzf-history"
	vim.g.fzf_layout = { window = { width = 0.8, height = 0.8, border = "sharp" } }
	vim.cmd([[
	let g:fzf_colors = {
	\    'bg+': ['bg','Normal'], 'hl': ['fg','Comment'], 'hl+': ['fg','Statement'],
	\    'info': ['fg','Comment'], 'prompt': ['fg','Conditional'], 'pointer': ['fg','Exception']
	\}
	]])

	vim.cmd([[
	augroup fzf_disable_ui
		autocmd FileType fzf set norelativenumber laststatus=0 | autocmd BufLeave <buffer> set relativenumber laststatus=2
	augroup end
	]])

	vim.api.nvim_set_keymap("n", "<leader><space>", "<cmd>FindGFiles --cached --others<cr>", {noremap=true,silent=true})
	vim.api.nvim_set_keymap("n", "<leader>f",       "<cmd>FindFiles<cr>",                    {noremap=true,silent=true})
	vim.api.nvim_set_keymap("n", "<leader>s",       "<cmd>FindRg<cr>",                       {noremap=true,silent=true})
	vim.api.nvim_set_keymap("n", "<leader>T",       "<cmd>FindTags<cr>",                     {noremap=true,silent=true})
end

return {
	"junegunn/fzf",
	requires = "junegunn/fzf.vim",
	config = config
}
