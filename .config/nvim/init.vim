
call plug#begin(stdpath('data') . '/plugged')
Plug 'whatyouhide/vim-gotham'
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/a.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'machakann/vim-highlightedyank'
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
\               [ 'gitbranch', 'readonly', 'filename', 'gitchanges', 'modified' ],
\               [ 'errorcount' ] ]
\   },
\   'component_function': {
\     'gitbranch': 'FugitiveHead',
\     'gitchanges': 'GitGutterStatus',
\     'errorcount': 'ALEErrorStatus'
\   },
\ }

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|git'
let g:ctrlp_show_hidden = 1

" a.vim
"let g:alternateExtensionsDict['test'] = 'foo,bar'

" Git Gutter
nnoremap <silent> <C-g>g :Git<CR>
nnoremap <silent> <C-g>l :Git log<CR>
nnoremap <silent> <C-g>b :Git blame<CR>
nnoremap <silent> <C-g>d :Git diffsplit<CR>
nnoremap <silent> <C-g>a :Git add %:p<CR>
nnoremap <silent> <C-g>c :Git commit<CR>
nnoremap <silent> <C-g>p :Git pull<CR>
nnoremap <silent> <C-g>P :Git push<CR>
nnoremap <C-g>b :Git branch<SPACE>
nnoremap <C-g>o :Git checkout<SPACE>
function! GitGutterStatus()
  let l:status = ''
  let [l:a,l:m,l:r] = GitGutterGetHunkSummary()
  if l:a | let l:status .= printf(' +%d', l:a) | endif
  if l:m | let l:status .= printf(' ~%d', l:m) | endif
  if l:r | let l:status .= printf(' -%d', l:r) | endif
  return trim(l:status)
endfunction

" ALE
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_hover_cursor = 0
let g:ale_java_javac_classpath = '.' "TODO
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gD :ALEGoToTypeDefinition<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap <silent> <C-h> :ALEHover<CR>
inoremap <silent><expr> <TAB> pumvisible() ? '\<C-n>' : '<TAB>'
inoremap <silent><expr> <S-TAB> pumvisible() ? '\<C-p>' : '<S-TAB>'
function! ALEErrorStatus()
  let l:status = ''
  let l:counts = ale#statusline#Count(bufnr(''))
  if l:counts.error | let l:status .= printf(' %d Error', l:counts.error) | endif
  if l:counts.error > 1 | let l:status .= 's' | endif
  if l:counts.style_error | let l:status .= printf(' %d Warning', l:counts.style_error) | endif
  if l:counts.style_error > 1 | let l:status .= 's' | endif
  return trim(l:status)
endfunction

" Highlight yank
let g:highlightedyank_highlight_duration = 150
highlight link HighlightedyankRegion Visual

" Markdown Preview
let g:mkdp_auto_close = 0
let g:mkdp_page_title = '${name}'
nmap <C-S-m> <Plug>MarkdownPreviewToggle

" Netrw
let g:netrw_home='~/.local/share/nvim/'
let g:netrw_banner = 0

" Neovide
set guifont=SourceCodePro:h14
let g:neovide_cursor_animation_length=0.1
let g:neovide_cursor_trail_length=0
let g:neovide_cursor_vfx_mode = 'wireframe'

"Misc key mappings
map Q <nop>
map Y y$
nnoremap <silent> <C-l> :nohlsearch<CR>
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

