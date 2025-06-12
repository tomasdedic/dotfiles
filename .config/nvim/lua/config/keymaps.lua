-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", {})
vim.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNext<CR>", {})
vim.keymap.set(
  "n",
  ";",
  "<cmd>FzfLua buffers sort_mru=true previewer=false sort_lastused=true<cr>",
  { desc = "Bufers noPreview" }
)
vim.keymap.set("n", "-", function()
  Snacks.explorer({ cwd = LazyVim.root() })
end, {})
-- vim.keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<CR>", {})
--
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.api.nvim_create_user_command("Dir", function()
  vim.fn.setreg("+", vim.fn.expand("%:h:"))
end, { nargs = 0 })
vim.api.nvim_create_user_command("File", function()
  vim.fn.setreg("+", vim.fn.expand("%:p:."))
end, { nargs = 0 })

vim.api.nvim_create_user_command("Name", function()
  vim.fn.setreg("+", vim.fn.expand("%:t:r"))
end, { nargs = 0 })
-- <leader>fl
-- { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
vim.keymap.set(
  "n",
  "<leader>fl",
  LazyVim.pick("files", { cwd = vim.fn.expand("%:h:") }),
  { desc = "Pick files under current buffer" }
)
vim.keymap.set("n", "<leader>sB", function()
  Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })
