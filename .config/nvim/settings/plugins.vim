
" === Plugins === "

call plug#begin(stdpath('data') . '/plugged')

Plug 'whatyouhide/vim-gotham'                                         "theme
Plug 'itchyny/lightline.vim'                                          "status bar
Plug 'ctrlpvim/ctrlp.vim'                                             "fuzzy file path finder
Plug 'airblade/vim-gitgutter'                                         "column git status
Plug 'tpope/vim-fugitive'                                             "git command wrapper
Plug 'majutsushi/tagbar'                                              "code details panel
Plug 'neoclide/coc.nvim', {'branch': 'release'}                       "language server protocol client
Plug 'sheerun/vim-polyglot'                                           "language syntax support
Plug 'preservim/nerdcommenter'                                        "commenting shortcuts
Plug 'tpope/vim-surround'                                             "another Vim selection motion
Plug 'vim-scripts/a.vim'                                              "switching between source and header files
Plug 'Raimondi/delimitMate'                                           "automatic closing of many delimiters
Plug 'vim-scripts/HTML-AutoCloseTag'                                  "automatic closing of HTML tags
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'}  "markdown preview in browser
Plug 'vimwiki/vimwiki'                                                "personal wiki and journal

call plug#end()

let g:vimwiki_list = [{'path': '~/.local/share/vimwiki/', 'auto_diary_index': 1}]
let g:ctrlp_show_hidden = 1

"TODO: most of the plugins need customization

