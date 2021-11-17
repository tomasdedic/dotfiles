set shell=/bin/bash "pouzivame fish je potreba to rozdelit
set t_Co=256
set cursorline
set lazyredraw
set autochdir
set synmaxcol=256
syntax sync minlines=256
set nocompatible
let mapleader = ","
filetype off
call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
"let g:ackprg = 'ag --vimgrep --smart-case'                                                   
let g:ackprg = 'ag --nogroup --nocolor --column'
cnoreabbrev ag Ack!                                                                           
cnoreabbrev Ack Ack!
cnoreabbrev aG Ack!                                                                           
cnoreabbrev Ag Ack!                                                                           
cnoreabbrev AG Ack!  
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
Plug 'echuraev/translate-shell.vim'
Plug 'thaerkh/vim-indentguides'
Plug 'gioele/vim-autoswap'
"completition
Plug 'Shougo/deoplete.nvim'
	"let g:deoplete#num_processes = 1
" Use deoplete.
	let g:deoplete#enable_at_startup = 1
	" Use smartcase.
	let g:deoplete#enable_smart_case = 1
	set completeopt+=noselect
	" deoplete-go settings
	let g:deoplete#sources#go#gocode_binary ='~/go/bin/gocode'
	let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
	let g:deoplete#sources#go#use_cache = 1
	"	call deoplete#enable_logging('DEBUG','deoplete.log')
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function() abort
	  return deoplete#close_popup() . "\<CR>"
	endfunction
"musi byt nasetovano kvuli deoplate s pythonem mensim nez 3.5 to nefunguje
let g:python3_host_prog='/usr/local/bin/python3.6'
"echo g:python3_host_prog
"echo exepath('python3')
"
Plug 'roxma/nvim-yarp'
"let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
"let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
Plug 'roxma/vim-hug-neovim-rpc'
"golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'benmills/vimux'
"Plug 'talek/vorax4'
"Plug 'fholgado/minibufexpl.vim'
"Plug 'BufOnly.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'sandeepcr529/Buffet.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'luochen1990/rainbow'
"Plug 'jeetsukumaran/vim-buffergator'
"plugin ke komentovani celych radku a tak
Plug 'scrooloose/nerdcommenter'
"power command line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"fuzzy finder
"Plug 'kien/ctrlp.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jmcantrell/vim-virtualenv'
"record session :obsession 
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
"plugin na zabrazovani marks disabloval jsem ho kvuli chybe
"Plug 'kshenoy/vim-signature'
Plug 'Shougo/vimproc.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
"linting
Plug 'w0rp/ale'
let g:ale_linters = {'python': ['autopep8','pylint','isort'],'sql':['sqlint']}
let g:ale_fixers = {'python': ['autopep8','trim_whitespace','remove_trailing_lines','isort'],'yaml':['prettier','remove_trailing_lines','trim_whitespace']}
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
" Set this if you want to.
" " This can be useful if you are combining ALE with
" " some other plugin which sets quickfix errors, etc.
 let g:ale_keep_list_window_open = 1
"let g:ale_completion_enabled = 1
" Put this in vimrc or a plugin file of your own.
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
" define fixers :ALEFixSuggest doporuci jake tooly nainstalovat
"let g:ale_fixers = {
"\   'sh': ['shfmt'],
"\}
" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
"let g:ale_fix_on_save = 1
"color schemes
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'jacoborus/tender.vim'

"full screen plugin"
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
"Plug 'junegunn/goyo.vim'
autocmd! User goyo.vim echom 'Goyo is now loaded!'
let g:goyo_width=120
map <F10> :Goyo<CR>

Plug 'sheerun/vim-polyglot'

"markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'

"ctags
Plug 'craigemery/vim-autotag'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-sort-motion'
Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar'
"display marks
Plug 'jeetsukumaran/vim-markology'

"fish shell syntax
Plug 'dag/vim-fish'

" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
let g:UltiSnipsSnippetsDir="~/.vim/Ultisnips/"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"


"augroup markdown
"    au!
"    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=markdown
"augroup END

let g:vim_markdown_frontmatter=1
let g:vim_markdown_json_frontmatter=1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_override_foldtext = 0
let g:rainbow_active = 1
""""""""""""""""""""""""""""""""""""""""
"python related
"Plug 'klen/python-mode'
Plug 'skywind3000/asyncrun.vim'
"Python vypnut
Plug 'davidhalter/jedi-vim'
let g:jedi#popup_on_dot =0
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#completions_enabled = 1
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#max_doc_height = 20
let g:jedi#min_doc_height = 20
"pro deoplate
Plug 'zchee/deoplete-jedi'
"v kombinaci s jedi-vim
"nechci aby po tecce vyskakoval kontext help
let g:pymode_python = 'python3'
let g:pymode_rope = 0
" Documentation
"let g:pymode_doc = 1
"let g:pymode_doc_key = 'K'
"Linting
"let g:pymode = 0
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E261,W601,E231,E225,E305,E302,E228,W0404,E201,E202"

" Auto check on save
let g:pymode_lint_write = 1
" Support virtualenv
" let g:pymode_virtualenv = 1
" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
" Don't autofold code
let g:pymode_folding = 0
let g:pymode_run_bind = '<leader>xx'
let g:pymode_options_max_line_length = 120
"
let g:pymode_quickfix_minheight = 6
let g:pymode_quickfix_maxheight = 6
let pymode_virtualenv = 1
let pymode_virtualenv_path = ''
call plug#end()


" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>
""""""""""""""""""""""""""""""

"/folding save when leave vim and load on startup
augroup AutoSaveFolds
autocmd!
autocmd BufWinLeave .* mkview!
autocmd BufWinEnter .* silent loadview
augroup END

"avoid resizing window after split 
set noea
set history=1000
"set ft=txtfmt

let g:netrw_liststyle=3
" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" CTRL-C is Copy
vnoremap <C-Insert> "+y
set hidden
set mouse=a
set gfn=Bitstream\ Vera\ Sans\ Mono\ 10
if has('gui_running')
set guioptions+=b
set guioptions-=T   " v gui se vypne lista nastroju
set guioptions-=t   " v gui se vypne lista nastroju
set guioptions-=m   " vypneme menu
set guioptions-=r   "vypneme right scrollbar
set guioptions-=l   "vypneme left scrollbar
set guioptions-=L   "kill left with multiple buffers
set guitablabel=%t
endif
" show matching brackets
autocmd FileType perl set showmatch
autocmd FileType php set showmatch
autocmd FileType python set showmatch

" show line numbers
autocmd FileType perl set number
autocmd FileType php set number
autocmd FileType python set tabstop=8|set expandtab|set softtabstop=4|set shiftwidth=4|set textwidth=79
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    augroup END
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" 4 space tabs
autocmd FileType perl set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4

 let g:NERDTreeWinPos="right"
 map ET :TagbarToggle<CR>
 let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }
let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds' : [
        \'p:package',
        \'f:function',
        \'v:variables',
        \'t:type',
        \'c:const'
    \]
\}
"vorax connection window
map EE :NERDTreeToggle<CR>

" comment/uncomment blocks of code (in vmode)
 vmap _c :s/^/#/gi<Enter>
 vmap _C :s/^#//gi<Enter>

"pokud je na prvnim radku skriptu #! tak po zmacknuti f5 se spusti
function! CheckForShebang()
if (match( getline(1) , '^\#!') == 0)
map < F5 > :!./%< CR >
else
unmap < F% >
end
endfunction
map < F5 > :call CheckForShebang()


"mezera mezi radkami
"set number
set foldcolumn=1   "abychom videli kde mame foldy
set lsp=4 
syntax on
"colorscheme wombat
if &t_Co>2 ||has("gui_running")
	set hlsearch
endif

if has('gui_running') 
        colorscheme wombat 
        let g:airline_theme='wombat'

        
else 
        set background=dark
        "let g:gruvbox_contrast_dark='soft'
        let g:airline_theme='papercolor'
        colorscheme PaperColor
endif 



"cursor colors and blinking
"highlight Cursor guifg=white guibg=indianred
highlight Cursor guifg=indianred guibg=white
"highlight iCursor guifg=white guibg=darkred
highlight iCursor guifg=indianred guibg=white
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait700-blinkon5000-blinkoff500

"no spelling
set nospell

"auto read when a fileis changed from outside
set autoread
set autowrite
"faster tty
set ttyfast

set noerrorbells
set novisualbell
"backup and swap directory
set nobackup
"set backupdir =~/.vim/filebackup
set directory =~/.vim/swapfiles//
set confirm
set incsearch
set wildchar=<Tab> 
set wildmenu 
"ignore some from autocomplete
set wildignore+=*.swp,*.bak
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildmode=list:longest
set encoding=utf-8
set fileencodings=utf-8,latin2
set cmdheight=1     " prikazovy radek o velikosti dva radky
set ruler           " ukazuje se umisteni kurzoru v prik. radku
set backspace=2
set autoindent   " autoindent - automaticke odsazovani textu dle 
                    "              predchoziho radku
                    " noautoindent vypina autoindent
                    " viz. take smartindent, cindent, cinkeywords a
                    "           indentexpr
set expandtab       " misto tabelatoru se vkladaji mezery
set showcmd         " ukazuje se zadavani prikazu v prik. radku
set showmode        " ukazuje se aktualni rezim editoru v prik. radku
set scrolloff=3                 " min. pocet zobrazenych radku pod a nad 
                                " kurzorem
set sidescroll=1                " pocet sloupco o ktere se bude okno posouvat 
                                " do stran
set sidescrolloff=1             " min. pocet znaku zobr. po stranach kurzoru

" nastaveni inkrementace a dekrementace znaku
set nrformats=alpha,hex         " entity ktere VIM muze inkrementovat a 
                                " dekrementovat prikazy ^A a ^X
set ignorecase      " vypne rozlisovani velikosti pismen pri vyhledavani
set smartcase       " chytre rozlisovani velikosti pismen ve vyhledavani
                    " (rozlisuji se jen kdyz jsou zadana velke pismena
                    " tj. vyraz Pes najde jen slovo Pes, ale slovo 
                    " funguje jen kdyz je nastaveno ignorecase
                    " tj. kdyz je ignorovani zakazano, plati to i pro
                    " smartcase
                    " pes najde slova pes, Pes, PES, pEs a pod.)
set incsearch                   " inkrementalni vyhledavani (pri hledani 
                                " nejakeho textu se tento vyhledava uz pri
                                " jeho zadavani)
set viminfo=!,'20,\"50
set notimeout       " pri spojovani radku nezdvojuj mezery za znaky: .?!
                    " americka typografie mezi vety vklada dve mezery
                    " u nas je to nezadouci, radky se spojuji napr. pri 
                    " formatovani textu

set wrap            " zapne zdanlive zalamovani radek
set linebreak       " hezci zdanlive zalamovani (normalne se radky zalamuji
                    " na konci obrazovky, treba i u prostred slova, s
                    " touto volbou se zalamuji jen na vybranych mistech.
set showbreak==>    " ukazatel pokracovani radku (znacka ktera se vklada na
                    " zacatek zdanliveho zalomeni, aby bylo zretelne, ze
                    " se jedna jen o zdanlive zalomeni, zde je to => a je
                    " zobrazena zvlastni barvou, aby se nepletla se skutecnym
                    " textem).
set list
set list listchars=precedes:<,extends:>,trail:_,tab:..,nbsp:~
set showbreak=\\
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab     
                    " zobrazovani specialnich znaku a situaci:
                    " orecedes - znak ktery ukazuje, ze radek pokracuje vlevo
                    "            za obrazovku
                    " extends -  znak ktey ukazuje, ze radek pokracuje vpravo
                    "            za obrazovku
                    " trail -    znak zobrazeni vychodovych mezer (mezer na
                    "            konci radku). Zobrazuje se jen kdyz je
                    "            nastaven option list.
                    " tab -      znaky ktere ukazuji tabelator, druhy se
                    "            opakuje az do konce radku. Zobrazuje se jen
                    "            kdyz je nastaven option list.
                    " eol -      znak ktery zobrazuje konec radku, zobrazuje
                    "            se jen kdyz je nastaven option list
set shiftwidth=2    " velikost odsazeni, dle neho se orientuje automaticke
                    " formatovani textu dle syntaxe, prikazy Ctrt-T a Ctrl-D
                    " v insert rezimu, prikazy >> a <<, metoda foldovani dle
                    " odsazeni a tak dale.
set formatoptions=tcqron2  
    " nastaveni formatovani:
    " t - aut. zalamuj text dle textwidth
    " c - aut. zalamuj komentare
    " q - povoli formatovani komentaru prikazem gq (premapovano na Q)
    " r - aut. vloz komentarovy znak po stisknuti klavesy Enter
    " o - aut. vloz komentarovy znak po prikazu o nebo O
    " n - pri formatovani textu rozeznavej cislovane listy
    " 2 - pri formatovani textu se rid podle druhe radky odstavce
    "     prvni radka tak muze mit jine odsazeni
    " l - kdyz je nejaky radek delsi nez textwith, nepreformatuj
    "     ho automaticky
set autoindent      " autoindent - automaticke odsazovani textu dle 
                    "              predchoziho radku
                    " noautoindent vypina autoindent
                    " viz. take smartindent, cindent, cinkeywords  a
                    "           indentexpr
set cmdheight=1     " prikazovy radek o velikosti dva radky
set ruler           " ukazuje se umisteni kurzoru v prik. radku
set showcmd         " ukazuje se zadavani prikazu v prik. radku
set showmode        " ukazuje se aktualni rezim editoru v prik. radku
set vb              "visual bell misto beep  
set t_vb="<Esc>|40f"  "visual bell misto beep  
set novisualbell
set foldmethod=manual "za open and close folds
set foldlevel=99

" nastaveni tabelatoru
"set expandtab       " misto tabelatoru se vkladaji mezery
autocmd BufRead [Mm][Aa][Kk][Ee][Ff][Ii][Ll][Ee]* set noexpandtab

nmap <silent> ,, :nohlsearch<cr>

"autocompletition remap to ctrlspace
"inoremap <C-Space> <C-x><C-o>
"inoremap <C-@> <C-x><C-o>
"inoremap <Nul> <C-x><C-o> 

map em :%g/^$/d<cr>
"remove trailing characters at the end of line
map tr :%s/\s\+$//
au! BufWritePost .vimrc source %  "autocommand reload vimrc
"nnoremap ' `                   
"nnoremap ` '                                 
                                " premapovani podobna funkce 'skace na zacatek radku a to druhy tam kde sme 
                                "udelali mark a ja to nemuzu najit na
                                "klavesnici



"omnicompletition menu <C-X><C-O>
highlight PMenu gui=bold guibg=Brown 
" Let me choose the statusbar airline
set laststatus=2
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
  
" Let the statusbar as it is for inactive windows  
let g:airline_inactive_collapse=0  

"foldy v fold column +
hi FoldColumn guifg=DarkRed
" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0
" Search in certain directories a large project (hardcoded for now)
cnoremap %proj <c-r>=expand('~')<cr>
" ga = go api
"map <Leader>ga :CtrlP %proj/<cr>
"remap na konkretni adresar
"map <C-p> :CtrlP %proj/<cr>
map <C-p> :CtrlPBuffer <cr>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

"dokumentace se bude zobrazovat dole splitbelow funguje ale blbne s
"prekreslovanim splitright funguje jen pro split 
"set splitbelow
" set splitright
"call vundle#end()            " required
filetype plugin indent on    " required

set clipboard=unnamedplus
set clipboard+=unnamed  " use the clipboards of vim and win
"set paste               " Paste from a windows or from vim
set go+=a               " Visual selection automatically copied to the
"line numbering
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
nmap <leader>bl :Bufferlist<CR>
"make vim hard again
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

function! s:SwitchColorscheme()
  if exists('g:colors_name')
    "if g:colors_name == 'PaperColor'
    if &background == 'light'
			let g:airline_theme='papercolor'
      colorscheme PaperColor
      set background=dark
    "elseif g:colors_name == 'gruvbox'
    elseif &background == 'dark'
			let g:airline_theme='papercolor'
      colorscheme PaperColor
      set background=light
    endif
  endif
endfunction

map <silent> <F6> :call <SID>SwitchColorscheme()<CR>

" vim-go-tutorial
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>(go-doc-browser)
autocmd Filetype go nmap <leader>s :GoRun %<CR>
"autocmd FileType go set foldmethod=syntax
"autocmd FileType go silent loadview
let g:go_auto_type_info = 1
set updatetime=100
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
autocmd BufNewFile,BufRead,BufWinEnter *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
let g:go_metalinter_autosave = 0
let g:go_fmt_experimental=1
let g:go_doc_max_height =20

if has('persistent_undo')
	  set undofile
		  set undodir=~/tmp/undo
		endif
autocmd FileType mkd set ft=markdown
cmap Q qa!
"odstranit premapovani Enteru v quickfixu
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" `gf` opens file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<CR>
"set debug VIM
"set verbose=9
"set verbosefile=/tmp/vimfilename.txt
"nmap \r :!tmux send-keys -t 0:0.1 C-p C-j <CR><CR>
nmap \r :!tmux send-keys -t right C-Up Enter <CR><CR>

