local M = {}

function M.setup()
	vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { silent = false })
	vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>", { silent = true })
	vim.keymap.set("n", "gj", ":diffget //2<CR>", { silent = true })
	vim.keymap.set("n", "g;", ":diffget //3<CR>", { silent = true })

	vim.keymap.set("n", "<leader>gh", ":0Gclog<CR>", { silent = true })
	vim.keymap.set("n", "<localleader>gg", ":GBrowse<CR>", { silent = true })
end

return M
