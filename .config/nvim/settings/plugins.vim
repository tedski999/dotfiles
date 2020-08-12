
" === Plugins === "

call plug#begin(stdpath('data') . '/plugged')

Plug 'whatyouhide/vim-gotham'                    "theme
Plug 'itchyny/lightline.vim'                     "status bar
Plug 'ctrlpvim/ctrlp.vim'                        "fuzzy file path finder
Plug 'preservim/nerdtree'                        "file explorer
Plug 'jistr/vim-nerdtree-tabs'                   "file explorer improved panelling
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'   "file explorer color
Plug 'Xuyuanp/nerdtree-git-plugin'               "file explorer git status
Plug 'airblade/vim-gitgutter'                    "column git status
Plug 'tpope/vim-fugitive'                        "git command wrapper
Plug 'majutsushi/tagbar'                         "code details panel
Plug 'neoclide/coc.nvim', {'branch': 'release'}  "code auto-complete
Plug 'sheerun/vim-polyglot'                      "language support
Plug 'preservim/nerdcommenter'                   "commenting shortcuts
Plug 'tpope/vim-surround'                        "another Vim selection motion
Plug 'vim-scripts/a.vim'                         "switching between source and header files
Plug 'Raimondi/delimitMate'                      "Automatic closing of many delimiters
Plug 'vim-scripts/HTML-AutoCloseTag'             "Automatic closing of HTML tags

call plug#end()


" === NERDTree settings === "

let g:NERDTreeMinimalUI = 1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" Autostart NERDTree when opening nothing or a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Close Vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Custom git icons for NERDTree
let g:NERDTreeGitStatusConcealBrackets = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
        \ 'Modified'  :'*', 'Staged'  :'+',
        \ 'Untracked' :'!', 'Renamed' :'~',
        \ 'Unmerged'  :'═', 'Deleted' :'X',
        \ 'Dirty'     :'*', 'Ignored' :'#',
        \ 'Clean'     :'✔︎', 'Unknown' :'?'
	\ }


"TODO: most of the plugins need customization

