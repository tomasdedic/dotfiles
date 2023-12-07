local actions = require "telescope.actions"

require("telescope").setup {
  pickers = {
     buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
            layout_config = {
              preview_cutoff = 200
              }
        },
     jumplist = {
            layout_config = {
              preview_cutoff = 200
              }
        },

  },
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.55,
        result_width = 0.8,
        -- mirror = false,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {"node_modules"},
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    mappings = {
      i = {
        -- Close on first esc instead of going to normal mode
        ["<esc>"] = actions.close,
        ["<C-i>"] = require("telescope.actions").cycle_history_next,
        ["<C-o>"] = require("telescope.actions").cycle_history_prev,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-w>"] = "which_key",
        ["<C-d>"] = require("telescope.actions").delete_buffer,
        ["<Tab>"] = require("telescope.actions").toggle_selection,
        -- ["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
        -- ["<C-w>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
      },
      n = {
    	  ["<C-d>"] = require('telescope.actions').delete_buffer,
      }, -- normal
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_cursor {},
      },
    },
  },
}


require("pluginsconf.telescope.buffers").setup()
-- require("pluginsconf.telescope.dotfiles").setup()
-- require("pluginsconf.telescope.session-searching").setup()
require("pluginsconf.telescope.mappings")

-- require("telescope").load_extension "session-lens"
-- require("telescope").load_extension "fzf"
