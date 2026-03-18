-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

local function remove_link_underlines()
  vim.api.nvim_set_hl(0, "@markup.link", { underline = false })
  vim.api.nvim_set_hl(0, "@markup.link.url", { italic = true, underline = false, fg = "#9cb7e8" })
  vim.api.nvim_set_hl(0, "@markup.link.label", { underline = false, fg = "#8caaee" })
  vim.api.nvim_set_hl(0, "@string.special.url", { italic = true, underline = false, fg = "#9cb7e8" })
  vim.api.nvim_set_hl(0, "markdownLinkText", { underline = false, fg = "#8caaee" })
  vim.api.nvim_set_hl(0, "markdownUrl", { underline = false, fg = "#9cb7e8" })
end

-- Apply now (colorscheme already loaded by the time VeryLazy fires)
remove_link_underlines()

-- Re-apply if colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = remove_link_underlines,
})
