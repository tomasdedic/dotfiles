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
  vim.api.nvim_set_hl(0, "SnacksTerminalCursorLine", { bg = "#dce0e8" }) -- latte crust
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
        .. "Normal:SnacksTerminalNormal,Visual:SnacksTerminalVisual,CursorLine:SnacksTerminalCursorLine"
    end
  end,
})

-- winhighlight is window-local, so the light terminal colors stay on a window after it switches to
-- a normal buffer (:e in the only window, or a split that copies the terminal window's options).
-- Keep them in sync with the buffer the window shows; other winhighlight entries are left alone.
local TERM_HL = {
  "Normal:SnacksTerminalNormal",
  "NormalFloat:SnacksTerminalNormal",
  "Visual:SnacksTerminalVisual",
  "CursorLine:SnacksTerminalCursorLine",
}
-- Checked for every window of the tab page, one tick later: a file can be opened into the terminal
-- window from another window (a picker), and snacks then moves it out with :sbuffer into a new
-- window that copies the terminal window's options, so the current window is not always the one.
local function sync_term_hl()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local whl = vim.wo[win].winhighlight
    local parts = vim.tbl_filter(function(p)
      return p ~= "" and not vim.tbl_contains(TERM_HL, p)
    end, vim.split(whl, ","))
    if vim.bo[buf].buftype == "terminal" then
      vim.list_extend(parts, TERM_HL)
    end
    local new = table.concat(parts, ",")
    if new ~= whl then
      vim.wo[win].winhighlight = new
    end
  end
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "WinNew" }, {
  callback = function()
    vim.schedule(sync_term_hl)
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

-- Remember the last command run in each terminal (for the ,tt picker). oh-my-zsh sets the title
-- to the command line before it runs (OSC 2 "cmd", then OSC 1 "first word") and back to
-- "user@host:dir" at the prompt, so b:term_title loses it. Take an OSC 2 that is followed by an
-- OSC 1 and is not the prompt title; a program's own title (pi) comes without OSC 1.
vim.api.nvim_create_autocmd("TermRequest", {
  callback = function(ev)
    local seq = ev.data.sequence or ""
    local title = seq:match("^\27%]2;(.*)")
    if title then
      vim.b[ev.buf].term_pending_cmd = title
    elseif seq:match("^\27%]1;") then
      local cmd = vim.b[ev.buf].term_pending_cmd
      if cmd and not cmd:find("^" .. vim.pesc(vim.env.USER or "") .. "@") then
        vim.b[ev.buf].term_last_cmd = cmd
      end
      vim.b[ev.buf].term_pending_cmd = nil
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
    else
      -- hiding the terminal (<C-/>) closes its window, and showing it opens a new one with a fresh
      -- view, so remember where you were reading
      local view = vim.fn.winsaveview()
      vim.b.term_view = view
      vim.b.term_view_last = vim.api.nvim_buf_line_count(0)
      vim.b.term_at_bottom = view.topline + vim.api.nvim_win_get_height(0) - 1 >= vim.b.term_view_last
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
    local want_normal, view, at_bottom
    local last = vim.api.nvim_buf_line_count(ev.buf)
    local view_last = last -- buffer length when `view` was taken
    -- the end of the buffer was on screen (a TUI such as pi keeps its cursor well above it),
    -- so the window was showing the live output, not scrollback
    local function bottom(v, w)
      return v.topline + vim.api.nvim_win_get_height(w) - 1 >= last
    end
    if zoom and vim.api.nvim_win_get_config(win).relative ~= "" then
      -- zoom in: take the view of the window below, and keep it for the way back
      want_normal = vim.fn.mode() ~= "t"
      view = vim.api.nvim_win_call(prev, vim.fn.winsaveview)
      at_bottom = bottom(view, prev)
      vim.w[prev].term_zoom_view = view
    elseif zoom then
      -- zoom out (prev is the float): its view does not fit the smaller window. If you did not move
      -- in the zoom, go back to the view from before the zoom; else keep the line, centered.
      want_normal = vim.fn.mode() ~= "t"
      local zoomed = vim.api.nvim_win_call(prev, vim.fn.winsaveview)
      local before = vim.w[win].term_zoom_view
      vim.w[win].term_zoom_view = nil
      if before and before.lnum == zoomed.lnum then
        view = before
        at_bottom = bottom(before, win)
      else
        view = { lnum = zoomed.lnum, col = zoomed.col, topline = math.max(1, zoomed.lnum - math.floor(vim.api.nvim_win_get_height(win) / 2)) }
        at_bottom = bottom(zoomed, prev)
      end
    else
      want_normal = vim.b[ev.buf].term_left_normal == true
      view = vim.b[ev.buf].term_view or vim.fn.winsaveview()
      at_bottom = vim.b[ev.buf].term_at_bottom == true
      view_last = vim.b[ev.buf].term_view_last or last
    end

    vim.schedule(function()
      -- A new split first shows the current buffer and gets its own buffer after WinEnter (this is
      -- how a second terminal opens). That is not a return to this terminal: leave it alone.
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= ev.buf then
        return
      end
      vim.wo[win].winhighlight =
        "Normal:SnacksTerminalNormal,NormalFloat:SnacksTerminalNormal,Visual:SnacksTerminalVisual,CursorLine:SnacksTerminalCursorLine"
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
          local target = view
          if at_bottom then
            -- keep the end of the output at the bottom of the window (it may have grown), and the
            -- cursor the same number of lines above the end as before, not on the last line
            local now_last = vim.api.nvim_buf_line_count(ev.buf)
            local height = vim.api.nvim_win_get_height(win)
            local lnum = math.max(1, now_last - (view_last - view.lnum))
            target = { lnum = lnum, col = view.col, topline = math.max(1, math.min(now_last - height + 1, lnum)) }
          end
          local now = vim.fn.winsaveview()
          if now.lnum ~= target.lnum or now.topline ~= target.topline then
            vim.fn.winrestview(target)
          end
        end)
      end
      -- Nvim scrolls the window again when the resized terminal is redrawn, and that can come late
      -- (a busy TUI such as pi repaints only after it gets the resize). So hold the view for one
      -- second, and stop at the first key you press, so this never fights your own movement.
      local timer = assert(vim.uv.new_timer())
      local ns ---@type integer?
      local function stop()
        if not timer:is_closing() then
          timer:stop()
          timer:close()
        end
        if ns then
          vim.on_key(nil, ns)
          ns = nil
        end
      end
      ns = vim.on_key(function()
        vim.schedule(stop)
      end)
      local ticks = 0
      timer:start(
        0,
        50,
        vim.schedule_wrap(function()
          ticks = ticks + 1
          if ticks > 20 or timer:is_closing() or not vim.api.nvim_win_is_valid(win) then
            return stop()
          end
          apply()
        end)
      )
    end)
  end,
})

-- Session restore (,qs / ,ql / ,qS) loads the saved buffers but keeps the ones already open. Sessions
-- never save terminals, so terminals open before the restore were left over from the old session.
-- Wipe them first. This ends the programs running in them.
vim.api.nvim_create_autocmd("User", {
  pattern = "PersistenceLoadPre",
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].buftype == "terminal" then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end
  end,
})
