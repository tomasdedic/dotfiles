require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"yaml",
		"terraform",
		"bash",
		"json",
		"git_config",
		"git_rebase",
		"gitignore",
		"gitcommit",
		"vimdoc",
		"vim",
		"markdown",
		"hcl",
		"query",
	},

	sync_install = true,
	ignore_install = {},
	modules = {},
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
