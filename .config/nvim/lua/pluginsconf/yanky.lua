local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping")
require("yanky").setup({
	opts = {
		highlight = { timer = 150 },
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
})
