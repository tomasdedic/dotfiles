vim.loader.enable()
vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,winsize,winpos,terminal,localoptions" --not use tabpages
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
vim.opt.clipboard = "unnamedplus"
vim.opt.shell = "zsh"

vim.opt.mouse = "a"
-- set shada (print shada file contents)

vim.opt.background = "dark"
vim.opt.ts = 2
vim.opt.sw = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"

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

vim.g.undodir = vim.fn.stdpath("data") .. "/undodir"
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

vim.cmd([[
  augroup annoying
    au!
    au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines
  augroup end
]])

if vim.fn.has("termguicolors") then
	vim.opt.termguicolors = true
end

-- Custom autocmds
vim.cmd([[
autocmd FileType terraform setlocal commentstring=#%s foldmethod=manual
autocmd FileType hcl setlocal commentstring=#%s
]])

--schemeswitcher
vim.cmd([[
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
]])

-- folding
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 2
vim.opt.foldnestmax = 4
vim.opt.foldtext = ""
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Protip: zi toggles folding
vim.cmd([[
  function! Fold()
    set foldenable
    " normal zM
  endfunction

  function! Unfold()
    " normal zR
    set nofoldenable
  endfunction
]])

-- load mappings
vim.cmd([[
  source $HOME/.config/nvim/mappings.vim
]])

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

-- mappings
vim.keymap.set("n", "<leader>cab", ":call v:lua.delete_hidden_buffers()<CR>")
vim.keymap.set("n", "<leader>cab!", ":call v:lua.delete_hidden_buffers(1)<CR>")
local map = vim.keymap.set
-- better up/down
-- If there is no count (v:count == 0), pressing j will execute gj
-- Useful when dealing with wrapped lines in the buffer.
-- If there is a count (v:count != 0), pressing j will execute j.
-- For example, if you press 3j to move down three lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Other Buffer" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ANSIBLE/YAML --------------------------------------------------------------
-- vim.filetype.add({
-- 	extension = {
-- 		yml = "yaml.ansible",
-- 	},
-- })
vim.filetype.add({
	pattern = {
		[".*/%.github[%w/]+workflows[%w/]+.*%.ya?ml"] = "yaml.gh",
	},
})
require("autocmd")
require("plugins")
