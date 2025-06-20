" !IMPORTANT! Config maps HJKL to JKL:

" Move between splits
map <C-h> :wincmd h<CR>
map <C-j> :wincmd j<CR>
map <C-k> :wincmd k<CR>
map <C-l> :wincmd l<CR>

" Move splits
" map <A-j> :wincmd H<CR>
" map <A-k> :wincmd J<CR>
" map <A-l> :wincmd K<CR>
" map <A-;> :wincmd L<CR>

"make vim hard again
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Copy to system clipboard mapping
nnoremap cp "+y
vnoremap cp "+y

nnoremap <Leader>yy ^yg_

" Move selection up and down plus formatting
vnoremap K :m '>+1<CR>gv=gv
vnoremap L :m '<-2<CR>gv=gv

" Change CWD to current file path's dir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Go to normal mode in terminal window
tnoremap <silent> <C-o><C-i> <C-\><C-n>
tnoremap <silent> <C-_> <C-\><C-n>
" Clear search highlight
map <leader>cs :noh<CR>

" Map command-v in normal insert and command modes to paste from clipboard
nnoremap <D-v> :set paste<CR> a<C-r>+<Esc> :set nopaste<CR>
inoremap <D-v> <Esc> :set paste<CR> i<C-r>+<Esc> :set nopaste<CR>
cmap <D-v> <C-r>+

" nnoremap <D-v> a<C-r>+<Esc>
inoremap <D-v> <C-r>+
cnoremap <D-v> <C-r>+

" Paste from external keyboard
tnoremap <D-v> <C-\><C-n>"+pa

" Force close
nnoremap <leader>Q :q!<CR>

":set paste<CR> i<C-r>+ <Esc>:set nopaste<CR>

" Map command-s to save
nnoremap <D-s> :w<CR>
inoremap <D-s> <esc> :w<CR>


" Paste without yanking for easier paste repetition
vnoremap p "_dP
xnoremap p "_dP

" Search from visual selection

" Copy file name or path
nmap <leader>crp :let @+=expand("%")<CR>:echo "Copied relativepath: ".@+<CR>
nmap <leader>cap :let @+=expand("%:p")<CR>:echo "Copied absolutepath: ".@+<CR>
nmap <leader>cfn :let @+=expand("%:t")<CR>:echo "Copied filename: ".@+<CR>

" Run a given vim command on the results of alt from a given path.
" See usage below.
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction


" Leader mappings for split and vertical split
nnoremap <leader>vsp :vsp<CR>
nnoremap <leader>sp :sp<CR>
nnoremap <leader>q :q<CR>

" " Delete all commented lines then save to reformat
nnoremap <leader>dac :g/\v^(\/\/<bar>.*\/\/)/d_<CR>:w<CR>:noh<CR>

" Select line
nnoremap vv V

" " Buffer next/previous
" nnoremap <leader>; <cmd>bn<CR>
" nnoremap <leader>j <cmd>bp<CR>

" Tab navigation numbered
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 5gt
nnoremap <leader>7 5gt
nnoremap <leader>8 5gt
nnoremap <leader>9 5gt

" Tab navigation
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tj :tabnew<CR>
nnoremap tk :tabclose<CR>


nnoremap <leader>mk "ayy
nnoremap <leader>rk @a

" Generate test
nnoremap <leader>gt <cmd>!npm run generate:test %<CR>

let g:diff_is_open = 0

function! ToggleDiff()
  if g:diff_is_open
    windo diffoff
    let g:diff_is_open = 0
  else
    windo diffthis
    let g:diff_is_open = 1
  endif
endfunction

" Diff this
nnoremap <leader>dt <cmd>call ToggleDiff()<CR>

" Quickfix next/prev/open
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
nnoremap <localleader>q :copen<CR>

" Global statusline
set laststatus=3

cmap Q qa!
" nmap \r :!tmux send-keys -t bottom-left Up Enter <CR><CR>
" nmap \rr :!tmux send-keys -t top-left Up Enter <CR><CR>
nmap \r :!tmux send-keys -t bottom Up Enter <CR><CR>
" absolute path to file
command! -nargs=0 Path let @+=expand("%:p")
command! -nargs=0 File let @+=expand("%:p")
" absolute path to dir
command! -nargs=0 Dir let @+=expand("%:p:h")
" gp to reselect last paste text
nnoremap gp `[v`]
" change cwd (local win) to path of buffer
map <leader>cd :lcd %:p:h<CR>


" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd <cmd>call RemoveQFItem()<CR>

" Running the following command will open the parent tree:
" autocmd User fugitive
"   \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
"   \   nnoremap <buffer> .. :edit %:h<CR> |
"   \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

" ['<localleader>y'] = { name = '󰆏 Copy...' },
" ['<localleader>yp'] = { function() vim.fn.setreg('+', vim.fn.expand('%:p:.')) end, desc = 'Copy file path' },
" ['<localleader>yd'] = { function() vim.fn.setreg('+', vim.fn.expand('%:h')) end, desc = 'Copy directory path' },
" ['<localleader>yf'] = { function() vim.fn.setreg('+', vim.fn.expand('%:t:r')) end, desc = 'Copy file name' },
"vim.fn.expand('%:p:.')
"vim.fn.expand('%:h') 
"vim.fn.expand('%:t:r')
