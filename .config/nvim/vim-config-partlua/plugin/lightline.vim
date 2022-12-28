"obsession integration

let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'obsess' ], [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified']],
      \   'right': [
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype'],['pwd']]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'obsess': 'ObsessionStatus',
      \   'pwd': 'Pwd'
      \ },
      \ 'tabline': {'left': [['buffers']], 'right': [['method']]},
      \ 'component_expand': {'buffers': 'lightline#bufferline#buffers'},
      \ 'component_type': {'buffers': 'tabsel'},
      \ }
set showtabline=2
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[N]'
function! Pwd()
  return fnamemodify(getcwd(), ':t')
  " return fnamemodify(getcwd(), ':~')
endfunction

