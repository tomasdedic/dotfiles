local M = {}

function M.setup()
	require("oil").setup({
		use_default_keymaps = false,
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["gs"] = "actions.select_vsplit",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-r>"] = "actions.refresh",
			["-"] = { "actions.parent", mode = "n" },
			["_"] = { "actions.open_cwd", mode = "n" },
			["`"] = { "actions.cd", mode = "n" },
			-- ["~"] = "actions.tcd",
			-- ["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			-- ["g\\"] = "actions.toggle_trash",
		},
	})

	-- vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	vim.keymap.set("n", "_", function()
		require("oil").open(vim.fn.getcwd())
	end, { desc = "Open CWD" })
end

return M
