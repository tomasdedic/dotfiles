local M = {}

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "Dotfiles",
		cwd = "~/.config/nvim",
	})
end

M.setup = function()
	vim.keymap.set("n", "<leader>di", function()
		require("pluginsconf.telescope.dotfiles").search_dotfiles()
	end, { desc = "telescope nvimDotFiles" })
end

return M
