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

local function set_terminal_light_bg()
  vim.api.nvim_set_hl(0, "SnacksTerminalNormal", { bg = "#eff1f5", fg = "#4c4f69" })
end

set_terminal_light_bg()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_terminal_light_bg,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    local win = vim.api.nvim_get_current_win()
    local whl = vim.wo[win].winhighlight
    if not whl:find("SnacksTerminalNormal") then
      vim.wo[win].winhighlight = (whl ~= "" and whl .. "," or "") .. "Normal:SnacksTerminalNormal"
    end
  end,
})

-- zsh vi-mode colors the cursor with OSC 12. Nvim's terminal does not apply it itself, so map it to
-- TermCursor, the highlight 'guicursor' uses in terminal mode. "default" restores the colorscheme value.
local term_cursor_default
vim.api.nvim_create_autocmd("TermRequest", {
  callback = function(ev)
    local seq = ev.data.sequence
    local color = seq:match("^\27%]12;(.+)")
    if not color then
      return
    end
    term_cursor_default = term_cursor_default or vim.api.nvim_get_hl(0, { name = "TermCursor" })
    if color == "default" then -- sent by ~/.zshrc instead of OSC 112, which Nvim drops
      vim.api.nvim_set_hl(0, "TermCursor", term_cursor_default)
    else
      vim.api.nvim_set_hl(0, "TermCursor", { bg = color, fg = "#ffffff" })
    end
  end,
})

-- A terminal window only follows new output when its cursor is on the last buffer line. The terminal
-- cursor is usually higher (blank rows below the prompt), so leaving from terminal mode froze the view.
-- Leaving from terminal mode now parks the cursor on the last line; leaving from terminal Normal
-- mode keeps your position, so you can read scrollback in another window.
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.buftype == "terminal" and vim.fn.mode() == "t" then
      vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
    end
  end,
})
