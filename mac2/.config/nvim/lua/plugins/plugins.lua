return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
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
      custom_highlights = function()
        -- Use catppuccin latte (light) colors for a bright terminal
        return {
          SnacksTerminalNormal = { bg = "#eff1f5", fg = "#4c4f69" },
        }
      end,
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
      presets = {
        bottom_search = false, -- `/` in the popup too, not the classic bottom line
        command_palette = false, -- cmdline back in the middle (LazyVim pins it to row 3)
      },
      views = {
        cmdline_popup = {
          position = { row = 3, col = "50%" },
        },
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
    ft = { "yaml", "helm", "yaml.gh", "yaml.ansible" }, -- optional
    -- plugin silently no-ops when &filetype is not in this list
    opts = { ft = { "yaml", "eruby.yaml", "helm", "yaml.gh", "yaml.ansible" } },
    config = function(_, opts)
      require("yaml_nvim").setup(opts)
      local document = require("yaml_nvim.document")
      local key_of = require("yaml_nvim.pair")

      -- Raw value text with newlines kept; the plugin's own yank flattens it and doubles quotes.
      local function raw_value(node)
        while node and not (node:type() == "block_mapping_pair" and node:field("value")[1]) do
          node = node:parent()
        end
        if not node then
          return ""
        end
        local lines = vim.split(vim.treesitter.get_node_text(node:field("value")[1], 0), "\n", { plain = true })
        local from = 2 -- first line of a plain value starts mid-line, so it has no indent to strip
        if lines[1]:match("^[|>]") then
          table.remove(lines, 1) -- drop block scalar header
          from = 1
        end
        local min = math.huge
        for i = from, #lines do
          if lines[i]:match("%S") then
            min = math.min(min, #lines[i]:match("^%s*"))
          end
        end
        if min < math.huge then
          for i = from, #lines do
            lines[i] = lines[i]:sub(min + 1)
          end
        end
        return (table.concat(lines, "\n"):gsub("%s+$", ""))
      end

      -- register defaults to + because the plugin's default (") does not reach the system clipboard
      local function yank(key, value)
        return function(a)
          local node = document.get_key_relevant_to_cursor()
          if not node then
            return vim.notify("yaml: no key under cursor", vim.log.levels.WARN)
          end
          local k, v = key_of.parse(node).key, raw_value(node)
          local text = (key and value) and (k .. " = " .. v) or key and k or v
          vim.fn.setreg(a.args ~= "" and a.args or "+", text)
        end
      end
      vim.api.nvim_create_user_command("YAMLYank", yank(true, true), { nargs = "?" })
      vim.api.nvim_create_user_command("YAMLYankKey", yank(true, false), { nargs = "?" })
      vim.api.nvim_create_user_command("YAMLYankValue", yank(false, true), { nargs = "?" })
    end,
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
    "akinsho/bufferline.nvim",
    enabled = false,
    opts = {
      options = {
        always_show_bufferline = true, -- stops bufferline from hiding tabline
      },
    },
  },
}
