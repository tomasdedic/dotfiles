-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", {})
vim.keymap.set("n", "<Leader>yy", "^yg_", { noremap = true }) --copy line without begining whitespacel

-- Copy visual block selection removing as much whitespace as first line has
vim.keymap.set("x", "<Leader>yy", function()
  -- First, yank the visual selection normally
  vim.cmd('normal! "' .. vim.v.register .. "y")

  -- Now get what was just yanked as a string and split it
  local yanked_str = vim.fn.getreg(vim.v.register)
  local lines = vim.split(yanked_str, "\n", { plain = true })

  -- Only process if we have lines
  if #lines > 0 and lines[1] then
    -- Count leading whitespace in first line
    local first_line_whitespace = lines[1]:match("^(%s*)") or ""
    local whitespace_count = #first_line_whitespace

    -- Remove that amount of whitespace from each line
    for i, line in ipairs(lines) do
      if type(line) == "string" and whitespace_count > 0 and #line >= whitespace_count then
        lines[i] = line:sub(whitespace_count + 1)
      end
    end

    -- Put the processed content back in the register as a string
    vim.fn.setreg(vim.v.register, table.concat(lines, "\n"))
  end
end, { noremap = true, desc = "Copy removing first line's leading whitespace" })
-- vim.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNext<CR>", {})
-- vim.keymap.set(
--   "n",
--   ";",
--   "<cmd>FzfLua buffers sort_mru=true previewer=false sort_lastused=true<cr>",
--   { desc = "Bufers noPreview" }
-- )
vim.keymap.set("n", ";", function()
  Snacks.picker.buffers({ current = false, sort_lastused = true })
end, { desc = "Bufers" })
vim.keymap.set("n", "<leader>,", function()
  Snacks.picker.buffers({ current = false, sort_lastused = true })
end, { desc = "Bufers" })

vim.keymap.set("n", "-", function()
  Snacks.explorer({ cwd = LazyVim.root() })
end, {})
-- vim.keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<CR>", {})
--
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.api.nvim_create_user_command("Dir", function()
  -- vim.fn.setreg("+", vim.fn.expand("%:h:"))
  vim.fn.setreg("+", vim.fn.substitute(vim.fn.getcwd(), vim.env.HOME, "~", ""))
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

vim.keymap.set(
  "n",
  "<leader>tl",
  "<cmd>!tmux send-keys -t right Up Enter<CR><CR>",
  { desc = "tmux right last command" }
)
vim.keymap.set(
  "n",
  "<leader>tj",
  "<cmd>!tmux send-keys -t bottom Up Enter<CR><CR>",
  { desc = "tmux down last command" }
)
-- " nmap \r :!tmux send-keys -t bottom-left Up Enter <CR><CR>
-- " nmap \rr :!tmux send-keys -t top-left Up Enter <CR><CR>
-- nmap \r :!tmux send-keys -t bottom Up Enter <CR><CR>
