require("auto-session").setup({
	log_level = vim.log.levels.ERROR,
	-- auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
	use_git_branch = false,
	auto_restore_last_session = false,
	enabled = false,

	-- session_lens = {
	--   load_on_setup = true,
	-- theme_conf = { border = true },
	-- previewer = false,
	-- },
})

vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
	noremap = true,
})
