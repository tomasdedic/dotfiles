local function tmux_nav(cmd, win)
  local next_win = vim.api.nvim_win_call(win, function()
    vim.cmd(cmd)
    return vim.api.nvim_get_current_win()
  end)
  vim.api.nvim_set_current_win(next_win)
end

local function make_tmux_action(cmd)
  return function(picker) ---@param picker snacks.Picker
    tmux_nav(cmd, assert(picker.layout.root.win))
  end
end

-- reuse LazyVim's key names (lazyvim/plugins/util.lua) so these override instead of duplicating
local function term_key(lhs, cmd)
  return {
    lhs,
    function(self)
      tmux_nav(cmd, self.win)
    end,
    mode = { "n", "t" },
    expr = false, -- LazyVim sets expr=true; deep merge keeps it unless overridden -> E565
  }
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      -- customize for code.siemens.com
      explorer = {},
      image = { enabled = true },
      -- zoom (<leader>wm, Ctrl-x) and zen open a float. lualine skips floats when it refreshes, so the
      -- float keeps a frozen copy of the winbar. Make it an expression, evaluated on every redraw.
      zen = {
        on_open = function(win)
          vim.wo[win.win].winbar = "%{%v:lua.require'lualine'.winbar()%}"
        end,
      },
      gitbrowse = {
        url_patterns = {
          ["code%.siemens%.com"] = {
            branch = "/-/tree/{branch}",
            file = "/-/blob/{branch}/{file}#L{line_start}-{line_end}",
            permalink = "/-/blob/{commit}/{file}#L{line_start}-{line_end}",
            commit = "/-/commit/{commit}",
          },
        },
      },
      terminal = {
        win = {
          wo = {
            winhighlight = "Normal:SnacksTerminalNormal,Visual:SnacksTerminalVisual,CursorLine:SnacksTerminalCursorLine",
            cursorline = true, -- snacks windows are "minimal" (cursorline off) by default
          },
          keys = {
            nav_h = term_key("<C-h>", "NvimTmuxNavigateLeft"),
            nav_j = term_key("<C-j>", "NvimTmuxNavigateDown"),
            nav_k = term_key("<C-k>", "NvimTmuxNavigateUp"),
            nav_l = term_key("<C-l>", "NvimTmuxNavigateRight"),
            -- Ctrl-n leaves terminal mode without sending Esc (pi cancels a request on Esc)
            normal_mode = { "<C-n>", function() vim.cmd("stopinsert") end, mode = "t", desc = "Terminal: normal mode" },
            -- ,p in terminal Normal mode: the global yank history pastes into the editor window,
            -- so send the chosen entry to the shell instead, as a bracketed paste (not executed)
            yank_history = {
              "<leader>p",
              function(self)
                local job = vim.b[self.buf].terminal_job_id
                Snacks.picker.yanky({
                  confirm = function(picker, item)
                    picker:close()
                    if item then
                      local text = item.regcontents:gsub("\n$", "")
                      vim.fn.chansend(job, "\27[200~" .. text .. "\27[201~")
                    end
                    vim.schedule(function() -- the picker returns focus to the editor window
                      if self:win_valid() then
                        vim.api.nvim_set_current_win(self.win)
                      end
                    end)
                  end,
                })
              end,
              mode = "n",
              desc = "Yank history: paste into terminal",
            },
          },
        },
      },
      picker = {
        actions = {
          tmux_h = make_tmux_action("NvimTmuxNavigateLeft"),
          tmux_j = make_tmux_action("NvimTmuxNavigateDown"),
          tmux_k = make_tmux_action("NvimTmuxNavigateUp"),
          tmux_l = make_tmux_action("NvimTmuxNavigateRight"),
        },
        win = {
          input = {
            keys = {
              ["<c-h>"] = { "tmux_h", mode = { "i", "n" } },
              ["<c-j>"] = { "tmux_j", mode = { "i", "n" } },
              ["<c-k>"] = { "tmux_k", mode = { "i", "n" } },
              ["<c-l>"] = { "tmux_l", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<c-h>"] = "tmux_h",
              ["<c-j>"] = "tmux_j",
              ["<c-k>"] = "tmux_k",
              ["<c-l>"] = "tmux_l",
            },
          },
        },
        sources = {
          fsbookmark = {
            config = function(opts)
              return require("fsbookmark.picker").source(opts)
            end,
          },
          explorer = {
            format = function(item, picker)
              local out = require("fsbookmark.explorer").format(item, picker)
              -- the plugin marks every bookmark with icons.bookmark; show the scope instead,
              -- so a global bookmark reads @ and a shared one +
              local bookmark = item.file and require("fsbookmark").get(item.file)
              local icons = require("fsbookmark.config").options.icons
              if bookmark and icons[bookmark.scope] then
                out[1][1] = icons[bookmark.scope] .. " "
              end
              return out
            end,
            -- B: show only bookmarks and the directories that lead to them. The explorer filters
            -- with globs, and `include` wins over `exclude`, so excluding everything and including
            -- each bookmark plus its parent dirs leaves exactly that subtree visible.
            actions = {
              bookmarks_only = function(picker)
                local opts = picker.opts
                if opts.bookmarks_only then
                  opts.include, opts.exclude, opts.bookmarks_only = opts.include_saved, opts.exclude_saved, nil
                  picker:set_cwd(opts.cwd_saved)
                else
                  -- deepest directory holding every bookmark, so the tree is rooted above all of
                  -- them instead of the cwd, which may contain none
                  local function common_dir(a, b)
                    if not a then
                      return b
                    end
                    local pa, pb, out = vim.split(a, "/"), vim.split(b, "/"), {}
                    for i = 1, math.min(#pa, #pb) do
                      if pa[i] ~= pb[i] then
                        break
                      end
                      out[i] = pa[i]
                    end
                    return table.concat(out, "/")
                  end

                  local Tree = require("snacks.explorer.tree")
                  local include, root = {}, nil
                  for _, bookmark in ipairs(require("fsbookmark").list()) do
                    local path = bookmark.path
                    if path:sub(1, 1) == "/" then -- skip non-file bookmarks, e.g. term:
                      include[#include + 1] = path
                      if vim.fn.isdirectory(path) == 1 then
                        Tree:open(vim.fs.dirname(path)) -- show it, but keep it folded
                      else
                        Tree:open(path) -- expand the chain, so the bookmarked file is on screen
                      end
                      local dir = vim.fs.dirname(path)
                      root = common_dir(root, dir)
                      while dir and dir ~= "/" and dir ~= "." do
                        include[#include + 1] = dir
                        dir = vim.fs.dirname(dir)
                      end
                    end
                  end
                  opts.include_saved, opts.exclude_saved, opts.cwd_saved = opts.include, opts.exclude, picker:cwd()
                  opts.include, opts.exclude, opts.bookmarks_only = include, { "**/*" }, true
                  picker:set_cwd((root or "") ~= "" and root or "/")
                end
                picker:find()
              end,
              -- b: step a path through every bookmark scope and back to no bookmark
              bookmark_cycle = function(picker, item)
                local path = item and item.file
                if not path then
                  return
                end
                local fb = require("fsbookmark")
                local bookmark = fb.get(path)
                local scope = bookmark and bookmark.scope
                local state
                if not bookmark then
                  local added = fb.add(path)
                  state = added and added.scope or "added"
                elseif scope == "workspace" then
                  fb.make_global(path)
                  state = "global"
                elseif scope == "global" then
                  local shared, err = fb.share(path)
                  if shared then
                    state = "shared"
                  else -- no workspace to share into: close the cycle here
                    fb.remove(path)
                    state = err and "removed (" .. err .. ")" or "removed"
                  end
                else
                  fb.remove(path)
                  state = "removed"
                end
                local icons = require("fsbookmark.config").options.icons
                vim.notify((icons[state] or "") .. " " .. state .. " " .. vim.fn.fnamemodify(path, ":t"))
                require("fsbookmark.explorer").refresh(path)
              end,
              -- <CR> on a directory while filtered: leave the filter and browse that directory
              -- (the source's own `confirm` wins over one defined here, so this has its own name)
              bookmarks_confirm = function(picker, item, action)
                if picker.opts.bookmarks_only and item and item.dir then
                  local dir = item.file
                  picker.opts.actions.bookmarks_only(picker)
                  picker:set_cwd(dir)
                  return picker:find()
                end
                return require("snacks.explorer.actions").actions.confirm(picker, item, action)
              end,
            },
            -- layout = "bottom",
            -- float in the top-left corner instead of a split, so the bottom terminals keep their size
            -- row/col: number >= 1 = cell, 0..1 = fraction, negative = from bottom/right, unset = center
            layout = {
              preset = "sidebar",
              layout = {
                position = "float",
                width = 60,
                min_width = 60,
                height = 0.5, -- half the screen height
                row = 1,
                col = 1,
                border = "rounded",
              },
            },
            jump = { close = true },
            win = {
              -- unmap tmux keys
              list = {
                keys = {
                  ["<C-h>"] = false,
                  ["<C-j>"] = false,
                  ["<C-k>"] = false,
                  ["<C-l>"] = false,
                  ["B"] = { "bookmarks_only", desc = "Only bookmarked paths" },
                  ["b"] = { "bookmark_cycle", desc = "Cycle bookmark scope" },
                  ["<CR>"] = "bookmarks_confirm",
                },
              },
            },
          },
        },
      },

      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[

   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
   ▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒
   ▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒
   ▒▒▒░░░░░░▒▒▒▒░░░░░░░░░░▒▒▒▒░░░░░░▒▒▒
   ▒▒▒░░░░░▒▒░░░░░░░░░░░░░░░░▒▒░░░░░▒▒▒
   ▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒
   ▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒
   ▒▒▒▒░░░░░███░░░░░░░░░░░░███░░░░░▒▒▒▒
   ▒▒▒▒░░░░██ ██░░░░░░░░░░██ ██░░░░▒▒▒▒
   ▒▒▒▒░░░░░███░░░░░░░░░░░░███░░░░░▒▒▒▒
   ▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒
   ▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒
   ▒▒▒▒░░░░░░░░░▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▒▒▒▒
   ▒▒▒▒░░░░░░░░▓▓██▓▓▓▓██▓▓░░░░░░░░▒▒▒▒
   ▒▒▒▒▒░░░░░░▓▓▓██▓▓▓▓██▓▓▓░░░░░░▒▒▒▒▒
   ▒▒▒▒▒▒░░░░░░▓▓██▓▓▓▓██▓▓░░░░░░▒▒▒▒▒▒
   ▒▒▒▒▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓░░░░░░▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
]],
          keys = {},
        },
      },
    },
  },
}
