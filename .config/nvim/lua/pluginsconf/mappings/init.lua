require "pluginsconf.mappings.sg"

local function delete_hidden_buffers(options)
  local force = options and options.force or false
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

vim.keymap.set("n", "<leader>cab", delete_hidden_buffers)
vim.keymap.set("n", "<leader>cab!", function()
  delete_hidden_buffers { force = true }
end)

if vim.g.neovide then
  vim.keymap.set("n", "<D-p>", function()
    local success, _ = pcall(require("telescope.builtin").git_files)
    if not success then
      require("telescope.builtin").find_files()
      return
    end
  end
  , {})
end
