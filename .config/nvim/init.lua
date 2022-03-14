
-- Plugins
local config_path = vim.fn.resolve(vim.fn.stdpath("config"))
local install_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim")
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
	vim.cmd("packadd packer.nvim")
end
require("packer").startup({
	function(use)
		use({"wbthomason/packer.nvim"})
		use({"lewis6991/impatient.nvim"})
		require("impatient")
		for filename in io.popen("find " .. config_path .. "/configs -type f"):lines() do
			use(dofile(filename))
		end
	end,
    config = {
		display = { open_fn = function() return require("packer.util").float({border = "single"}) end }
	}
})

-- System
vim.o.title = true
vim.o.shell = "sh"
vim.o.updatetime = 100
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.modeline = false
vim.o.ignorecase = true
vim.o.smartcase= true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.wildmode = "longest:full"

-- UI
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
vim.o.foldenable = false
vim.o.wrap = false

-- TODO: highlight incorrect indentation
function HighlightInvalidIndentation()
	vim.cmd([[
	augroup incorrect_indentation
		autocmd! Syntax * syn match Visual /^\t*\zs \+/ containedin=ALL
	augroup end
	]])
end

function ToggleIndentStyle()
	vim.o.expandtab = not vim.o.expandtab

	local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local old, new = string.rep(" ", vim.o.tabstop), "\t"
	if vim.o.expandtab then
		old, new = new, old
	end

	local oldlen = old:len()

	for index, line in pairs(content) do
		local _, indent = line:find("^" .. old .. "*")
		if indent then
			content[index] = line:gsub(old, new, indent / oldlen)
		end
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
end

vim.cmd([[command! ToggleIndentStyle lua ToggleIndentStyle()]])

-- Keymappings
vim.g.mapleader = " "
vim.api.nvim_set_keymap("",  "Y",         "y$",                                                   {noremap=true,silent=false})
vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>w<cr>",                                           {noremap=true,silent=false})
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>q<cr>",                                           {noremap=true,silent=false})
vim.api.nvim_set_keymap("n", "<leader>Q", "<cmd>qa<cr>",                                          {noremap=true,silent=false})
vim.api.nvim_set_keymap("n", "<leader>W", "<cmd>setl wrap!<cr>",                                  {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<cr>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", "<leader>r", "*:%s///gcI<left><left><left><left>",                   {noremap=true,silent=false})
vim.api.nvim_set_keymap("n", "q:",        "<nop>",                                                {noremap=true,silent=false})
vim.api.nvim_set_keymap("n", "Q",         "<nop>",                                                {noremap=true,silent=false})

vim.cmd(string.format([[
augroup vimrc
	autocmd!

	" Trim whitespace on save
	autocmd BufWritePre * let b:lastposition = winsaveview() | keeppatterns %%s/\s\+$//e | call winrestview(b:lastposition)

	" Highlight yanks
	autocmd TextYankPost * silent lua vim.highlight.on_yank({higroup="Visual", timeout=150})

	" Resend SIGWINCH due to long startup times
	autocmd VimEnter * silent exec "!kill -s WINCH $PPID"

	" Recompile Packer after changing config
	autocmd BufWritePost %s/** source %s/init.lua | PackerCompile

	" Remember cursor position excluding .git
	autocmd BufReadPost * if expand('%%:p') !~# '\m/\.git/' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

augroup end
]], config_path, config_path))

vim.cmd([[
highlight! link Pmenu NormalFloat
highlight! link Pmenu FloatBorder
]])
