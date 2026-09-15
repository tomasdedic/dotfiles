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
            winhighlight = "Normal:SnacksTerminalNormal",
          },
          keys = {
            nav_h = term_key("<C-h>", "NvimTmuxNavigateLeft"),
            nav_j = term_key("<C-j>", "NvimTmuxNavigateDown"),
            nav_k = term_key("<C-k>", "NvimTmuxNavigateUp"),
            nav_l = term_key("<C-l>", "NvimTmuxNavigateRight"),
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
          explorer = {
            -- layout = "bottom",
            jump = { close = true },
            win = {
              -- unmap tmux keys
              list = {
                keys = {
                  ["<C-h>"] = false,
                  ["<C-j>"] = false,
                  ["<C-k>"] = false,
                  ["<C-l>"] = false,
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
