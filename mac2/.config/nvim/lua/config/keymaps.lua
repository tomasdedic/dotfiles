-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", {})

-- send a command to the snacks terminal (same one as <c-/>)
local function term_send(cmd)
  local term = Snacks.terminal.get(nil, { cwd = LazyVim.root() })
  vim.fn.chansend(vim.b[term.buf].terminal_job_id, cmd .. "\r")
end

vim.keymap.set("n", "<leader>tc", function()
  term_send("cd " .. vim.fn.fnameescape(vim.fn.expand("%:p:h")))
end, { desc = "Terminal: cd to file dir" })

vim.keymap.set("x", "<leader>tp", function()
  vim.cmd('normal! "zy')
  local term = Snacks.terminal.get(nil, { cwd = LazyVim.root() })
  vim.fn.chansend(vim.b[term.buf].terminal_job_id, vim.fn.getreg("z"))
end, { desc = "Terminal: paste selection (no Enter)" })

-- vim.keymap.set("n", "<Leader>yy", "^yg_", { noremap = true }) --copy line without begining whitespacel

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
vim.keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<CR>", {})
--
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

vim.api.nvim_create_user_command("Dir", function()
  -- vim.fn.setreg("+", vim.fn.expand("%:h:"))
  vim.fn.setreg("+", vim.fn.substitute(vim.fn.getcwd(), vim.env.HOME, "~", ""))
end, { nargs = 0 })

vim.api.nvim_create_user_command("File", function()
  vim.fn.setreg("+", vim.fn.expand("%:p:."))
end, { nargs = 0 })

vim.api.nvim_create_user_command("Path", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
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
vim.keymap.set("n", ",fl", function()
  LazyVim.pick("files", { cwd = vim.fn.expand("%:h") })()
end, { desc = "Pick files under current buffer" })
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

vim.keymap.set({ "n", "v" }, "<leader>gY", function()
  Snacks.gitbrowse({
    open = function(url)
      vim.fn.setreg("+", url)
      vim.notify("Copied: " .. url, vim.log.levels.INFO)
    end,
  })
end, { desc = "Copy git link" })

-- Run shell code in the same terminal <c-/> uses (Snacks keys a terminal by cmd + cwd, so nil cmd
-- and LazyVim.root() match it). That shell keeps running, so variables, cd, aliases and functions
-- persist between runs. Focus stays on the code; <C-/> or <C-w>j to type in the terminal.
local function zsh_send(code)
  local term = Snacks.terminal.get(nil, {
    cwd = LazyVim.root(),
    start_insert = false,
    win = { position = "bottom", size = 0.3, enter = false },
  })
  if vim.fn.bufwinid(term.buf) == -1 then
    term:show() -- the window was closed, but the shell in the buffer is still running
  end
  vim.fn.chansend(vim.b[term.buf].terminal_job_id, code:gsub("%s+$", "") .. "\r")
end

vim.keymap.set("x", "<leader>ts", function()
  -- marks '< '> are not set yet inside a visual-mode callback, so yank the selection
  vim.cmd('normal! "zy')
  zsh_send(vim.fn.getreg("z"))
end, { desc = "Shell: run selection" })

vim.keymap.set("n", "<leader>ts", function()
  local code = vim.fn.input("zsh: ")
  if code ~= "" then
    zsh_send(code)
  end
end, { desc = "Shell: run command" })

vim.keymap.set("n", "<leader>tl", function()
  zsh_send(vim.api.nvim_get_current_line())
end, { desc = "Shell: run line" })

-- Runs as one script (zsh <file>), so loops, heredocs and exit behave like a real run and the
-- terminal gets a single command. Unsaved changes are written to a temp file.
vim.keymap.set("n", "<leader>tb", function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" or vim.bo.modified then
    path = vim.fn.tempname() .. ".zsh"
    vim.fn.writefile(vim.api.nvim_buf_get_lines(0, 0, -1, false), path)
  end
  zsh_send("zsh " .. vim.fn.fnameescape(path))
end, { desc = "Shell: run buffer as script" })
