-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.g.mapleader = ","
vim.g.maplocalleader = " "
-- vim.opt.textwidth = 120
-- vim.filetype.add({
--   pattern = {
--     [".*/%.github[%w/]+workflows[%w/]+.*%.ya?ml"] = "yaml.gh",
--   },
-- })
vim.opt_local.spell = false

-- `cmd | nvim -` gives an unnamed buffer, so set yaml from content.
-- Lives here, not in autocmds.lua: that loads on VeryLazy, after stdin is read.
vim.api.nvim_create_autocmd("StdinReadPost", {
  callback = function(ev)
    if vim.bo[ev.buf].filetype ~= "" then
      return
    end
    local first = vim.api.nvim_buf_get_lines(ev.buf, 0, 1, false)[1] or ""
    if first:match("^%-%-%-") or first:match("^apiVersion:") or first:match("^[%w_.-]+:%s") or first:match("^[%w_.-]+:$") then
      -- Defer: LazyVim registers its treesitter FileType hook on VeryLazy; setting ft earlier
      -- gives regex syntax instead of treesitter highlighting.
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        once = true,
        callback = function()
          if vim.api.nvim_buf_is_valid(ev.buf) and vim.bo[ev.buf].filetype == "" then
            vim.bo[ev.buf].filetype = "yaml"
          end
        end,
      })
    end
  end,
})
