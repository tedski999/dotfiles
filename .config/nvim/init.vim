
call plug#begin(stdpath('data') . '/plugged')
Plug 'whatyouhide/vim-gotham'
Plug 'itchyny/lightline.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-scripts/a.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'machakann/vim-highlightedyank'
Plug 'luochen1990/rainbow'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()

" Vim Gotham
colorscheme gotham
if (has('termguicolors'))
  set termguicolors
endif

" Lightline
let g:lightline = {
\   'colorscheme': 'gotham',
\   'active': {
\     'right': [ [ 'lineinfo' ],
\                [ 'percent' ],
\                [ 'fileformat', 'fileencoding', 'filetype' ] ],
\     'left': [ [ 'mode', 'paste' ],
\               [ 'readonly', 'filename', 'gitchanges', 'modified' ],
\               [ 'ctags' ] ]
\   },
\   'component_function': {
\     'gitchanges': 'GitGutterStatus',
\     'ctags': 'gutentags#statusline'
\   },
\ }

" Telescope.nvim
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({hidden=true,follow=true})<cr>
nnoremap <C-s> <cmd>lua require('telescope.builtin').live_grep({})<cr>
nnoremap <C-t> <cmd>lua require('telescope.builtin').tags({ctags_file='/tmp/tags'})<cr>
nnoremap <C-g>g <cmd>Telescope git_status<cr>
nnoremap <C-g>c <cmd>Telescope git_commits<cr>
nnoremap <C-g>s <cmd>Telescope git_stash<cr>
nnoremap <C-g>b <cmd>Telescope git_branches<cr>
nnoremap <C-h>h <cmd>Telescope help_tags<cr>
nnoremap <C-h>m <cmd>Telescope man_pages<cr>
nnoremap <C-h>s <cmd>Telescope spell_suggest<cr>
nnoremap <C-e> <cmd>lua require('telescope.builtin').file_browser({disable_devicons=true,hidden=true,cwd='%:p:h'})<cr>
cabbrev <silent> E lua require('telescope.builtin').file_browser({disable_devicons=true,hidden=true,cwd='%:p:h'})
lua << EOF
require('telescope').setup {
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    file_ignore_patterns = { "%.git", "LICENSE" },
    vimgrep_arguments = {
      'rg', '--no-heading', '--with-filename', '--line-number',
      '--column', '--smart-case', '--hidden'
    },
  }
}
EOF

" If within a project, set cwd to project root
au VimEnter * call ChangeToProjecyRootDirectory()
function! ChangeToProjecyRootDirectory()
  if exists('*gutentags#get_project_root')
    try
      let l:path = gutentags#get_project_root(expand('%:p'))
      exe 'cd' fnameescape(l:path)
      echo 'Opened project rooted at'l:path
    catch
      echo 'No project root found'
    endtry
  endif
endfunction

" Git Gutter
function! GitGutterStatus()
  let l:status = ''
  let [l:a,l:m,l:r] = GitGutterGetHunkSummary()
  if l:a | let l:status .= printf(' +%d', l:a) | endif
  if l:m | let l:status .= printf(' ~%d', l:m) | endif
  if l:r | let l:status .= printf(' -%d', l:r) | endif
  return trim(l:status)
endfunction

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('min_pattern_length', 1)
inoremap <silent><expr> <TAB> pumvisible() ? '<C-n>' : '<TAB>'
inoremap <silent><expr> <S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'

" Gutentags
let g:gutentags_ctags_tagfile = '/tmp/tags'
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [ '--tag-relative=yes', '--fields=+ailmnS' ]
let g:gutentags_ctags_exclude = [
\   '*.git', '*.svg', '*.hg', 'build', 'dist', 'bin', 'node_modules', 'cache',
\   'compiled', 'docs', 'example', 'bundle', 'vendor', '*.md', '*.class',
\   '*.sln', '*.tmp', '*.cache', '*.rar', '*.zip', '*.tar', '*.tar.gz',  '*.pdf'
\ ]

" Emmet.vim
let g:user_emmet_leader_key='<C-,>'

" Highlight yank
let g:highlightedyank_highlight_duration = 150
highlight link HighlightedyankRegion Visual

" Rainbow Parentheses Improved
let g:rainbow_active = 0
nnoremap g<C-r> <cmd>RainbowToggle<cr>

" Markdown Preview
let g:mkdp_auto_close = 0
let g:mkdp_page_title = '${name}'
nnoremap g<C-m> <cmd>MarkdownPreviewToggle<cr>

" Netrw
let g:netrw_home='~/.local/share/nvim/'
let g:netrw_banner = 0

" Neovide
set guifont=SourceCodePro:h14
let g:neovide_cursor_animation_length=0.1
let g:neovide_cursor_trail_length=0
let g:neovide_cursor_vfx_mode = 'wireframe'

" Find and replace
nnoremap <S-f>w *:%s///gcI<left><left><left><left>
nnoremap <S-f>f *:%s//gcI<left><left><left><left>

" Remove trailing whitespace by default
let g:trim_whitespace = 1
au BufWritePre * if g:trim_whitespace | call TrimWhitespace() | endif
function! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun<CR><CR>

" Misc key mappings
map Q <nop>
map Y y$
nnoremap <silent> <C-l> <cmd>nohlsearch<cr>
cabbrev W w

" System
set shell=sh                  "use sh instead of $SHELL
set updatetime=200            "we need a faster refresh time
set undofile                  "persistent undo history
set noswapfile                "don't keep a swap file
set clipboard=unnamedplus     "by default, use the system clipboard
set nomodeline                "stay safe kiddos

" Editor UI
set title                     "update the title of the terminal
set number                    "show line numbers
set cursorline                "highlight current line
set cursorcolumn              "highlight current column
set noshowmode                "redundant with Lightline
set noruler                   "redundant with Lightline
set completeopt-=preview      "don't use the preview panel
set scrolloff=3               "keep lines above/below the cursor when scrolling
set sidescrolloff=5           "keep columns to the left/right of the cursor when scrolling
set signcolumn=yes            "keep the sign column open
set mouse=a                   "mouse support
set list                      "whitespace and hint rendering
set listchars=tab:›\ ,trail:•,precedes:«,extends:»,nbsp:␣

" Syntax and formatting
set ignorecase                "case insensitive matching
set smartcase                 "capital sensitive matching
set tabstop=4                 "4-column tab characters
set softtabstop=4             "4 spaces = tab visually
set shiftwidth=0              "same width as tabstop for auto-indenting
set nowrap                    "do not wrap lines
set nofoldenable              "disable folding by default
set nrformats-=octal          "disable octal number incrementing
syntax enable                 "enable syntax highlighting
filetype plugin indent on     "file-dependant auto-indenting
au FileType * set fo-=c fo-=o "always disable auto-commenting

