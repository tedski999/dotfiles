
call plug#begin(stdpath('data') . '/plugged')

Plug 'whatyouhide/vim-gotham'                                                                              "theme
Plug 'itchyny/lightline.vim'                                                                               "status bar
Plug 'ctrlpvim/ctrlp.vim'                                                                                  "fuzzy file path finder
Plug 'airblade/vim-gitgutter'                                                                              "column git status
Plug 'majutsushi/tagbar'                                                                                   "code details panel
Plug 'sheerun/vim-polyglot'                                                                                "language syntax support
Plug 'tpope/vim-surround'                                                                                  "another Vim selection motion
Plug 'vim-scripts/a.vim'                                                                                   "switching between source and header files
Plug 'vimwiki/vimwiki'                                                                                     "personal wiki and journal
Plug 'dense-analysis/ale'                                                                                  "LSP client
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }                                              "autocomplete
Plug 'Shougo/echodoc.vim'                                                                                  "more code details
Plug 'tweekmonster/deoplete-clang2'                                                                        "improved c language autocomplete
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}  "markdown previewer

call plug#end()

let g:vimwiki_list = [{'path': '~/.local/share/vimwiki/', 'auto_diary_index': 1}]

"ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1

"autocomplete & co
let g:deoplete#enable_at_startup = 1
let g:echodoc#enable_at_startup = 1
set completeopt-=preview
let g:ale_java_javac_classpath = ".:/usr/share/java/hamcrest-core.jar:/usr/share/java/junit.jar"

"markdown
let g:mkdp_auto_close = 0

