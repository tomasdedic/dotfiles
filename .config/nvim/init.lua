vim.loader.enable()
vim.g.mapleader = ","
vim.g.maplocalleader = " "

vim.opt.showmode = true
vim.opt.scrolloff = 3
vim.opt.expandtab = true
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.encoding = "UTF-8"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.foldcolumn = "1"
-- vim.opt.clipboard = "unnamedplus"

vim.opt.mouse = "a"
-- set shada (print shada file contents)

if vim.g.started_by_firenvim then
  vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h14"
end

vim.opt.background = "dark"
vim.opt.ts = 2
vim.opt.sw = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.sessionoptions = { "blank", "buffers", "curdir", "help", "tabpages", "winsize", "winpos" }

-- " performance tweaks
vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.scrolljump = 5
-- set lazyredraw
-- set ttyfast
vim.opt.redrawtime = 3000
-- set synmaxcol=180
-- set re=1

vim.opt.hidden = true

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Give more space for displaying messages.
vim.opt.cmdheight = 3

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Don't pass messages to |ins-completion-menu|.
-- Show search match counter
vim.opt.shortmess = "filnxtToOFc"

vim.opt.emoji = false
vim.opt.undofile = true

vim.g.undodir = vim.fn.stdpath "data" .. "/undodir"
-- let &undodir = expand(stdpath('data')."/undodir")
vim.opt.grepprg = "rg"
--to get rid of display of last command
vim.opt.showcmd = true

-- Store global vars in sessions
-- set sessionoptions+=globals
-- set viminfo+=!

-- Plugin configs
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.cmd [[
  augroup annoying
    au!
    au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines
  augroup end
]]

if vim.fn.has "termguicolors" then
  vim.opt.termguicolors = true
end

-- Custom autocmds
vim.cmd [[
autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile.yaml,values.yaml set ft=helm
autocmd FileType terraform setlocal commentstring=#%s foldmethod=manual
autocmd FileType hcl setlocal commentstring=#%s
]]

vim.cmd [[
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END
]]

vim.cmd [[
augroup goyocmds
  autocmd!
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!

augroup end
]]

vim.cmd [[
augroup AutoAdjustResize
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup end
]]
--schemeswitcher

vim.cmd [[
function! s:SwitchColorscheme()
  if exists('g:colors_name')
    "if g:colors_name == 'PaperColor'
    if &background == 'light'
      set background=dark
      colorscheme catppuccin-frappe
    "elseif g:colors_name == 'gruvbox'
    elseif &background == 'dark'
      set background=light
      colorscheme catppuccin-latte
    endif
  endif
endfunction
function! s:SetColorscheme()
   colorscheme catppuccin-macchiato
endfunction
map <silent> <F6> :call <SID>SwitchColorscheme()<CR>
map <silent> <F7> :call <SID>SetColorscheme()<CR>
]]
-- Presentation Mode
vim.g.in_presentation_mode = 0

vim.cmd [[
function! TogglePresentationMode()
  if g:in_presentation_mode
    let g:in_presentation_mode = 0
    set guifont=FiraCode\ Nerd\ Font:h12
    Goyo!
  else
    let g:in_presentation_mode = 1
    set guifont=FiraCode\ Nerd\ Font:h30
    " Default Goyo options, just need to use them since I don't want the toggling behaviour to trigger at all.
    Goyo 80x85%
  endif
endfunction
]]

vim.cmd [[command! TogglePresentationMode :call TogglePresentationMode()<CR>]]

vim.cmd [[
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup end
]]

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Protip: zi toggles folding
vim.cmd [[
  function! Fold()
    set foldenable
    " normal zM
  endfunction

  function! Unfold()
    " normal zR
    set nofoldenable
  endfunction
]]


-- load mappings
vim.cmd [[
  source $HOME/.config/nvim/mappings.vim
]]

-- -- TODO: this mappingg isn't working, conflicts with global toggleterm mapping, fix it
-- vim.keymap.set('t', [[<C-_>]], [[<C-\><C-n>]], { noremap = true })

function _G.delete_hidden_buffers(force)
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if vim.fn.buflisted(buffer) and vim.fn.bufwinnr(buffer) == -1 then
      if not force then
        vim.api.nvim_command("bwipeout " .. buffer)
      else
        vim.api.nvim_command("bwipeout! " .. buffer)
      end
    end
  end
end

vim.keymap.set("n", "<leader>cab", ":call v:lua.delete_hidden_buffers()<CR>")
vim.keymap.set("n", "<leader>cab!", ":call v:lua.delete_hidden_buffers(1)<CR>")

-- TODO: remove me?
vim.opt.syntax = "off"

-- require "packer_compiled"
require "plugins"
