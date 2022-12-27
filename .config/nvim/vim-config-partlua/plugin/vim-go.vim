let g:go_fmt_command = "goimports"     "Run goimports along gofmt on each save
let g:go_autol_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_gocode_autobuild = 0
let g:go_auto_type_info = 0
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_metalinter_autosave = 0
let g:go_fmt_experimental=1
let g:go_doc_max_height =20
let g:go_auto_type_info = 1
let g:go_template_autocreate = 0
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>(go-doc-browser)
autocmd Filetype go nmap <leader>s :GoRun %<CR>
autocmd BufNewFile,BufRead,BufWinEnter *.go setlocal noexpandtab tabstop=4 shiftwidth=4
" .func files as bash
autocmd BufNewFile,BufRead,BufWinEnter *.func setlocal ft=sh
