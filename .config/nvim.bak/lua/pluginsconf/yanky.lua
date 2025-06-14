local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping")
local wk = require("which-key")
require("yanky").setup({
	opts = {
		highlight = { timer = 300 },
		ring = { storage = "sqlite" },
	},
	picker = {
		telescope = {
			mappings = {
				default = mapping.put("p"),
				i = {
					["<C-j>"] = require("telescope.actions").move_selection_next,
					["<C-k>"] = require("telescope.actions").move_selection_previous,
					["<c-g>"] = mapping.put("p"),
					["<c-x>"] = mapping.delete(),
					["<c-r>"] = mapping.set_register(utils.get_default_register()),
				},
				n = {
					p = mapping.put("p"),
					P = mapping.put("P"),
					d = mapping.delete(),
					r = mapping.set_register(utils.get_default_register()),
				},
			},
		},
	},
	wk.add({
		{
			"<leader>y",
			function()
				require("telescope").extensions.yank_history.yank_history({})
			end,
			mode = { "n", "x" },
			desc = "Open Yank History",
		},
		{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
		{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },
		{ "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
		{ "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
		{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
		{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
		{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
		{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
		{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
		{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
		{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
		{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
		{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
		{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
	}),
})
