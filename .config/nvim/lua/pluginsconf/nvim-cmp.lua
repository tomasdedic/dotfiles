-- vim.o.completeopt = "menu,menuone,noselect,noinsert"
-- require "snippets"

-- vim.opt.completeopt = { "menu", "menuone", "noselect","noinsert" }
-- vim.opt.shortmess:append "c"

local cmp = require("cmp")

local lspkind = require("lspkind")
lspkind.init({})

local mapping = cmp.mapping.preset.insert({
	-- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
	-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-x>"] = cmp.mapping.complete({}),
	["<C-e>"] = cmp.mapping.close(),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	-- ["<C-p>"] = cmp.mapping.select_prev_item(),
	-- ["<C-n>"] = cmp.mapping.select_next_item(),
	["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
	["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
})

cmp.setup({
	enabled = function()
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
		if buftype == "prompt" then
			return false
		end
		-- if buftype == "chatgpt-input" then return false end

		local context = require("cmp.config.context")
		-- disable autocompletion in comments
		return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
	end,

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
		}),
	},

	mapping = mapping,
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = "vsnip" },
		{ name = "luasnip" },
		{ name = "path" },
		-- { name = "cmp_yanky" },
		-- { name = "npm", keyword_length = 4 },
		-- { name = "codeium", keyword_length = 3, group_index = 2 },
		-- { name = "rg", keyword_length = 3, group_index = 2 },
	}, {
		{
			name = "buffer",
			-- load completition from all openbuffers but in init.vim set hidden must be set instead of set nohidden(bufer get offloaded)
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
	}),
	-- Enable luasnip to handle snippet expansion for nvim-cmp
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
})
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#6CC644" })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
