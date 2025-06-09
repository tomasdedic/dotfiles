function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

local map = vim.keymap.set

map("n", "<leader>fg", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_ivy())
end, { desc = "telescope fzfBuffer" })

-- map("n", ";", "<cmd>lua require('telescope.builtin').buffers({sort_mru=true})<CR>", { desc = "telescope buffers" })
map("n", ";", function()
	require("telescope.builtin").buffers({ sort_mru = true,previewer = false  })
end, { desc = "telescope buffers" })

map("n", "<leader>gf", function()
	require("telescope.builtin").git_files()
end, { desc = "telescope gitFiles" })

map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "telescope findFiles" })

map("n", "<leader>po", function()
	require("telescope.builtin").live_grep({ grep_open_files = true })
end, { desc = "telescope grepOpenFiles" })

map("v", "<leader>po", function()
	local text = vim.getVisualSelection()
	require("telescope.builtin").live_grep({ grep_open_files = true, default_text = text })
end, { desc = "telescope grepOpenFilesVisual" })

-- all files in cwd
map("n", "<leader>ps", function()
	require("telescope.builtin").live_grep()
end, { desc = "telescope filesCWD" })

map("v", "<leader>ps", function()
	local text = vim.getVisualSelection()
	require("telescope.builtin").live_grep({ default_text = text })
end, { desc = "telescope filesCWDVisual" })

-- only active buffer
map("n", "<leader>pg", function()
	require("telescope.builtin").grep_string()
end, { desc = "telescope grepString" })

map("v", "<leader>pg", function()
	local text = vim.getVisualSelection()
	require("telescope.builtin").current_buffer_fuzzy_find({ default_text = text })
end, { desc = "telescope fzfBufferVisual" })

map("n", "<C-b>", require("telescope.builtin").git_branches, { desc = "telescope gitBranches" })
map("n", "<localleader>of", function()
	require("telescope.builtin").oldfiles()
end, { desc = "telescope oldFiles" })
map("n", "<localleader>cm", require("telescope.builtin").commands, { desc = "telescope commands" })
map("n", "<localleader>tgs", require("telescope.builtin").tags, { desc = "telescope tags" })
map("n", "<localleader>cmh", require("telescope.builtin").command_history, { desc = "telescope commandHistory" })
map("n", "<localleader>sh", require("telescope.builtin").search_history, { desc = "telescope searchHistory" })
map("n", "<localleader>ht", require("telescope.builtin").help_tags, {})
map("n", "<localleader>mp", require("telescope.builtin").man_pages, {})
map("n", "<localleader>ma", require("telescope.builtin").marks, { desc = "telescope marks" })
-- map("n", "<localleader>cs", require("telescope.builtin").colorscheme, {})
map("n", "<localleader>qf", require("telescope.builtin").quickfix, {})
map("n", "<localleader>qfh", require("telescope.builtin").quickfixhistory, {})
map("n", "<localleader>ll", require("telescope.builtin").loclist, {})
map("n", "<localleader>jl", require("telescope.builtin").jumplist, { desc = "telescope jumpList" })
map("n", "<localleader>vo", require("telescope.builtin").vim_options, { desc = "telescope vimOptions" })
map("n", "<localleader>re", require("telescope.builtin").registers, { desc = "telescope registers" })
map("n", "<localleader>ac", require("telescope.builtin").autocommands, { desc = "telescope autoCmd" })
-- map("n", "<localleader>ss", require("telescope.builtin").spell_suggest, {})
map("n", "<localleader>km", require("telescope.builtin").keymaps, { desc = "telescope keyMaps" })
-- map("n", "<localleader>ft", require("telescope.builtin").filetypes, {})
-- map("n", "<localleader>hl", require("telescope.builtin").highlights, {})
-- map("n", "<localleader>ff", require("telescope.builtin").current_buffer_fuzzy_find, {})
-- map("n", "<localleader>bt", require("telescope.builtin").current_buffer_tags, {})
map("n", "<localleader>r", require("telescope.builtin").lsp_references, { desc = "telescope lspReference" })
-- map("n", "<localleader>ic", require("telescope.builtin").lsp_incoming_calls, {})
-- map("n", "<localleader>oc", require("telescope.builtin").lsp_outgoing_calls, {})
map("n", "<localleader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "telescope lspSymbols" })
map("n", "<localleader>ws", function()
	require("telescope.builtin").lsp_dynamic_workspace_symbols({ file_ignore_patterns = { "node_modules/**" } })
end, { desc = "telescope lspWorkspaceSympols" })
-- map("n", "<localleader>ws", require("telescope.builtin").lsp_workspace_symbols, {})
map("n", "<localleader>d", require("telescope.builtin").diagnostics, { desc = "telescope diagnostics" })
map("n", "<localleader>i", require("telescope.builtin").lsp_implementations, { desc = "telescope lspImplementation" })
map("n", "<localleader>ld", require("telescope.builtin").lsp_definitions, { desc = "telescope lspDefinition" })
map("n", "<localleader>td", require("telescope.builtin").lsp_type_definitions, { desc = "telescope lspTypedefinition" })
map("n", "<localleader>gbc", require("telescope.builtin").git_commits, { desc = "telescope gitCommits" })
map("n", "<localleader>gc", require("telescope.builtin").git_bcommits, { desc = "telescope gitBcommits" })
map("n", "<localleader>gb", require("telescope.builtin").git_branches, { desc = "telescope gitBranches" })
map("n", "<localleader>gs", require("telescope.builtin").git_status, { desc = "telescope gitStatus" })
-- map("n", "<localleader>gst", require("telescope.builtin").git_stash, {})
map("n", "<localleader>t", require("telescope.builtin").treesitter, { desc = "telescope treesitter" })
