
-- Plugins
local packer_bootstrap = false
local config_path = vim.fn.resolve(vim.fn.stdpath("config"))
local install_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim")
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
	vim.cmd("packadd packer.nvim")
end
require("packer").startup({
	function(use)
		use({"wbthomason/packer.nvim"})
		use({"lewis6991/impatient.nvim"})
		if not packer_bootstrap then require("impatient") end
		for filename in io.popen("find " .. config_path .. "/config -type f"):lines() do use(dofile(filename)) end
		if packer_bootstrap then require("packer").sync() end
	end,
	config = {
		display = { open_fn = function() return require("packer.util").float({border = "single"}) end }
	}
})

-- System
vim.o.title = true
vim.o.shell = "sh"
vim.o.updatetime = 100
vim.o.timeoutlen = 2000
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.modeline = false
vim.o.ignorecase = true
vim.o.smartcase= true
vim.o.undofile = true
vim.o.swapfile = false

-- UI
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.showmode = false
vim.o.pumheight = 6
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.expandtab = false
vim.o.list = true
vim.o.listchars = "tab:› ,trail:•,precedes:<,extends:>,nbsp:␣"
vim.opt.shortmess:append("I")
vim.o.foldenable = false
vim.o.wrap = false

function SetIndentStyle(spaced)
	vim.o.expandtab = spaced
	local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local old, new = string.rep(" ", vim.o.tabstop), "\t"
	if vim.o.expandtab then
		old, new = new, old
	end
	for index, line in pairs(content) do
		local _, indent = line:find("^" .. old .. "*")
		if indent then
			content[index] = line:gsub(old, new, indent / old:len())
		end
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
end

-- Autocommands
vim.cmd([[
augroup vimrc
	autocmd!
	" Highlight yanks
	autocmd TextYankPost * silent lua vim.highlight.on_yank({higroup="Visual", timeout=150})
	" Resend SIGWINCH due to long startup times
	autocmd VimEnter * silent exec "!kill -s WINCH $PPID"
	" Remember cursor position excluding .git
	autocmd BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
	" Don't help with comment formatting
	autocmd BufEnter * set formatoptions-=c formatoptions-=o
augroup end
]])

-- Keymappings
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>w",        "<cmd>w<cr>",                                                                                 {})
vim.api.nvim_set_keymap("n", "<leader>W",        "<cmd>wq<cr>",                                                                                {})
vim.api.nvim_set_keymap("n", "<leader>q",        "<cmd>q<cr>",                                                                                 {})
vim.api.nvim_set_keymap("n", "<leader>Q",        "<cmd>qa<cr>",                                                                                {})
vim.api.nvim_set_keymap("n", "Q",                "<nop>",                                                                                      {})
-- Replacement
vim.api.nvim_set_keymap("n", "<leader>r",        "*:%s///gcI<left><left><left><left>",                                                         {})
vim.api.nvim_set_keymap("n", "<leader>\"",       "<cmd>%s/'/\"/gc<cr>",                                                                        {})
vim.api.nvim_set_keymap("n", "<leader>'",        "<cmd>%s/\"/'/gc<cr>",                                                                        {})
vim.api.nvim_set_keymap("n", "<leader>i<tab>",   "<cmd>lua SetIndentStyle(false)<cr>",                                                         {})
vim.api.nvim_set_keymap("n", "<leader>i<space>", "<cmd>lua SetIndentStyle(true)<cr>",                                                          {})
-- Plugins
vim.api.nvim_set_keymap("n", "<leader>pp",       "<cmd>PackerStatus<cr>",                                                                      {})
vim.api.nvim_set_keymap("n", "<leader>pc",       "<cmd>PackerCompile<cr>",                                                                     {})
vim.api.nvim_set_keymap("n", "<leader>ps",       "<cmd>PackerSync<cr>",                                                                        {})
-- Git
vim.api.nvim_set_keymap("n", "]c",               "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'",                                               {expr=true})
vim.api.nvim_set_keymap("n", "[c",               "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'",                                               {expr=true})
vim.api.nvim_set_keymap("n", "<leader>gg",       "<cmd>G<cr>",                                                                                 {})
vim.api.nvim_set_keymap("n", "<leader>gc",       "<cmd>G commit<cr>",                                                                          {})
vim.api.nvim_set_keymap("n", "<leader>gs",       "<cmd>Gitsigns stage_hunk<cr>",                                                               {})
vim.api.nvim_set_keymap("v", "<leader>gs",       "<cmd>Gitsigns stage_hunk<cr>",                                                               {})
vim.api.nvim_set_keymap("n", "<leader>gS",       "<cmd>Gitsigns stage_buffer<cr>",                                                             {})
vim.api.nvim_set_keymap("n", "<leader>gr",       "<cmd>Gitsigns reset_hunk<cr>",                                                               {})
vim.api.nvim_set_keymap("v", "<leader>gr",       "<cmd>Gitsigns reset_hunk<cr>",                                                               {})
vim.api.nvim_set_keymap("n", "<leader>gR",       "<cmd>Gitsigns reset_buffer<cr>",                                                             {})
vim.api.nvim_set_keymap("n", "<leader>gu",       "<cmd>Gitsigns undo_stage_hunk<cr>",                                                          {})
vim.api.nvim_set_keymap("n", "<leader>gd",       "<cmd>Gitsigns toggle_deleted<cr>",                                                           {})
vim.api.nvim_set_keymap("n", "<leader>gD",       "<cmd>Gitsigns diffthis<cr>",                                                                 {})
vim.api.nvim_set_keymap("n", "<leader>gb",       "<cmd>Telescope git_branches<cr>",                                                            {})
vim.api.nvim_set_keymap("n", "<leader>gB",       "<cmd>Gitsigns toggle_current_line_blame<cr>",                                                {})
vim.api.nvim_set_keymap("n", "<leader>gf",       "<cmd>Telescope git_files<cr>",                                                               {})
-- Snippets
vim.api.nvim_set_keymap("i", "<c-space>",        "<cmd>lua LuasnipNext()<cr>",                                                                 {})
vim.api.nvim_set_keymap("s", "<c-space>",        "<cmd>lua LuasnipNext()<cr>",                                                                 {})
-- File navigation
vim.api.nvim_set_keymap("n", "<leader><space>",  "<cmd>Telescope find_files<cr>",                                                              {})
vim.api.nvim_set_keymap("n", "<leader>fp",       "<cmd>Telescope projects<cr>",                                                                {})
vim.api.nvim_set_keymap("n", "<leader>ff",       "<cmd>Telescope live_grep<cr>",                                                               {})
-- Code navigation
vim.api.nvim_set_keymap("n", "<leader>t",        "<cmd>TagbarToggle c<cr>",                                                                    {})
vim.api.nvim_set_keymap("n", "<leader>T",        "<cmd>lua require('telescope.builtin').tags({ctags_file = vim.b.gutentags_files.ctags})<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>fd",       "<cmd>Telescope lsp_definitions<cr>",                                                         {})
vim.api.nvim_set_keymap("n", "<leader>fr",       "<cmd>Telescope lsp_references<cr>",                                                          {})
vim.api.nvim_set_keymap("n", "<leader>fi",       "<cmd>Telescope lsp_implementations<cr>",                                                     {})
-- Debug
vim.api.nvim_set_keymap("n", "[e",               "<cmd>lua vim.diagnostic.goto_prev()<cr>",                                                    {})
vim.api.nvim_set_keymap("n", "]e",               "<cmd>lua vim.diagnostic.goto_next()<cr>",                                                    {})
vim.api.nvim_set_keymap("n", "<leader>e",        "<cmd>Telescope diagnostics<cr>",                                                             {})
vim.api.nvim_set_keymap("n", "<leader>a",        "<cmd>Telescope lsp_code_actions<cr>",                                                        {})
-- Help
vim.api.nvim_set_keymap("n", "<leader>s",        "<cmd>Telescope spell_suggest<cr>",                                                           {})
vim.api.nvim_set_keymap("n", "<leader>h",        "<cmd>Telescope man_pages sections=1,2,3,4,5,7<cr>",                                          {})
vim.api.nvim_set_keymap("n", "<leader>H",        "<cmd>Telescope help_tags<cr>",                                                               {})
-- Misc
vim.api.nvim_set_keymap("n", "<leader>j",        "<cmd>Telescope jumplist<cr>",                                                                {})
vim.api.nvim_set_keymap("n", "<leader>u",        "<cmd>UndotreeToggle<cr>",                                                                    {})
vim.api.nvim_set_keymap("n", "<leader>m",        "<cmd>MarkdownPreviewToggle<cr>",                                                             {})
