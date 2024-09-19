local actions = require("telescope.actions")
local data = assert(vim.fn.stdpath("data")) --[[@as string]]

-- select multiple records and send them to buffers
local select_one_or_multi = function(prompt_bufnr)
	local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()
	if not vim.tbl_isempty(multi) then
		require("telescope.actions").close(prompt_bufnr)
		for _, j in pairs(multi) do
			if j.path ~= nil then
				vim.cmd(string.format("%s %s", "edit", j.path))
			end
		end
	else
		require("telescope.actions").select_default(prompt_bufnr)
	end
end

-- select multiple records and send them to quickfix
local smart_send_to_qflist = function(prompt_bufnr)
	local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()
	if not vim.tbl_isempty(multi) then
		actions.send_selected_to_qflist(prompt_bufnr)
	else
		actions.send_to_qflist(prompt_bufnr)
	end
	actions.open_qflist(prompt_bufnr)
end

require("telescope").setup({
	pickers = {
		buffers = {
			ignore_current_buffer = true,
			sort_lastused = true,
			layout_config = {
				preview_cutoff = 200,
			},
		},
		jumplist = {
			layout_config = {
				preview_cutoff = 200,
			},
		},
	},
	defaults = {
		-- vimgrep_arguments = {
		-- 	"rg",
		-- 	"--color=never",
		-- 	"--no-heading",
		-- 	"--with-filename",
		-- 	"--line-number",
		-- 	"--column",
		-- 	"--smart-case",
		-- },
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "vertical",
		layout_config = {
			horizontal = {
				prompt_position = "bottom",
				preview_width = 0.55,
				result_width = 0.8,
				-- mirror = false,
			},
			vertical = {
				mirror = false,
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.60,
			preview_cutoff = 40,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		mappings = {
			i = {
				-- Close on first esc instead of going to normal mode
				["<esc>"] = actions.close,
				["<C-p>"] = require("telescope.actions").cycle_history_next,
				["<C-o>"] = require("telescope.actions").cycle_history_prev,
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-w>"] = "which_key",
				["<C-d>"] = require("telescope.actions").delete_buffer,
				["<Tab>"] = require("telescope.actions").toggle_selection,
				["<CR>"] = select_one_or_multi,
				["<C-q>"] = smart_send_to_qflist,

				-- ["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
				-- ["<C-w>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
			},
			n = {
				["<C-d>"] = require("telescope.actions").delete_buffer,
				["<C-q>"] = smart_send_to_qflist,
			}, -- normal
		},
		extensions = {
			wrap_results = true,
			fzf = {
				fuzzy = true,
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
			history = {
				path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
				limit = 100,
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

require("pluginsconf.telescope.buffers").setup()
require("pluginsconf.telescope.mappings")
