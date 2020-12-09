
let g:mapleader = '`'

cabbrev W w
cabbrev E Explore

"automatically close braces
inoremap { {}<ESC>i

nnoremap gd :ALEGoToDefinitionInTab<CR>
nnoremap gr :ALEFindReferences<CR>
nnoremap K :ALEHover<CR>
nnoremap <C-K> :ALEDetail<CR>
inoremap <silent> <expr> <TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent> <expr> <CR>    pumvisible() ? "\<CR>"  : "\<CR>"

nnoremap <leader>o :E<CR>
nnoremap <leader>t :TagbarToggle<CR>

noremap <leader>m :MarkdownPreview<CR>

"TODO: make/compile shortcuts

