
" General
set shell=sh                         "use (ba)sh instead of user default
set updatetime=500                   "we need much faster refresh time
set undofile                         "persistent undo history
set noswapfile                       "don't keep a swap file, I live on the edge
set nobackup                         "don't save backup files
set nowritebackup                    "don't write backup files
set autoread                         "update buffer if its file changes externally
set clipboard=unnamedplus            "by default, use the system clipboard
set modelines=0                      "stay safe kiddos

" Editor UI
set title                            "update the title of the terminal
set number                           "show line numbers
set relativenumber                   "display line numbers relative to cursor
set cursorline                       "highlight current line
set noshowmode                       "redundant with lightline plugin
set showcmd                          "command history
set scrolloff=10                     "keep 10 lines above/below the cursor when scrolling
set sidescrolloff=15                 "keep 15 columns to the left/right of the cursor when scrolling
set signcolumn=yes                   "the sign column opening and closing gets annoying
set mouse=a                          "mouse support
set list                             "whitespace/hint rendering
set listchars=tab:›\ ,trail:•,precedes:«,extends:»,nbsp:␣

" Syntax, editing and code
syntax enable
set history=1000                     "increase the undo limit
set backspace=indent,eol,start       "backspace over anything
set showmatch                        "highlight matching brackets
set ignorecase                       "case insensitive matching
set smartcase                        "capital sensitive matching
set incsearch                        "search for match while typing
set hlsearch                         "highlight search results
set tabstop=4                        "4-column tab characters
set softtabstop=4                    "4 spaces = tab visually
set shiftwidth=4                     "width for auto-indenting
set autoindent                       "enable auto-indenting
set nowrap                           "do not wrap lines
set foldmethod=indent                "fold code based on indention levels
set foldnestmax=3                    "fold up to 3 nested levels
set nofoldenable                     "disable folding by default
set nospell                          "disable spell-checking by default
filetype plugin indent on            "file-dependant auto-indenting

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable ex mode
map Q <nop>

" Remember last cursor position
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
		\ execute("normal `\"") |
	\ endif

