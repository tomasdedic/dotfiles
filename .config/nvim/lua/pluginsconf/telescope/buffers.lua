local M = {}

M.custom_buffers = function()
	require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
		sort_lastused = true,
		show_all_buffers = true,
	}))
end

M.setup = function()
	vim.keymap.set("n", "<leader>b", function()
		require("pluginsconf.telescope.buffers").custom_buffers()
	end, { desc = "telescope buffersTopDown" })
end

return M
