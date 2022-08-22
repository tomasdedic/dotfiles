set shell=/usr/bin/zsh
set completeopt=menu,menuone,noselect
"autocompletition enhance separatoor mezi slovy
set iskeyword+=\-
set iskeyword+=\_
set iskeyword+=\.
" set t_Co=256
set foldenable
set cursorline
set lazyredraw

" set synmaxcol=256
syntax sync minlines=256
set nocompatible
let g:mapleader = ","
let g:maplocalleader = ','
set timeoutlen=500
filetype off

call plug#begin('~/.vim/plugged')
"registers
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
"terminal integration
Plug 'akinsho/toggleterm.nvim'
" LSP
Plug 'neovim/nvim-lspconfig'
" LSP servers auto install
Plug 'williamboman/nvim-lsp-installer' , {'branch': 'main' }
" NOTE: Use either one of this
Plug 'hrsh7th/cmp-nvim-lsp' , {'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', {'branch': 'main' }
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp', {'branch': 'main' }
" Better LSP experience
"Plug 'glepnir/lspsaga.nvim', {'branch': 'main' }
" Plug 'onsails/lspkind-nvim'
" Plug 'sbdchd/neoformat'
"Plug 'p00f/nvim-ts-rainbow'
"Plug 'gennaro-tedesco/nvim-peekup'
" Plug 'ray-x/lsp_signature.nvim'
Plug 'szw/vim-maximizer'
" Plug 'dyng/ctrlsf.vim'
" Better syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate all' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" paranthesis color diff
" Plug 'p00f/nvim-ts-rainbow'
" -- Snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main' } "completition for vsnip
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" -- Snippets premake
Plug 'rafamadriz/friendly-snippets', {'branch': 'main' }
" Plug 'SirVer/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips' "completition for ultisnips
" -- show textdocuments/codeactions
Plug 'kosayoda/nvim-lightbulb'
"Plug 'mfussenegger/nvim-lint'


" auto yaml folds
Plug 'pedrohdz/vim-yaml-folds'
" Plug 'lmeijvogel/vim-yaml-helper'
Plug 'jeetsukumaran/vim-indentwise'
"Plug 'mileszs/ack.vim'
" set autochdir
map ad :set autochdir!<CR>
"let g:ackprg = 'ag --vimgrep --smart-case'
"let g:ackprg = 'ag --nogroup --nocolor --column'
cnoreabbrev ag Ag
cnoreabbrev rg Rg
" cnoreabbrev md Ag --markdown
" cnoreabbrev yaml Ag --yaml
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" whitespace management
"Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_ctermcolor='174'

Plug 'airblade/vim-rooter'
let g:rooter_manual_only = 1
let g:rooter_targets = '/,*'
Plug 'gioele/vim-autoswap'
"helm syntax
Plug 'towolf/vim-helm'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
" plugin for netrw
Plug 'tpope/vim-vinegar'
Plug 'romainl/vim-cool/' "hlsearch auto on/off
let g:CoolTotalMatches = 1

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
" sessions manager
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
"git related
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_disable_when_zoomed = 1
" Plug 'tmux-plugins/vim-tmux-focus-events'
"color schemes
Plug 'nanotech/jellybeans.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jacoborus/tender.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
nnoremap <C-n> :NvimTreeToggle<CR>
"full screen plugin only for markdown
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
let g:goyo_width=160


"markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|'
Plug 'plasticboy/vim-markdown'
" let g:vim_markdown_folding_disabled = 1
"tagbar
Plug 'liuchengxu/vista.vim'
"display marks
Plug 'jeetsukumaran/vim-markology'
"working with mustache and handlebars templates.
Plug 'mustache/vim-mustache-handlebars'
let g:mustache_abbreviations = 1

let g:vsnip_snippet_dir="~/.config/nvim/vsnip"
"skovavani specialnich tagu hlavne pro markdown
set conceallevel=0

"golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" let g:go_gopls_enabled =0
" let g:go_info_mode = 'guru'
"LSP
" Plug 'neoclide/coc.nvim', {'do':'yarn install --frozen-lockfile'}

call plug#end()


" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>
"folding save when leave vim and load on startup
" augroup AutoSaveFolds
"   autocmd!
"   au BufWinLeave ?* silent! mkview
"   au BufWinEnter ?* silent! loadview
" augroup END
"avoid resizing window after split
"autocmd BufWinLeave .* mkview!
set noea
set history=1000


" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" CTRL-C is Copy
vnoremap <C-Insert> "+y
set hidden
set updatetime=300
set signcolumn=yes
set mouse=a
set shortmess+=c
" set gfn=Bitstream\ Vera\ Sans\ Mono\ 10
set gfn=Hack\ 8
" show matching brackets
autocmd FileType perl set showmatch
autocmd FileType php set showmatch
autocmd FileType python set showmatch
autocmd FileType json let g:indentLine_enabled=0

" show line numbers
autocmd FileType python set tabstop=8|set expandtab|set softtabstop=4|set shiftwidth=4|set textwidth=79
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    augroup END
" add yaml stuffs
autocmd FileType yaml set ts=2 sts=2 sw=2 expandtab
autocmd FileType helm set ts=2 sts=2 sw=2 expandtab iskeyword+=\.
autocmd FileType helm set commentstring=#\ %s
autocmd FileType perl set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
autocmd FileType markdown setlocal ts=2 sts=2 sw=2 expandtab

augroup filetypedetect
    autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy
augroup END
 map EE :Vista!!<CR>
 " let g:tagbar_left = 1
set foldcolumn=1   "abychom videli kde mame foldy
set lsp=4
syntax on
if has('termguicolors')
   set termguicolors
endif
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_italic=1
colorscheme gruvbox

highlight Cursor guifg=indianred guibg=white
highlight iCursor guifg=indianred guibg=white
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
set nowritebackup
set directory =~/.vim/swapfiles//
set confirm
set incsearch
set wildchar=<Tab>
set wildmenu
"ignore some from autocomplete
set wildignore+=*.swp,*.bak,*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico,*.pdf,*.psd,*.so,*.swp,*.zip
set wildmode=list:longest
set encoding=utf-8
set fileencodings=utf-8,latin2
set cmdheight=2     " prikazovy radek o velikosti dva radky
set ruler           " ukazuje se umisteni kurzoru v prik. radku
set backspace=2
set autoindent   " autoindent - automaticke odsazovani textu dle predchoziho radku  noautoindent vypina autoindent  viz. take smartindent, cindent, cinkeywords a indentexpr
set expandtab       " misto tabelatoru se vkladaji mezery
set showcmd         " ukazuje se zadavani prikazu v prik. radku
set showmode        " ukazuje se aktualni rezim editoru v prik. radku
set scrolloff=3                 " min. pocet zobrazenych radku pod a nad
                                " kurzorem
set sidescroll=1                " pocet sloupco o ktere se bude okno posouvat
set sidescrolloff=1             " min. pocet znaku zobr. po stranach kurzoru
" nastaveni inkrementace a dekrementace znaku
set nrformats=alpha,hex         " entity ktere VIM muze inkrementovat a " dekrementovat prikazy ^A a ^X
set ignorecase      " vypne rozlisovani velikosti pismen pri vyhledavani
set smartcase       " chytre rozlisovani velikosti pismen ve vyhledavani
set incsearch                   " inkrementalni vyhledavani (pri hledani
set viminfo=!,'20,\"50
set wrap            " zapne zdanlive zalamovani radek
set linebreak       " hezci zdanlive zalamovani (normalne se radky zalamuji na konci obrazovky, treba i u prostred slova, s  touto volbou se zalamuji jen na vybranych mistech.
set showbreak==>    " ukazatel pokracovani radku (znacka ktera se vklada na zacatek zdanliveho zalomeni, aby bylo zretelne, ze se jedna jen o zdanlive zalomeni, zde je to => a je  zobrazena zvlastni barvou, aby se nepletla se skutecnym textem).
" set list
" set list listchars=precedes:<,extends:>,trail:_,tab:..,nbsp:~
set nolist
" set showbreak=\\
set shiftround
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftwidth=2
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
set autoindent      " autoindent - automaticke odsazovani textu dle predchoziho radku  noautoindent vypina autoindent viz. take smartindent, cindent, cinkeywords  a            indentexpr
set ruler           " ukazuje se umisteni kurzoru v prik. radku
set showcmd         " ukazuje se zadavani prikazu v prik. radku
set showmode        " ukazuje se aktualni rezim editoru v prik. radku
set vb              "visual bell misto beep
set t_vb="<Esc>|40f"  "visual bell misto beep
set novisualbell
" set foldlevel=99
set foldlevelstart=20

"autocmd BufRead [Mm][Aa][Kk][Ee][Ff][Ii][Ll][Ee]* set noexpandtab
map em :%g/^$/d<cr>
"remove trailing characters at the end of line
map tr :%s/\s\+$//
highlight PMenu gui=bold guibg=Brown
set laststatus=2
"foldy v fold column +
hi FoldColumn guifg=DarkRed
cnoremap %proj <c-r>=expand('~')<cr>

filetype plugin indent on    " required

set clipboard=unnamedplus
set clipboard+=unnamed  " use the clipboards of vim and win
set go+=a               " Visual selection automatically copied to the
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
"make vim hard again
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
function! s:SwitchColorscheme()
  if exists('g:colors_name')
    "if g:colors_name == 'PaperColor'
    if &background == 'light'
      set background=dark
      colorscheme gruvbox
    "elseif g:colors_name == 'gruvbox'
    elseif &background == 'dark'
      set background=light
      colorscheme PaperColor
    endif
  endif
endfunction
map <silent> <F6> :call <SID>SwitchColorscheme()<CR>
" nnoremap <silent><F3> :MaximizerToggle<CR>
" vnoremap <silent><F3> :MaximizerToggle<CR>gv
" inoremap <silent><F3> <C-o>:MaximizerToggle<CR>

" vim-go-tutorial
map <C-.> :cnext<CR>
map <C-,> :cprevious<CR>

nnoremap <leader>a :cclose<CR>
if has('persistent_undo')
	  set undofile
		  set undodir=~/tmp/undo
		endif
cmap Q qa!
"set debug VIM
"set verbose=9
"set verbosefile=/tmp/vimfilename.txt
"nmap \r :!tmux send-keys -t 0:0.1 C-p C-j <CR><CR>
nmap \r :!tmux send-keys -t bottom-left Up Enter <CR><CR>
nmap \rr :!tmux send-keys -t top-left Up Enter <CR><CR>
nmap \rd :!tmux send-keys -t bottom Up Enter <CR><CR>

" 1. base64-encode(visual-selection) -> F2 -> encoded base64-string
vnoremap <F2> c<c-r>=system("base64 -w 0", @")<cr><esc>
" 2. base64-decode(visual-selection) -> F3 -> decoded string
vnoremap <F3> c<c-r>=system("base64 -d", @")<cr>

" absolute path to file
command! -nargs=0 Path let @+=expand("%:p")
" absolute path to dir
command! -nargs=0 Dir let @+=expand("%:p:h")
" gp to reselect last paste text
nnoremap gp `[v`]

" autocmd BufRead,BufNewFile,BufWinEnter */templates/*.yaml,*/templates/*.tpl,*.gotmpl,!/render/*/templates/*.yaml set ft=helm
" workaround not to complete yaml files by yamlls
autocmd BufNewFile,BufReadPost,BufRead *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile.yaml,values.yaml set ft=helm
autocmd BufRead,BufReadPost,BufNewFile *.{yaml,yml} :LspRestart
autocmd BufNewFile,BufReadPost,BufRead *.{tf} set filetype=terraform foldmethod=indent
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()
