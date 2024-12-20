-- local function cwd()
--   return vim.fn.getcwd()
-- end

require("lualine").setup({
	options = {
		theme = "catppuccin-macchiato",
		disabled_filetypes = { "toggleterm", "packer" },
	},
	extensions = { "fzf", "fugitive" },
	sections = {

		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
			},
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
			{
				"branch",
				color = { bg = "yellow" },
			},
		},
		lualine_b = {
			{
				function()
					return require("grapple").name_or_index()
				end,
				cond = function()
					return package.loaded["grapple"] and require("grapple").exists()
				end,
			},
		},
		lualine_c = {
			{
				require("auto-session.lib").current_session_name,
				color = { fg = "indianred", bg = "black", gui = "bold" },
				sep = " ❯ ",
			},
		},
		lualine_x = { { require("yaml_nvim").get_yaml_key, color = { fg = "grey53" } } },
		lualine_y = { "filetype" },
	},
	winbar = {
		lualine_a = { { "filename", path = 1 } },
		lualine_x = {
			{
				function()
					return vim.fn.getcwd()
				end,
				color = { fg = "indianred", gui = "bold" },
			},
		},
		-- lualine_b = { { require("yaml_nvim").get_yaml_key, color = { fg = "grey53" } } },
	},
	inactive_winbar = {
		lualine_a = { { "filename", path = 1 } },
	},
})
