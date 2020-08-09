set nocompatible
filetype off

syntax on

set showmode
set nowrap
set tabstop=4
set autoindent
set copyindent
set number relativenumber
set numberwidth=4
set showmatch
set ignorecase
set smartcase
set scrolloff=4
set hlsearch
set incsearch
set scrolloff=10
set sidescrolloff=10
set sidescroll=1
set backspace=indent,eol,start

set clipboard=unnamed
set autoread

set history=1000
set undolevels=1000
set nobackup
set nowritebackup
set noswapfile
set viminfo+=n~/.vim/viminfo

set directory=~/.vim/.tmp,~/.tmp,/tmp

set wildmenu
set wildmode=list:full
set wildignore=*.swp,*.bak,*.pyc

set title
set noerrorbells
set showcmd
set modelines=0
set ruler

autocmd InsertEnter * norm zz
autocmd BufWritePre * %s/\s\+$//e

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

noremap <C-c> <ESC>

au FocusLost * :wa

" PLUGINS

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

call vundle#end()
filetype plugin indent on

