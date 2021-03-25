
let g:mapleader = '`'

" Netrw
cabbrev W w
cabbrev Explore Lex
cabbrev Vexplore Lex
cabbrev Sexplore Lex
cabbrev Lexplore Lex
nnoremap <C-e> :Lex<CR>

" ALE
nnoremap gd :ALEGoToDefinitionInTab<CR>
nnoremap gr :ALEFindReferences<CR>
nnoremap K :ALEHover<CR>
nnoremap <C-K> :ALEDetail<CR>
inoremap <silent> <expr> <TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent> <expr> <CR>    pumvisible() ? "\<CR>"  : "\<CR>"

" Tagbar
nnoremap tt :TagbarToggle<CR>

" Markdown
noremap mm :MarkdownPreview<CR>

