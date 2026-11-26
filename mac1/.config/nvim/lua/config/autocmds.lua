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
  -- the colorscheme Visual is made for a dark background; use catppuccin latte's on the light one
  vim.api.nvim_set_hl(0, "SnacksTerminalVisual", { bg = "#bcc0cc" })
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
      vim.wo[win].winhighlight = (whl ~= "" and whl .. "," or "")
        .. "Normal:SnacksTerminalNormal,Visual:SnacksTerminalVisual"
    end
  end,
})

-- Name snacks terminals term://1, term://2, ... after their count (1<C-/>, 2<C-/>) instead of
-- term://<cwd>//<pid>:<shell>. The "://" is needed: Nvim prepends the cwd to any other name, as if
-- it were a file. Names must be unique, so a count already in use (same count, another directory)
-- gets the buffer number appended.
local function buf_by_name(name)
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(b) == name then
      return b
    end
  end
end

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(ev)
    local term = vim.b[ev.buf].snacks_terminal
    if not term then
      return
    end
    local old = vim.api.nvim_buf_get_name(ev.buf)
    local name = "term://" .. (term.id or 1)
    local taken = buf_by_name(name)
    if taken and taken ~= ev.buf then
      name = name .. "-" .. ev.buf
    end
    if not pcall(vim.api.nvim_buf_set_name, ev.buf, name) then
      return
    end
    -- renaming keeps the old name in a new, empty, unlisted buffer; drop it
    local stale = buf_by_name(old)
    if stale and stale ~= ev.buf then
      pcall(vim.api.nvim_buf_delete, stale, { force = true })
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
-- The mode is also remembered, so coming back restores it (see WinEnter below).
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      return
    end
    local terminal_mode = vim.fn.mode() == "t"
    vim.b.term_left_normal = not terminal_mode
    if terminal_mode then
      vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
    end
  end,
})

-- Snacks terminal windows:
-- 1. winhighlight is window-local, so zoom (<leader>wm) shows the buffer in a new float with snacks'
--    own colors. Re-apply the light background there.
-- 2. snacks' auto_insert always enters terminal mode on BufEnter, which also jumps the view to the
--    job cursor at the end of the buffer. If you left the terminal in Normal mode (or zoom from
--    Normal mode), go back to Normal mode and to the place you were reading.
-- Scheduled because snacks.win sets its own window options after the window is entered.
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function(ev)
    if not vim.b[ev.buf].snacks_terminal then
      return
    end
    local win = vim.api.nvim_get_current_win()

    -- Zoom opens a float on the same buffer, and WinLeave does not fire for it, so the mode and the
    -- view come from the window we came from. Any other entry uses the mode stored by WinLeave.
    local prev = vim.fn.win_getid(vim.fn.winnr("#"))
    local zoom = prev ~= 0
      and prev ~= win
      and vim.api.nvim_win_is_valid(prev)
      and vim.api.nvim_win_get_buf(prev) == ev.buf
    local want_normal
    if zoom then
      want_normal = vim.fn.mode() ~= "t"
    else
      want_normal = vim.b[ev.buf].term_left_normal == true
    end
    local from = zoom and prev or win
    local view = vim.api.nvim_win_call(from, vim.fn.winsaveview)
    -- the end of the buffer was on screen (a TUI such as pi keeps its cursor well above it),
    -- so the window was showing the live output, not scrollback
    local at_bottom = view.topline + vim.api.nvim_win_get_height(from) - 1 >= vim.api.nvim_buf_line_count(ev.buf)

    vim.schedule(function()
      -- A new split first shows the current buffer and gets its own buffer after WinEnter (this is
      -- how a second terminal opens). That is not a return to this terminal: leave it alone.
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= ev.buf then
        return
      end
      vim.wo[win].winhighlight =
        "Normal:SnacksTerminalNormal,NormalFloat:SnacksTerminalNormal,Visual:SnacksTerminalVisual"
      if not want_normal or vim.api.nvim_get_current_win() ~= win then
        return
      end
      vim.cmd("stopinsert")
      -- stopinsert takes effect on the next loop pass and moves the cursor to the job cursor, so the
      -- view is restored after it. `normal!` is not allowed in terminal mode, so use winrestview.
      local function apply()
        if not vim.api.nvim_win_is_valid(win) then
          return
        end
        vim.api.nvim_win_call(win, function()
          if at_bottom then
            local last = vim.api.nvim_buf_line_count(ev.buf)
            local height = vim.api.nvim_win_get_height(win)
            vim.fn.winrestview({ lnum = last, col = 0, topline = math.max(1, last - height + 1) })
          else
            vim.fn.winrestview(view)
          end
        end)
      end
      vim.schedule(apply)
      -- Nvim scrolls the window itself about 100ms after a terminal is resized (zoom), so apply again
      vim.defer_fn(apply, 200)
    end)
  end,
})
