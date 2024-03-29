function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end


vim.keymap.set(
  "n",
  "<leader>fg",
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy())<CR>",
  {}
)

vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').buffers({sort_mru=true})<CR>", {})
vim.keymap.set("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<CR>", {})
vim.keymap.set("n", "<C-f>", "<cmd>lua require('telescope.builtin').find_files()<CR>", {})
-- only open buffers
vim.keymap.set("n", "<leader>po", "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>", {})
vim.keymap.set("v", "<leader>po", "<cmd>lua local text = vim.getVisualSelection() require('telescope.builtin').live_grep({grep_open_files=true, default_text = text })<CR>", {})
-- all files in cwd
vim.keymap.set("n", "<leader>ps", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {})
vim.keymap.set("v", "<leader>ps", "<cmd>lua local text = vim.getVisualSelection() require('telescope.builtin').live_grep({ default_text = text })<CR>", {})
-- only active buffer
-- vim.keymap.set( "n", "<leader>pg", "<cmd>lua require('telescope.builtin').grep_string({search=vim.fn.input('Search: ')})<CR>", {})
vim.keymap.set( "n", "<leader>pg", "<cmd>lua require('telescope.builtin').grep_string()<CR>", {})
vim.keymap.set("v", "<leader>pg", "<cmd>lua local text = vim.getVisualSelection() require('telescope.builtin').current_buffer_fuzzy_find({ default_text = text })<CR>",{})

vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", {})
vim.keymap.set("v", "<leader>fb", "<cmd>lua local text = vim.getVisualSelection() require('telescope.builtin').current_buffer_fuzzy_find({ default_text = text })<CR>",{})
-- vim.keymap.set("n", "<leader>wt", "<cmd>lua require('telescope.extensions').git_worktree.git_worktrees()<CR>", {})
vim.keymap.set("n", "<C-b>", require("telescope.builtin").git_branches, {})

vim.keymap.set("n", "<localleader>of", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", {})
vim.keymap.set("n", "<localleader>cm", require("telescope.builtin").commands, {})
vim.keymap.set("n", "<localleader>tgs", require("telescope.builtin").tags, {})
vim.keymap.set("n", "<localleader>cmh", require("telescope.builtin").command_history, {})
vim.keymap.set("n", "<localleader>sh", require("telescope.builtin").search_history, {})
vim.keymap.set("n", "<localleader>ht", require("telescope.builtin").help_tags, {})
vim.keymap.set("n", "<localleader>mp", require("telescope.builtin").man_pages, {})
vim.keymap.set("n", "<localleader>ma", require("telescope.builtin").marks, {})
vim.keymap.set("n", "<localleader>cs", require("telescope.builtin").colorscheme, {})
vim.keymap.set("n", "<localleader>qf", require("telescope.builtin").quickfix, {})
vim.keymap.set("n", "<localleader>qfh", require("telescope.builtin").quickfixhistory, {})
vim.keymap.set("n", "<localleader>ll", require("telescope.builtin").loclist, {})
vim.keymap.set("n", "<localleader>jl", require("telescope.builtin").jumplist, {})
vim.keymap.set("n", "<localleader>vo", require("telescope.builtin").vim_options, {})
vim.keymap.set("n", "<localleader>re", require("telescope.builtin").registers, {})
vim.keymap.set("n", "<localleader>ac", require("telescope.builtin").autocommands, {})
vim.keymap.set("n", "<localleader>ss", require("telescope.builtin").spell_suggest, {})
vim.keymap.set("n", "<localleader>km", require("telescope.builtin").keymaps, {})
vim.keymap.set("n", "<localleader>ft", require("telescope.builtin").filetypes, {})
vim.keymap.set("n", "<localleader>hl", require("telescope.builtin").highlights, {})
vim.keymap.set("n", "<localleader>ff", require("telescope.builtin").current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<localleader>bt", require("telescope.builtin").current_buffer_tags, {})
vim.keymap.set("n", "<localleader>res", require("telescope.builtin").resume, {})
vim.keymap.set("n", "<localleader>p", require("telescope.builtin").pickers, {})
vim.keymap.set("n", "<localleader>r", require("telescope.builtin").lsp_references, {})
vim.keymap.set("n", "<localleader>ic", require("telescope.builtin").lsp_incoming_calls, {})
vim.keymap.set("n", "<localleader>oc", require("telescope.builtin").lsp_outgoing_calls, {})
vim.keymap.set("n", "<localleader>ds", require("telescope.builtin").lsp_document_symbols, {})
vim.keymap.set("n", "<localleader>wsd", function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols { file_ignore_patterns = { "node_modules/**" } }
end, {})
vim.keymap.set("n", "<localleader>ws", require("telescope.builtin").lsp_workspace_symbols, {})
vim.keymap.set("n", "<localleader>d", require("telescope.builtin").diagnostics, {})
vim.keymap.set("n", "<localleader>i", require("telescope.builtin").lsp_implementations, {})
vim.keymap.set("n", "<localleader>ld", require("telescope.builtin").lsp_definitions, {})
vim.keymap.set("n", "<localleader>td", require("telescope.builtin").lsp_type_definitions, {})
vim.keymap.set("n", "<localleader>gbc", require("telescope.builtin").git_commits, {})
vim.keymap.set("n", "<localleader>gc", require("telescope.builtin").git_bcommits, {})
vim.keymap.set("n", "<localleader>gb", require("telescope.builtin").git_branches, {})
vim.keymap.set("n", "<localleader>gs", require("telescope.builtin").git_status, {})
vim.keymap.set("n", "<localleader>gst", require("telescope.builtin").git_stash, {})
vim.keymap.set("n", "<localleader>t", require("telescope.builtin").treesitter, {})
