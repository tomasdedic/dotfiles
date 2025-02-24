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
				path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
			{
				"branch",
				color = { bg = "yellow" },
			},
			{
				function()
					local msg = ""
					local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
					local clients = vim.lsp.get_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = "",
				color = { fg = "grey53" },
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
				-- color = { fg = "indianred", bg = "black", gui = "bold" },
				color = { fg = "indianred", bg = "black" },
				sep = " ❯ ",
			},
		},
		lualine_x = {
			-- { require("yaml_nvim").get_yaml_key, color = { fg = "grey53" } },
			{
				function()
					local msg = ""
					local yaml = vim.api.nvim_get_option_value("filetype", { buf = 0 })
					if yaml ~= "yaml" then
						return msg
					else
						msg = require("yaml_nvim").get_yaml_key()
						return msg
					end
				end,
				color = { fg = "grey53" },
			},
		},
		lualine_y = { "filetype" },
	},
	winbar = {
		lualine_a = { { "filename", path = 1 } },
		lualine_x = {
			{
				function()
					return vim.fn.substitute(vim.fn.getcwd(), vim.env.HOME, "~", "")
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
