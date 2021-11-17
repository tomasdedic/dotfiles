set grepprg=rg\ --vimgrep\ --smart-case\ --follow
let g:fzf_preview_window = []

nmap ; :Buffers<CR>
" nmap <Leader>t :Files<cr>
"hledani souboru
nmap <C-f> :Files<cr>
" find file under cursor
command! -bang  -nargs=? -complete=dir FilesUnderCursor call fzf#vim#files(<q-args>, {'options': '-q '.shellescape(expand('<cword>'))})
nnoremap <silent> <Leader>gf :FilesUnderCursor <CR>
nnoremap <silent> gf :FilesUnderCursor <CR>
"tagy v bufferu
nmap <Leader>e :Tags<CR>
nmap <Leader>h :History:<CR>
"grep
"file not be hit in grep
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
" command! -bar -bang -nargs=? -complete=buffer Buffers call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': ['--delimiter', '/','--with-nth', '-3..' ] }), <bang>0)
command! -bar -bang -nargs=? -complete=buffer Buffers call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'placeholder':"{1}"}), <bang>0)
" command! -bang -nargs=* -complete=dir Files
                " \ call fzf#vim#files(<q-args>, {'options': ['--delimiter', '/', '--with-nth', '-2..', '--preview', 'echo {};echo;~/.vim/bundle/fzf.vim/bin/preview.sh {}']}, <bang>0)
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)
nmap <leader>f :Rg<cr>
"find world under cursor
nnoremap <silent> <Leader>ag :Rg <C-R><C-W><CR>
nnoremap <silent> <Leader>lg :Lines <C-R><C-W><CR>
nmap <leader>c :Commits<cr>
nmap <leader>m :Marks<CR>
"radky v bufferech
nmap <leader>/ :Lines<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
" remap files with subdirs
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
" inoremap <expr> <c-x><c-k> fzf#vim#complete('cat ~/.zsh_history')
" lsp related

