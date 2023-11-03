require("toggleterm").setup {
  open_mapping = [[<C-\>]],
  autochdir = true,
  direction = 'horizontal',
  float_opts = {
    border = 'single',
    width = 100,
  },
  hide_numbers = true,
  shade_terminals = false,
  highlights = {
    -- highlights which map to a highlight group name and a table of it's values
    -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
    Normal = {
      guibg = "White",
    },
  },
  winbar = {
    enabled = true,
    name_formater= "term"
  },
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return 80
    end
  end,
  start_in_insert = false,
  insert_mappings = true,
}

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

if vim.g.neovide then
  vim.keymap.set("n", "<D-d>", "<cmd>ToggleTerm<CR>", { noremap = true })
  vim.keymap.set("i", "<D-d>", "<C-\\><C-n><cmd>ToggleTerm<CR>", { noremap = true })
  vim.keymap.set("t", "<D-d>", "<C-\\><C-n><cmd>ToggleTerm<CR>", { noremap = true })
end
