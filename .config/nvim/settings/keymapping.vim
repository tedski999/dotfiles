
" Netrw
cabbrev E Explore
cabbrev Vexplore Lexplore
cabbrev Sexplore Lexplore
nnoremap <C-e> :Lexplore<CR>

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

" I'm a fat-fingered save scummer
cabbrev W w

