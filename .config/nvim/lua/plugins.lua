local ensure_packer = function()

  local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local config = {
  -- compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
  -- profile = {
  --   enable = true,
  --   threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
  -- }
}

return require("packer").startup {
  function(use)
    use {
      "wbthomason/packer.nvim",
      -- commit = '8bee5e4ce13691fcb040eced2a219e637b7ef1a1',
    }

    -- use {
    --   "fatih/vim-go",
    --   ft = "go",
    -- }

    use {
      "towolf/vim-helm",
      ft = "helm",
    }
    -- :Stripwthitespaces
    use {
      "ntpeters/vim-better-whitespace",
      config = function()
        vim.cmd [[let g:better_whitespace_ctermcolor='174']]
        vim.cmd [[let g:better_whitespace_filetypes_blacklist=['toggleterm','diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive'] ]]
      end,
    }

    use {
      "Einenlum/yaml-revealer",
      ft = {"yaml","helm"},
    }
    -- TODO: trying out Comment.nvim, remove if not working out
    -- use {
    --   "tpope/vim-commentary",
    --   keys = {
    --     { "n", "gc" },
    --   },
    -- }

    -- use {
    --   "numToStr/Comment.nvim",
    --   config = function()
    --     require "pluginsconf.comment"
    --   end,
    -- }

    use {
      "JoosepAlviste/nvim-ts-context-commentstring",
      before = "Comment.nvim",
    }

    --    use {
    --      "tpope/vim-eunuch",
    --    }

    -- use {
    --   "lewis6991/impatient.nvim",
    -- }

    use {
      "christoomey/vim-tmux-navigator",
      vim.cmd [[let g:tmux_navigator_disable_when_zoomed="1"]]
    }

    use {
      "tpope/vim-surround",
      keys = {
        { "n", "cs" },
        { "n", "ds" },
        { "x", "S" },
        { "n", "ys" },
      },
    }

    use {
      "tpope/vim-commentary",
    }

    use {
      "tpope/vim-abolish",
    }
    use {
      "tpope/vim-repeat",
    }

    use {
      "akinsho/toggleterm.nvim",
      after="vim-tmux-navigator",
      -- tag = "v2.*",
      config = function()
        require "pluginsconf.toggleterm"
      end,
    }

    --    use {
    --      "dbeniamine/cheat.sh-vim",
    --      keys = {
    --        { "n", "<leader>KB" },
    --        { "n", "<leader>KK" },
    --        { "n", "<leader>KP" },
    --      },
    --      cmd = { "Cheat", "CheatPaste" },
    --    }

    use {
      "mbbill/undotree",
      config = function()
        vim.cmd [[nnoremap <leader>u :UndotreeShow<CR>]]
      end,
      keys = "<leader>u",
    }

    -- Grepping
    use {
      "jremmen/vim-ripgrep",
      cmd = { "Rg" },
    }

    -- use {
    --   "mhinz/vim-grepper",
    --   config = function()
    --     vim.cmd [[
    --        nmap gs <Plug>(GrepperOperator)
    --        xmap gs <Plug>(GrepperOperator)
    --      ]]
    --   end,
    --   cmd = { "Grepper", "<Plug>(GrepperOperator)" },
    --   keys = {
    --     { "n", "gs" },
    --     { "x", "gs" },
    --   },
    -- }

    use {
      "nvim-tree/nvim-web-devicons",
      config = function()
        require "pluginsconf.nvim-web-devicons"
      end,
    }

    use {
      "windwp/nvim-autopairs",
      config = function()
        require "pluginsconf.nvim-autopairs"
      end,
      event = "InsertEnter",
    }

   -- use {
     -- also exists codeium.nvim with vim-cmp integration instead of virtual text
     -- "Exafunction/codeium.nvim",
     --  requires = {
     --    "nvim-lua/plenary.nvim",
     --    "hrsh7th/nvim-cmp",
     --  },
     --  config = function()
     --    require("codeium").setup({
     --    })
     --  end
   -- }

    -- use {
    --   "nvim-tree/nvim-tree.lua",
    --   tag = "nightly", -- optional, updated every week. (see issue #1193)
    --   config = function()
    --     require "pluginsconf.nvim-tree"
    --   end,
    -- }

    use {
      "justinmk/vim-dirvish",
      config = function()
        vim.cmd [[
             command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish
             command! VLeftDirvishFile leftabove vsplit | vertical resize 50 | silent Dirvish %
             nnoremap <leader>fs :VLeftDirvish<CR>
             nnoremap <leader>ff :VLeftDirvishFile<CR>
           ]]
      end,
    }

    use {
      "roginfarrer/vim-dirvish-dovish",
      branch = "main",
      requires = { "justinmk/vim-dirvish" },
      config = function()
        vim.cmd [[
           let g:dirvish_dovish_map_keys = 0

           augroup dirvish_config
           autocmd!
           " unmap dirvish default
           autocmd FileType dirvish silent! unmap <buffer><C-p>
           autocmd FileType dirvish silent! unmap <buffer>p

           " My mappings
           autocmd FileType dirvish silent! map <buffer>i <Plug>(dovish_create_file)
           autocmd FileType dirvish silent! map <buffer>I <Plug>(dovish_create_directory)
           autocmd FileType dirvish silent! map <buffer>dd <Plug>(dovish_delete)
           autocmd FileType dirvish silent! map <buffer>r <Plug>(dovish_rename)
           autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)
           autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)
           autocmd FileType dirvish silent! map <buffer>p <Plug>(dovish_copy)
           autocmd FileType dirvish silent! map <buffer>P <Plug>(dovish_move)
           augroup END
         ]]
      end,
    }

    --    use {
    --      "kristijanhusak/vim-dirvish-git",
    --      opt = true,
    --      requires = { "justinmk/vim-dirvish" },
    --    }

    use {
      "ggandor/leap.nvim",
      config = function()
        require("leap").add_default_mappings()
      end,
      module = { "leap" },
      keys = {
        { "n", "s" },
        { "n", "S" },
        { "n", "f" },
        { "n", "F" },
      },
    }

    use {
      "preservim/vim-markdown",
      branch = "master",
      require = {
        "godlygeek/tabular"
      },
      ft = {"markdown","md"},
      config = function()
        require "pluginsconf.markdown"
      end,
    }

    use {
      "tommcdo/vim-exchange",
      keys = {
        { "n", "cx" },
        { "x", "X" },
      },
    }

    use {
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
      config = function()
        require "pluginsconf.firenvim"
      end,
    }

    --    -- TODO: do I really use this?
    --    --use {
    --    -- 'michaeljsmith/vim-indent-object',
    --    -- event = 'BufReadPost'
    --    --}

    use {
      "mg979/vim-visual-multi",
      branch = "master",
      keys = "<C-n>",
      config = function()
        vim.cmd [[let g:VM_custom_motions  = {'h': 'h', 'j': 'j', 'k':'k', 'l':'l'}]]
      end,
    }

    -- LSP

    -- use {
    -- "jay-babu/mason-null-ls.nvim",
    --   event = { "BufReadPre", "BufNewFile" },
    --   requires= {{"williamboman/mason.nvim"}, {"jose-elias-alvarez/null-ls.nvim"}},
    -- config = function()
    --   require("mason-null-ls").setup({
    --     ensure_installed = {"golines"}
    --   }
    --   )-- require your null-ls config here (example below)
    -- end,
-- }
    use {
      "WhoIsSethDaniel/mason-tool-installer",
      config = function()
        require('mason-tool-installer').setup {
          ensure_installed = {
          'gopls',
          'golines',
          'goimports-reviser',
          'jq',
          'tflint',
          'lua-language-server',
            },
          }
     end,
    }

    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "neovim/nvim-lspconfig",
        config = function()
          require "pluginsconf.lsp"
        end,
      },
    }

    use {
      "ray-x/lsp_signature.nvim",
      module = { "lsp_signature" },
    }

    use {
      "hrsh7th/nvim-cmp",
      config = function()
        require "pluginsconf.nvim-cmp"
      end,
    }

    use { "hrsh7th/cmp-vsnip", after = "nvim-cmp" }
    use { "rafamadriz/friendly-snippets" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    -- use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
    use { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }
    use { "lukas-reineke/cmp-rg", after = "nvim-cmp" }

    use {
      "David-Kunz/cmp-npm",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("cmp-npm").setup {}
      end,
      after = "nvim-cmp",
    }

    -- use {
    --   "onsails/lspkind-nvim",
    --   module = "lspkind",
    -- }

    -- Lua plugin dev
    use {
      "folke/neodev.nvim",
      module = "neodev",
      ft = "lua",
    }

    -- -- Snippets
    use {
      "hrsh7th/vim-vsnip",
      config = function()
        vim.cmd [[let g:vsnip_snippet_dir="~/.config/nvim/vsnip"]]
      end,
    }

    -- -- Telescope
    use { "nvim-lua/plenary.nvim" }
    use {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.2",
      requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
      config = function()
        require "pluginsconf.telescope"
      end,
      -- cmd = "Telescope",
      -- keys = {
      --   { "n", "<C-p>" },
      --   { "n", "<leader>ps" },
      --   { "n", "<leader>pg" },
      --   { "n", "<leader>pl" },
      --   { "n", "<leader>b" },
      --   { "n", "<M-CR>" },
      -- },
      -- module = { "telescope" },
    }

    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      requires = { "nvim-telescope/telescope.nvim" },
      config = function()
        require("telescope").load_extension "fzf"
      end,
      after = "telescope.nvim",
    }

    ---- Git
    -- use {
    --   "airblade/vim-gitgutter"
    -- }
    use {
      "tpope/vim-fugitive",
      -- cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gvdiffsplit" },
      config = require("pluginsconf.fugitive").setup,
      -- keys = {
      --   { "n", "<leader>gd" },
      --   { "n", "<leader>gb" },
      -- },
    }

    use {
      "TimUntersberger/neogit",
      opt = true,
      cmd = { "Neogit" },
      keys = {
        { "n", "<leader>gg" },
      },
      config = function()
        require("neogit").setup {
          integrations = {
            diffview = true,
          },
        }
        vim.cmd [[nnoremap <leader>gg <cmd>Neogit<CR>]]
      end,
    }

    use {
      "sindrets/diffview.nvim",
      config = function()
        require "pluginsconf.diffview"
      end,
      cmd = { "DiffviewOpen" },
      keys = "<leader>ddo",
    }

    -- use {
    --   'ThePrimeagen/git-worktree.nvim',
    --   requires = {'nvim-telescope/telescope.nvim'},
    --   config = function()
    --     require('telescope').load_extension("git_worktree")
    --     vim.cmd[[nnoremap <leader>wt <cmd>Telescope git_worktree git_worktrees<CR>]]
    --   end,
    --   keys = '<leader>wt'
    -- }

    -- use {
    --   "ThePrimeagen/refactoring.nvim",
    --   requires = {
    --     { "nvim-lua/plenary.nvim" },
    --     { "nvim-treesitter/nvim-treesitter" },
    --   },
    --   config = function()
    --     require "pluginsconf.refactoring"
    --     vim.keymap.set("v", "<leader>re", [[<cmd>call v:lua.list_refactors()<CR>]], { silent = true, expr = true })
    --   end,
    --   keys = {
    --     { "v", "<leader>re" },
    --   },
    -- }

    -- Themes
  --   use { 'ellisonleao/gruvbox.nvim',
  --     config = function()
  --       require "pluginsconf.gruvbox"
  --     end,
  -- }

    use {
      "folke/tokyonight.nvim",
      config = function()
        require "pluginsconf.tokyonight"
      end,
    }

    use {
      "NLKNguyen/papercolor-theme",
    }
    -- hsearch auto on/off
    use {
      "romainl/vim-cool",
        vim.cmd [[let g:CoolTotalMatches="1"]]
    }

    -- Tree-sitter
    use {
      "nvim-treesitter/nvim-treesitter", -- TODO: lazy load me! (maybe)
      run = ":TSUpdate",
      config = function()
        require "pluginsconf.treesitter"
      end,
    }

    use {
      "nvim-treesitter/nvim-treesitter-context",
      requires = "nvim-treesitter/nvim-treesitter-context",
    }

    use {
      "nvim-treesitter/playground",
      requires = { "nvim-treesitter/nvim-treesitter" },
      cmd = "TSPlaygroundToggle",
    }

    -- Rainbow parentheses
    use {
      "p00f/nvim-ts-rainbow",
      event = "BufReadPost",
    }

    use {
      "nvim-treesitter/nvim-treesitter-textobjects",
      requires = { "nvim-treesitter/nvim-treesitter" },
      event = { "BufReadPost" },
    }

    use {
      "RRethy/nvim-treesitter-textsubjects",
      requires = { "nvim-treesitter/nvim-treesitter" },
      event = { "BufReadPost" },
    }

    -- -- GitHub
    --   use  {
    --     'pwntester/octo.nvim',
    --     config = function()
    --       require"octo".setup()
    --     end,
    --     cmd = {'Octo'}
    --   }

    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require "pluginsconf.gitsigns"
      end,
      event = "BufRead",
    }

    -- Fzf
    use {
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end,
      event = { "BufReadPost" },
    }

    use {
      "junegunn/fzf.vim",
      requires = "junegunn/fzf",
      after = { "nvim-bqf" },
    }

    -- Lualine
    use {
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require "pluginsconf.lualine"
      end,
    }

    -- TODO: table index is null issue when this is enabled
    -- use {
    --   'nvim-lua/lsp-status.nvim',
    -- }

    -- Terraform
    use {
      "hashivim/vim-terraform",
      disable = false,
      ft = { "terraform" },
    }

    -- Text objects
    use {
      "wellle/targets.vim",
      event = { "BufReadPost" },
    }

    -- Symbols
    use {
      "simrat39/symbols-outline.nvim",
      config = function()
        require("symbols-outline").setup {
          highlight_hovered_item = true,
          show_guides = true,
        }
      end,
      cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    }

    use {
      "jose-elias-alvarez/null-ls.nvim",
      -- ft = {"go"},
      -- config = require("pluginsconf.lsp.null-ls").setup,
        config = function()
          require "pluginsconf.lsp.null-ls"
        end,
    }

    use {
      "olexsmir/gopher.nvim",
      ft = {"go"},
      run = function()
        vim.cmd [[silent! GoInstallDeps]]
      end,
      config = function ()
        require("gopher").setup{
          commands = {
              go = "go",
              gomodifytags = "gomodifytags",
              gotests = "~/go/bin/gotests", -- also you can set custom command path
              impl = "impl",
              iferr = "iferr",
            },
        }
      end,
    }
    --
    -- use {
    --   "jose-elias-alvarez/typescript.nvim",
    --   requires = { "neovim/nvim-lspconfig", "jose-elias-alvarez/null-ls.nvim" },
    -- }
    --
    -- use {
    --   "heavenshell/vim-jsdoc",
    --   ft = { "javascript", "javascript.jsx", "typescript" },
    --   cmd = "JsDoc",
    --   run = "make install",
    -- }

    -- Quickfix enhancements
    use {
      "kevinhwang91/nvim-bqf",
      requires = { { "junegunn/fzf", opt = true }, { "junegunn/fzf.vim", opt = true } },
      ft = { "qf" },
      config = function()
        require("bqf").setup {
          auto_enable = true,
        }
      end,
    }

    -- Aligning
    use {
      "junegunn/vim-easy-align",
      config = function()
        require "pluginsconf.easyalign"
      end,
      cmd = { "EasyAlign" },
    }

    -- DAP
    use {
      "mfussenegger/nvim-dap",
      config = function()
        require("telescope").load_extension "dap"
        require "pluginsconf.dap"
      end,
      keys = { { "n", "<leader>db" }, { "n", "<leader>dB" } },
    }
    use {
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
    }
    use {
      "nvim-telescope/telescope-dap.nvim",
      requires = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
      config = function()
        require("telescope").load_extension "dap"
      end,
      after = "nvim-dap",
      module = "telescope._extensions.dap",
    }

    use {
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require "pluginsconf.dap.dap-ui"
      end,
      after = "nvim-dap",
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      config = function()
        require "pluginsconf.which-key"
      end,
    }

    -- Indent Blankline
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = { "InsertEnter" },
      setup = function()
        vim.g.indent_blankline_buftype_exclude = { "terminal" }
        vim.g.indent_blankline_filetype_exclude = { "toggleterm" }
      end,
    }

    -- jump in indent, usefull for yaml
    use {
      "jeetsukumaran/vim-indentwise",
    }

    -- Bufferize commands
    use {
      "AndrewRadev/bufferize.vim",
      cmd = { "Bufferize" },
    }

    use {
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
    }

    -- Profiling
    use { "dstein64/vim-startuptime", cmd = "StartupTime", config = [[vim.g.startuptime_tries = 10]] }

    use {
      "AckslD/nvim-neoclip.lua",
      requires = { "tami5/sqlite.lua", module = "sqlite" },
      config = function()
        require("neoclip").setup {
          enable_persistent_history = true,
          continuous_sync = true,
        }
        vim.cmd [[nnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>]]
      end,
      -- keys = {
      --   { "n", "<leader>y" },
      -- },
    }
    use {
      'rmagatti/auto-session',
      config = function()
        require("auto-session").setup {
          log_level = "error",
          auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
        }
      end
    }

    -- Local
    -- use {
    --   "~/Projects/auto-session",
    --   config = function()
    --     require "pluginsconf.auto-session"
    --     require "pluginsconf.session-lens"
    --   end,
    -- }
    --
    -- use {
    --   "~/Projects/alternate-toggler",
    --   config = function()
    --     require("alternate-toggler").setup {
    --       alternates = {
    --         ["=="] = "!=",
    --       },
    --     }
    --     vim.keymap.set(
    --       "n",
    --       "<leader><space>", -- <space><space>
    --       "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>"
    --     )
    --   end,
    --   event = { "BufReadPost" }, -- lazy load after reading a buffer
    -- }
    --
    -- use {
    --   "~/Projects/goto-preview",
    --   config = function()
    --     require "pluginsconf.goto-preview"
    --   end,
    --   keys = {
    --     { "n", "gpd" },
    --     { "n", "gpi" },
    --     { "n", "gpr" },
    --     { "n", "gP" },
    --   },
    -- }
    --
    use {
      'ryicoh/deepl.vim',
      config = function()
        require "pluginsconf.deepl"
      end,
    }
     use {
       'rmagatti/session-lens',
       requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
       config = function()
         require "pluginsconf.session-lens"
         require("telescope").load_extension "session-lens"
       end,
       keys = "<C-s>",
     }
    --
    -- use {
    --   "~/Projects/telescope-ui-select.nvim",
    --   requires = { "nvim-telescope/telescope.nvim" },
    --   after = "telescope.nvim",
    --   config = function()
    --     require("telescope").load_extension "ui-select"
    --   end,
    -- }
    --
    -- use {
    --   "~/Projects/igs.nvim",
    --   event = { "BufReadPost" },
    --   config = function()
    --     require "pluginsconf.igs"
    --   end,
    -- }
    --
    -- use {
    --   "github/copilot.vim",
    --   event = { "InsertEnter" },
    --   config = function()
    --     vim.g.copilot_filetypes = {
    --       ["*"] = false,
    --       ["c"] = true,
    --       ["cpp"] = true,
    --       ["c++"] = true,
    --       ["c#"] = true,
    --       ["csharp"] = true,
    --       ["cs"] = true,
    --       ["css"] = true,
    --       ["html"] = true,
    --       ["js"] = true,
    --       ["javascript"] = true,
    --       ["typescript"] = true,
    --       ["json"] = true,
    --       ["lua"] = true,
    --       ["php"] = true,
    --       ["py"] = true,
    --       ["python"] = true,
    --       ["ruby"] = true,
    --       ["rust"] = true,
    --       ["sh"] = true,
    --       ["vim"] = true,
    --       ["yaml"] = true,
    --     }
    --   end,
    -- }
    --
    -- use {
    --   "eandrju/cellular-automaton.nvim",
    --   config = function()
    --     vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap = true })
    --   end,
    --   keys = {
    --     { "n", "<leader>fml" },
    --   },
    -- }
    --
    -- --- ===== copilot =====
    -- -- use {
    -- --   "zbirenbaum/copilot.lua",
    -- --   event = "InsertEnter",
    -- --   config = function()
    -- --     vim.schedule(function()
    -- --       require("copilot").setup()
    -- --     end)
    -- --   end,
    -- --   enabled = false,
    -- -- }
    --
    -- -- use {
    -- --   "zbirenbaum/copilot-cmp",
    -- --   module = "copilot_cmp",
    -- --   enabled = false,
    -- -- }
    -- --- ===== copilot =====
    --
    -- -- use {
    -- --   "mattn/emmet-vim",
    -- -- }
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = config,
}
