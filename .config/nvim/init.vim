
call plug#begin(stdpath('data') . '/plugged')
Plug 'whatyouhide/vim-gotham'
Plug 'itchyny/lightline.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'sheerun/vim-polyglot'
Plug 'machakann/vim-highlightedyank'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lambdalisue/suda.vim'
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
\                [ 'filetype', 'percent' ] ],
\     'left': [ [ 'mode', 'paste' ],
\               [ 'readonly', 'filename', 'gitchanges', 'modified' ] ]
\   },
\   'component_function': {
\     'gitchanges': 'GitGutterStatus'
\   },
\   'mode_map': {
\     'n': 'N', 'i': 'I', 'R': 'R',
\     'v': 'V', 'V': 'VL', "\<C-v>": 'VB',
\     's': 'S', 'S': 'SL', "\<C-s>": 'SB',
\     'c': 'C', 't': 'T'
\   },
\ }

" Git Gutter
function! GitGutterStatus()
  let l:status = ''
  let [l:a,l:m,l:r] = GitGutterGetHunkSummary()
  if l:a | let l:status .= printf(' +%d', l:a) | endif
  if l:m | let l:status .= printf(' ~%d', l:m) | endif
  if l:r | let l:status .= printf(' -%d', l:r) | endif
  return trim(l:status)
endfunction

"nvim-colorizer
lua require 'colorizer'.setup(nil, {css=true})

" Highlight yank
let g:highlightedyank_highlight_duration = 150
highlight link HighlightedyankRegion Visual

" Netrw
let g:netrw_home='~/.local/share/nvim/'
let g:netrw_banner = 0

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

" In case Neovim misses the terminals SIGWINCH when starting up
autocmd VimEnter * :silent exec "!kill -s WINCH $PPID"

" Misc key mappings
map Q <nop>
map Y y$
nnoremap <silent> <C-l> <cmd>nohlsearch<cr>
cabbrev W w
map q: <nop>

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

