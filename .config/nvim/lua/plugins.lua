local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

 {
   "preservim/vim-markdown",
   branch = "master",
   dependencies = {
     "godlygeek/tabular"
   },
   ft = {"markdown","md"},
   config = function()
     require "pluginsconf.markdown"
   end,
 },
  {
    "towolf/vim-helm",
    ft = "helm",
  },

  {
   "Einenlum/yaml-revealer",
    ft = {"yaml","helm"},
  },

  {
   "ntpeters/vim-better-whitespace",
    config = function()
      vim.cmd [[let g:better_whitespace_ctermcolor='174']]
      vim.cmd [[let g:better_whitespace_filetypes_blacklist=['toggleterm','diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive'] ]]
    end,
  },
{
  "alexghergh/nvim-tmux-navigation",
  event = "VeryLazy",
  config = function()
    local nvim_tmux_nav = require("nvim-tmux-navigation")
    nvim_tmux_nav.setup({
      disable_when_zoomed = true,
      -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        -- last_active = "<C-\\>",
        next = "<C-Space>",
      },
    })
  end,
},

  { "tpope/vim-eunuch" },
  {
    "tpope/vim-commentary",
    keys = {
      { "gc" },
      { "gc", mode = "v" },
    }
  },

    -- hsearch auto on/off
  {
    "romainl/vim-cool",
     vim.cmd [[let g:CoolTotalMatches="1"]]
  },
  { "tpope/vim-abolish" },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "tpope/vim-surround",
    keys = {
      { "cs" },
      { "ds" },
      { "S", mode = "x" },
      { "ys" },
    },
  },
  {
    "tpope/vim-repeat",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require "pluginsconf.toggleterm"
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.cmd [[nnoremap <leader>u :UndotreeShow<CR>]]
    end,
    keys = "<leader>u",
  },
  {
    "jremmen/vim-ripgrep",
    cmd = { "Rg" },
  },
  {
    "mhinz/vim-grepper",
    lazy = false,
    init = function()
      vim.cmd [[
        nmap gs <plug>(GrepperOperator)
        xmap gs <plug>(GrepperOperator)
      ]]
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require "pluginsconf.nvim-web-devicons"
    end,
  },
  -- {
  --   "vim-test/vim-test",
  --   config = function()
  --     require("pluginsconf.vim-test").setup()
  --   end,
  --   keys = {
  --     { "<leader>tf" },
  --     { "<leader>tt" },
  --     { "<leader>ts" },
  --     { "<leader>tl" },
  --     { "<leader>tv" },
  --     { "<leader>wtf" },
  --     { "<leader>wtt" },
  --     { "<leader>wts" },
  --     { "<leader>wtl" },
  --     { "<leader>wtv" },
  --     { "<leader>tdt" },
  --     { "<leader>tdf" },
  --     { "<leader>tds" },
  --     { "<leader>tdl" },
  --     { "<leader>tdv" },
  --   },
  -- },
  {
    "windwp/nvim-autopairs",
    config = function()
      require "pluginsconf.nvim-autopairs"
    end,
    event = "InsertEnter",
  },

  {
     -- also exists codeium.nvim with vim-cmp integration instead of virtual text
   "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
      })
    end
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("pluginsconf.oil").setup()
    end,
  },
  {
    "tommcdo/vim-exchange",
    keys = {
      { "cx" },
      { "X", mode = "x" },
    },
  },
  {
    "glacambre/firenvim",
    lazy = false,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      require "pluginsconf.firenvim"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "j-hui/fidget.nvim"
    },
    event = "BufReadPost",
    config = function()
      require "pluginsconf.lsp"
    end,
  },
  {
      "WhoIsSethDaniel/mason-tool-installer",
      config = function()
        require('mason-tool-installer').setup {
          ensure_installed = {
          'gopls',
          'golines',
          'gotests',
          'goimports-reviser',
          'jq',
          'tflint',
          'lua-language-server',
          'yq'
            },
          }
     end,
    },
  
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require "pluginsconf.fidget"
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
  },
  {
    "hrsh7th/nvim-cmp",
    event = "BufEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "lukas-reineke/cmp-rg",
      "Exafunction/codeium.nvim",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",

    },
    config = function()
      require "pluginsconf.nvim-cmp"
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v1.*",
    -- install jsregexp (optional!:).
    build = "make install_jsregexp",
    config = function()
      require "pluginsconf.luasnip"
    end,
  },
  { "rafamadriz/friendly-snippets"},
  { "hrsh7th/vim-vsnip",
      config = function()
        vim.cmd [[let g:vsnip_snippet_dir="~/.config/nvim/vsnip"]]
      end,
  },
  -- { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp", },
  { "hrsh7th/cmp-buffer", },
  { "hrsh7th/cmp-path", },
  { "hrsh7th/cmp-cmdline", },
  { "lukas-reineke/cmp-rg", },
  {
    "onsails/lspkind-nvim",
  },
  {
    "folke/neodev.nvim"
  },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = function()
      require "pluginsconf.telescope"
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "tpope/vim-fugitive",
    cmd = {"Git"},
    config = function()
      require("pluginsconf.fugitive").setup()
    end,
    keys = {
      { "<leader>gb" },
      { "<leader>gd" },
    }
  },
  {
    "tpope/vim-rhubarb",
    dependencies = "vim-fugitive",
  },
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    keys = {
      { "<leader>gg" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",                 -- required
      "nvim-telescope/telescope.nvim",         -- optional
      "sindrets/diffview.nvim",                -- optional
    },
    config = function()
      require("neogit").setup {
        integrations = {
          diffview = true,
          telescope = true
        },
      }
      vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', {})
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require "pluginsconf.diffview"
    end,
    cmd = { "DiffviewOpen" },
    keys = "<leader>ddo",
  },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000,
    config = function()
      require "pluginsconf.tokyonight"
    end,
  },

  {
      "NLKNguyen/papercolor-theme",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "pluginsconf.treesitter"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "TSPlaygroundToggle",
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost" },
  },
  {
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost" },
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "pluginsconf.gitsigns"
    end,
    event = "BufRead",
  },
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
    event = { "BufReadPost" },
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "kevinhwang91/nvim-bqf", "junegunn/fzf" },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { { "nvim-tree/nvim-web-devicons", optional = true } },
    config = function()
      require "pluginsconf.lualine"
    end,
  },
  {
    "hashivim/vim-terraform",
    ft = { "terraform" },
  },
  {
    "wellle/targets.vim",
    event = { "BufReadPost" },
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup {
        highlight_hovered_item = true,
        show_guides = true,
      }
    end,
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
  },
  {
    'mfussenegger/nvim-lint',
    event = "BufReadPost",
    config = function()
      require('pluginsconf.nvim-lint').setup()
    end
  },
  {
    "kevinhwang91/nvim-bqf",
    dependencies = { { "junegunn/fzf", optional = true }, { "junegunn/fzf.vim", optional = true } },
    ft = { "qf" },
    -- config = function()
    --   require("bqf").setup {
    --     auto_enable = true,
    --   }
    -- end,
  },
  -- DAP
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("telescope").load_extension "dap"
      require "pluginsconf.dap"
    end,
    keys = { { "<leader>db" }, { "<leader>dB" } },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = "mfussenegger/nvim-dap",
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "dap"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require "pluginsconf.dap.dap-ui"
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require "pluginsconf.which-key"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "InsertEnter" },
    init = function()
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_filetype_exclude = { "toggleterm" }
    end,
  },
    -- jump in indent, usefull for yaml
  {
    "jeetsukumaran/vim-indentwise",
  },
  {
    "AndrewRadev/bufferize.vim",
    cmd = { "Bufferize" },
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        plugins = {
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = true,
            font = "+4", -- font size increment
          },
        },
      }
      vim.cmd [[
        nnoremap <leader>zz :lua require("zen-mode").toggle({ window = { width = .80 }})<CR>
      ]]
    end,
    keys = "<leader>zz",
  },
  {
    "AckslD/nvim-neoclip.lua",
    event = "BufReadPost",
    dependencies = { "tami5/sqlite.lua",module = "sqlite" },
    config = function()
      require("neoclip").setup {
        enable_persistent_history = true,
        continuous_sync = true,
      }
      vim.cmd [[nnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>]]
    end,
    keys = {
      { "<leader>y" },
    },
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require "pluginsconf.auto-session"
    end,
  },
  {
    "rmagatti/alternate-toggler",
    config = function()
      require("alternate-toggler").setup {
        alternates = {
          ["=="] = "!=",
        },
      }
      vim.keymap.set(
        "n",
        "<leader><space>", -- <space><space>
        require("alternate-toggler").toggleAlternate
      )
    end,
    event = { "BufReadPost" },
  },
  -- {
  --   "rmagatti/goto-preview",
  --   dev = true,
  --   config = function()
  --     require("pluginsconf.goto-preview").setup()
  --   end,
  --   keys = {
  --     { "gpd" },
  --     { "gpi" },
  --     { "gpr" },
  --     { "gP" },
  --     { "L" },
  --   },
  -- },
  -- {
  --   "rmagatti/igs.nvim",
  --   event = { "BufReadPost" },
  --   config = function()
  --     require "pluginsconf.igs"
  --   end,
  -- },
  {
    "eandrju/cellular-automaton.nvim",
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap = true })
    end,
    keys = {
      { "<leader>fml" },
    },
  },
  {
    "sourcegraph/sg.nvim",
    config = require("pluginsconf.sg").setup,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/cmp-nvim-lsp"
    },
    keys = {
      { "<leader>sg" },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("pluginsconf.dressing").setup()
    end,
  },
  -- {
  --   "rmagatti/gx-extended.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("pluginsconf.gx-extended").setup()
  --   end,
  --   dev = true
  -- },

   {
      "jose-elias-alvarez/null-ls.nvim",
      -- ft = {"go"},
      -- config = require("pluginsconf.lsp.null-ls").setup,
        config = function()
          require "pluginsconf.lsp.null-ls"
        end,
    },

    {
      "olexsmir/gopher.nvim",
      ft = {"go"},
      config = function ()
        require("gopher").setup{
          commands = {
              go = "go",
              gomodifytags = "gomodifytags",
              gotests = "gotests", -- also you can set custom command path
              impl = "impl",
              iferr = "iferr",
            },
        }
      end,
    },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("pluginsconf.refactoring").setup()
    end,
  }
}, { defaults = { lazy = true }, dev = { path = "~/Projects" } })
