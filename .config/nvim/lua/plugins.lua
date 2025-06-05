local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{
			"echasnovski/mini.nvim",
			version = false,
			event = "VeryLazy",
			config = function()
				require("mini.trailspace").setup({})
				require("mini.comment").setup()
				require("mini.surround").setup()
				-- require("mini.git").setup()
				require("mini.diff").setup()
				require("mini.notify").setup({ lsp_progress = { enable = false } })
				require("mini.indentscope").setup()
				require("mini.pairs").setup()
				require("mini.icons").setup()
				require("mini.cursorword").setup({ delay = 300 })
			end,
		},
		{
			"LunarVim/bigfile.nvim",
		},
		{
			"tpope/vim-fugitive",
			lazy = false,
			config = function()
				require("pluginsconf.fugitive").setup()
			end,
			keys = {
				{ "<leader>gb" },
				{ "<leader>gd" },
			},
		},
		{
			"kdheepak/lazygit.nvim",
			cmd = {
				"LazyGit",
				"LazyGitConfig",
				"LazyGitCurrentFile",
				"LazyGitFilter",
				"LazyGitFilterCurrentFile",
			},
			-- optional for floating window border decoration
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			-- setting the keybinding for LazyGit with 'keys' is recommended in
			-- order to load the plugin when the command is run for the first time
			keys = {
				{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
			},
		},
		{
			"towolf/vim-helm",
			ft = "helm",
		},
		{
			"cuducos/yaml.nvim",
			ft = { "yaml", "helm" }, -- optional
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-telescope/telescope.nvim", -- optional
			},
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
			"romainl/vim-cool", --hsearch auto on/off
			lazy = false,
		},
		{ "tpope/vim-abolish" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "tpope/vim-repeat" },
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			event = "VeryLazy",
			config = function()
				require("pluginsconf.toggleterm")
			end,
		},
		{
			"stevearc/oil.nvim",
			lazy = false,
			config = function()
				require("pluginsconf.oil").setup()
			end,
		},

		--LSP
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"j-hui/fidget.nvim",
				"williamboman/mason-lspconfig.nvim",
			},
			event = "BufReadPost",
			config = function()
				require("pluginsconf.lsp")
			end,
		},
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
			config = function()
				require("mason-lspconfig").setup({
					automatic_enable = false,
					ensure_installed = {},
				})
			end,
		},
		{
			"ray-x/lsp_signature.nvim",
			event = "LspAttach",
		},
		{
			"stevearc/conform.nvim",
			config = function()
				require("pluginsconf.lsp.conform").setup()
			end,
		},

		{
			"onsails/lspkind-nvim",
			event = "InsertEnter",
		},

		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},

		{
			"someone-stole-my-name/yaml-companion.nvim",
			config = function()
				require("telescope").load_extension("yaml_schema")
			end,
		},

		{
			"b0o/SchemaStore.nvim",
		},

		{
			"WhoIsSethDaniel/mason-tool-installer",
			cmd = "MasonToolsInstall",
			config = function()
				require("mason-tool-installer").setup({
					ensure_installed = {
						{
							"gopls",
							condition = function()
								return not os.execute("go version")
							end,
						},
						"golines",
						"gotests",
						"goimports-reviser",
						"jq",
						"tflint",
						"lua-language-server",
						"yq",
						"eslint_d",
						"yaml-language-server",
						"shfmt",
						"bashls",
						"helm-ls",
						"jsonls",
						"stylua",
						"markdownlint-cli2",
						"markdown-toc",
					},
					auto_update = true,
					run_on_start = true,
				})
			end,
		},
		{
			"hrsh7th/nvim-cmp",
			lazy = false,
			priority = 100,
			-- event = "BufEnter",
			dependencies = {
				"onsails/lspkind-nvim",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				-- "chrisgrieser/cmp_yanky",
				-- "lukas-reineke/cmp-rg",
				-- { "hrsh7th/vim-vsnip",
				-- config = function()
				--   vim.cmd [[let g:vsnip_snippet_dir="~/.config/nvim/vsnip"]]
				-- end,
				-- },
				{
					"L3MON4D3/LuaSnip",
					version = "v2.*",
					event = "VeryLazy",
					-- load friendly snippets before
					dependencies = "friendly-snippets",
					build = "make install_jsregexp",
					config = function()
						require("pluginsconf.luasnip")
					end,
				},
				"saadparwaiz1/cmp_luasnip",
			},
			config = function()
				require("pluginsconf.nvim-cmp")
			end,
		},
		{
			"rafamadriz/friendly-snippets",
			lazy = false,
		},
		{ "nvim-lua/plenary.nvim" },
		{
			"cbochs/grapple.nvim",
			lazy = false,
			cmd = "Grapple",
			dependencies = {
				"nvim-telescope/telescope.nvim",
				"nvim-tree/nvim-web-devicons",
			},
			keys = {
				{ "<C-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
				{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
			},
			config = function()
				require("pluginsconf.grapple")
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			lazy = false,
			dependencies = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
				"nvim-telescope/telescope-smart-history.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
				"kkharji/sqlite.lua",
			},
			config = function()
				require("pluginsconf.telescope")
			end,
		},
		{
			"folke/tokyonight.nvim",
			config = function()
				require("pluginsconf.tokyonight")
			end,
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			lazy = false, -- make sure we load this during startup
			priority = 1000,
			config = function()
				require("pluginsconf.catppuccin")
			end,
		},

		{
			"dstein64/vim-startuptime",
			lazy = false,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			lazy = false,
			dependencies = {
				{
					"nvim-treesitter/nvim-treesitter-context",
					config = function()
						vim.keymap.set("n", "<leader>[b", function()
							require("treesitter-context").go_to_context(vim.v.count1)
						end, { silent = true })
					end,
				},
				-- "nvim-treesitter/playground",
				-- "JoosepAlviste/nvim-ts-context-commentstring",
				-- "HiPhish/rainbow-delimiters.nvim",
				-- "nvim-treesitter/nvim-treesitter-textobjects",
				-- "RRethy/nvim-treesitter-textsubjects",
			},
			config = function()
				require("pluginsconf.treesitter")
			end,
		},
		{
			"junegunn/fzf",
			event = { "BufReadPost" },
		},
		{
			"nvim-lualine/lualine.nvim",
			event = "VeryLazy",
			config = function()
				require("pluginsconf.lualine")
			end,
		},
		{
			"hashivim/vim-terraform",
			ft = { "terraform" },
		},
		-- {
		-- 	"wellle/targets.vim",
		-- 	event = { "BufReadPost" },
		-- },
		{
			"kevinhwang91/nvim-bqf",
			dependencies = { { "junegunn/fzf", optional = true } },
			ft = { "qf" },
		},
		-- DAP
		-- {
		-- 	"mfussenegger/nvim-dap",
		-- 	config = function()
		-- 		require("telescope").load_extension("dap")
		-- 		require("pluginsconf.dap")
		-- 	end,
		-- 	keys = { { "<leader>db" }, { "<leader>dB" } },
		-- },
		-- {
		-- 	"theHamsta/nvim-dap-virtual-text",
		-- 	dependencies = "mfussenegger/nvim-dap",
		-- },
		-- {
		-- 	"nvim-telescope/telescope-dap.nvim",
		-- 	dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
		-- 	config = function()
		-- 		require("telescope").load_extension("dap")
		-- 	end,
		-- },
		-- {
		-- 	"rcarriga/nvim-dap-ui",
		-- 	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		-- 	config = function()
		-- 		require("pluginsconf.dap.dap-ui")
		-- 	end,
		-- },
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{ "jeetsukumaran/vim-indentwise" }, -- jump in indent, usefull for yaml
		{
			"folke/zen-mode.nvim",
			config = function()
				require("zen-mode").setup({
					plugins = {
						-- to make this work, you need to set the following kitty options:
						-- - allow_remote_control socket-only
						-- - listen_on unix:/tmp/kitty
						kitty = {
							enabled = true,
							font = "+4", -- font size increment
						},
					},
				})
				vim.cmd([[
        nnoremap <leader>zz :lua require("zen-mode").toggle({ window = { width = .80 }})<CR>
      ]])
			end,
			keys = "<leader>zz",
		},
		{
			"gbprod/yanky.nvim",
			lazy = false,
			dependencies = {
				"nvim-telescope/telescope.nvim",
				"kkharji/sqlite.lua",
			},
			config = function()
				require("pluginsconf.yanky")
			end,
		},
		{
			"rmagatti/auto-session",
			config = function()
				require("pluginsconf.auto-session")
			end,
		},
		{
			"eandrju/cellular-automaton.nvim",
			config = function()
				vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap = true })
			end,
			keys = {
				{ "<leader>fml" },
			},
		},
		-- {
		-- 	"nvimtools/none-ls.nvim",
		-- 	lazy = false,
		-- 	dependencies = { "nvim-lua/plenary.nvim" },
		-- 	config = function()
		-- 		require("pluginsconf.lsp.null-ls").setup()
		-- 	end,
		-- },
		-- {
		-- 	"olexsmir/gopher.nvim",
		-- 	ft = { "go" },
		-- 	dependencies = {
		-- 		{ "nvim-lua/plenary.nvim" },
		-- 		{ "nvim-treesitter/nvim-treesitter" },
		-- 	},
		-- 	config = function()
		-- 		require("gopher").setup({
		-- 			commands = {
		-- 				go = "go",
		-- 				dlv = "delve",
		-- 				gomodifytags = "gomodifytags",
		-- 				gotests = "gotests", -- also you can set custom command path
		-- 				impl = "impl",
		-- 				iferr = "iferr",
		-- 			},
		-- 			gotests = {
		-- 				-- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
		-- 				template = "default",
		-- 				-- path to a directory containing custom test code templates
		-- 				template_dir = nil,
		-- 				-- switch table tests from using slice to map (with test name for the key)
		-- 				-- works only with gotests installed from develop branch
		-- 				named = false,
		-- 			},
		-- 			gotag = {
		-- 				transform = "snakecase",
		-- 			},
		-- 			log_level = vim.log.levels.INFO,
		-- 		})
		-- 	end,
		-- },
		{
			"robitx/gp.nvim",
			lazy = false,
			config = function()
				require("pluginsconf.gp").setup()
			end,
		},
		-- {
		-- 	"zbirenbaum/copilot.lua",
		-- 	cmd = "Copilot",
		-- 	event = "InsertEnter",
		-- 	config = function()
		-- 		require("copilot").setup({})
		-- 	end,
		-- },
		-- {
		-- 	"epwalsh/obsidian.nvim",
		-- 	version = "*", -- recommended, use latest release instead of latest commit
		-- 	lazy = true,
		-- 	-- ft = "markdown",
		-- 	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- 	event = {
		-- 		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- 		"BufReadPre "
		-- 			.. vim.fn.expand("~")
		-- 			.. "/vaults/**.md",
		-- 		"BufNewfile " .. vim.fn.expand("~") .. "/vaults/**.md",
		-- 	},
		-- 	dependencies = {
		-- 		-- Required.
		-- 		"nvim-lua/plenary.nvim",
		-- 	},
		-- 	config = function()
		-- 		require("pluginsconf.obsidian").setup()
		-- 	end,
		-- },
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			-- @type Flash.Config
			opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
		},
		{
			"nanotee/zoxide.vim",
			event = "VeryLazy",
		},
		{
			"yochem/jq-playground.nvim",
			lazy = false,
			cmd = "JqPlayground",
			opts = {
				cmd = { "jq" },
			},
		},
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			build = "cd app && yarn install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		},
		{
			"deponian/nvim-base64",
			version = "*",
			keys = {
				-- Decode/encode selected sequence from/to base64
				-- (mnemonic: [b]ase64)
				{ "<localleader>b", "<Plug>(FromBase64)", mode = "x" },
				{ "<localleader>B", "<Plug>(ToBase64)", mode = "x" },
			},
			config = function()
				require("nvim-base64").setup()
			end,
		},
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- add options here
				-- or leave it empty to use the default settings
			},
			keys = {
				-- suggested keymap
				{ "<localleader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
			},
		},
		{
			-- image neni funkcni protoze
			-- odejit z telescopu na snacks.picker
			"folke/snacks.nvim",
			lazy = false,
			opts = {
				image = {
					-- your image configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				},
			},
		},
		{
			"karb94/neoscroll.nvim",
			opts = {},
		},
		{
			"ray-x/go.nvim",
			dependencies = { -- optional packages
				"ray-x/guihua.lua",
				"neovim/nvim-lspconfig",
				"nvim-treesitter/nvim-treesitter",
			},
			opts = {
				-- lsp_keymaps = false,
				-- other options
			},
			config = function(opts)
				require("go").setup(opts)
				local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = "*.go",
					callback = function()
						require("go.format").goimports()
					end,
					group = format_sync_grp,
				})
			end,
			event = { "CmdlineEnter" },
			ft = { "go", "gomod" },
			build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		},
		{
			"AntonVanAssche/md-headers.nvim",
			version = "*",
			opts = {},
			ft = { "markdown" },
			keys = {
				{ "<leader>mc", "<cmd>MDHeadersCurrent<CR>", desc = "ShowMarkdownHeaders" },
				{ "<leader>mm", "<cmd>MDHeadersTelescope<CR>", desc = "ShowMarkdownHeadersTelescope" },
			},
		},
	},
	defaults = { lazy = true },
	install = { colorscheme = { "tokyonight" } },
})
