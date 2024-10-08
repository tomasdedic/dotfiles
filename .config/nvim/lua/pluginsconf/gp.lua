local wk = require("which-key")
wk.add({
	{
		{ "<localleader>c", group = "GPT" },
		-- { "<localleader>cs", "<cmd>GpChatToggle popup<cr>", desc = "Toggle Chat" },
		{ "<localleader>cs", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
		-- { "<localleader>cn", "<cmd>GpChatNew popup<cr>", desc = "New Chat" },
		{ "<localleader>cn", "<cmd>GpChatNew<cr>", desc = "New Chat" },
		{ "<localleader>cr", "<cmd>GpChatRespond <cr>", desc = "Respond" },
	},
}, { mode = "n" })

local M = {}
-- https://github.com/Robitx/gp.nvim/blob/a88225e90f22acdbc943079f8fa5912e8c101db8/lua/gp/config.lua#L10-L607
function M.setup()
	require("gp").setup({
		cmd_prefix = "Gp",
		curl_params = {},
		default_command_agent = nil,
		default_chat_agent = nil,
		-- directory for persisting state dynamically changed by user (like model or persona)
		providers = {
			openai = {
				disable = true,
				endpoint = "https://api.openai.com/v1/chat/completions",
				secret = os.getenv("OPENAI_API_KEY"),
			},
			copilot = {
				disable = false,
				endpoint = "https://api.githubcopilot.com/chat/completions",
				secret = {
					"bash",
					"-c",
					"cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
				},
			},
		},
		-- agents = {
		-- 	{
		-- 		provider = "copilot",
		-- 		name = "ChcatCopilot",
		-- 		chat = true,
		-- 		command = false,
		-- 		model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
		-- 		system_prompt = require("gp.defaults").chat_system_prompt,
		-- 	},
		-- },
	})
end

return M
