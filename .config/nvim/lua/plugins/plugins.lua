return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[
▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒
▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒
▒▒░▐▌░▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░▌▐░▒▒
▒▒░░▌░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▌░░▒▒
▒▒▒▒░░░░░░░░░░░░▓▓▓▒▒▒▒▒▒▓▓▓░░░░░░░░░░░░▒▒▒▒
▒▒▒▒▒▒░░▀▀███░░░░▓▒▒▒▓▓▒▒▒▓░░░░███▀▀░░▒▒▒▒▒▒
▒▒▒▒▒▒░▌▄████▌░░░▓▒▒▒▓▓▒▒▒▓░░░▌████▄▌░▒▒▒▒▒▒
▒▒▒▒▒░░███▄█▌░░░▓▓▒▓▓▓▓▓▓▒▓▓░░░▌█▄███░░▒▒▒▒▒
▒▒▒▒▒▒▒░▀▀▀▀░░░░▓▓▒▒▓▓▓▓▒▒▓▓░░░░▀▀▀▀░▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒░░░░░░░░░▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒░▀▀▀▀░░░░▓▓▒▒▓▓▓▓▒▒▓▓░░░░▀▀▀▀░▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒░░░░░░░░░▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒░░░░░░▐▄░▓▓▓▓▓▓▓▓▓▓▓▓░▄▐░░░░░░▒▒▒▒▒▒▒
▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒
▒▒▒▒░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒▒▒▒
▒▒▒▒░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒▒▒▒
▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒
▒▒▒▒▒▒▒░░░░░░▐▄░▓▓▓▓▓▓▓▓▓▓▓▓░▄▐░░░░░░▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒░░░░░░░░░▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒░▀▀▀▀░░░░▓▓▒▒▓▓▓▓▒▒▓▓░░░░▀▀▀▀░▒▒▒▒▒▒▒
▒▒▒▒▒░░███▄█▌░░░▓▓▒▓▓▓▓▓▓▒▓▓░░░▌█▄███░░▒▒▒▒▒
▒▒▒▒▒▒░▌▄████▌░░░▓▒▒▒▓▓▒▒▒▓░░░▌████▄▌░▒▒▒▒▒▒
▒▒▒▒▒▒░░▀▀███░░░░▓▒▒▒▓▓▒▒▒▓░░░░███▀▀░░▒▒▒▒▒▒
▒▒▒▒░░░░░░░░░░░░▓▓▓▒▒▒▒▒▒▓▓▓░░░░░░░░░░░░▒▒▒▒
▒▒░░▌░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▌░░▒▒
▒▒░▐▌░▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░▌▐░▒▒
▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒
▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒

]],
          keys = {},
        },
      },
    },
    -- keys = {
    --   {
    --     {
    --       "<leader>fl",
    --       LazyVim.pick("files", { cwd = vim.fn.expand("%:h:") }),
    --       desc = "Pick files under current buffer",
    --     },
    --   },
    -- },
  },

  -- disable linter for markdown
  {
    "mfussenegger/nvim-lint",
    enabled = false,
    -- optional = true,
    -- opts = {
    --   linters_by_ft = {
    --     markdown = {},
    --   },
    -- },
  },
  {
    "nvimtools/none-ls.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "frappe", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "frappe",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
  },
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {
      disable_when_zoomed = true,
    },
  },

  {
    "folke/noice.nvim",
    opts = {
      -- cmdline = { enabled = false },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
      views = {
        mini = {
          align = "message-left", -- Align messages to the left
          position = {
            col = 0, -- Align to the leftmost column
          },
          border = {
            style = "rounded",
          },
          win_options = {
            winblend = 5,
          },
        },
      },
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        file_name = function()
          local base = vim.fn.expand("%:t:r")
          local suffix = vim.fn.input("IN: " .. base .. "-")
          if suffix ~= "" then
            return base .. "-" .. suffix
          end
          return base
        end,
        prompt_for_file_name = false,
      },
    },
    keys = {
      { "<localleader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       gh_actions_ls = {
  --         filetypes = { "yaml.gh" },
  --       },
  --     },
  --   },
  -- },
  {
    "https://tangled.org/cuducos.me/yaml.nvim",
    ft = { "yaml", "helm", "yaml.gh" }, -- optional
  },
  -- {
  --   "mason-org/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "gh-actions-language-server",
  --     },
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    -- opts = function(_, opts)
    --   opts.textobjects.move.goto_next_start["]c"] = nil
    --   opts.textobjects.move.goto_next_start["]l"] = "@class.outer"
    --   opts.textobjects.move.goto_previous_start["[c"] = nil
    --   opts.textobjects.move.goto_previous_start["[l"] = "@class.outer"
    --
    --   opts.textobjects.move.goto_next_end["]C"] = nil
    --   opts.textobjects.move.goto_next_end["]L"] = "@class.outer"
    --   opts.textobjects.move.goto_previous_end["[C"] = nil
    --   opts.textobjects.move.goto_previous_end["[L"] = "@class.outer"
    -- end,
    opts = {
      textobjects = {
        move = {
          enable = false,
        },
      },
    },
  },
  {
    "roxma/vim-tmux-clipboard",
  },
  -- {
  --   "akinsho/bufferline.nvim",
  --   enabled = false,
  -- },
  {
    "rasulomaroff/reactive.nvim",
    opts = {
      -- load = { "catppuccin-late-cursor", "catppuccin-late-cursorline" },
      builtin = {
        cursorline = true,
        cursor = true,
        modemsg = true,
      },
    },
  },
}
