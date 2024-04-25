-- Gp (GPT prompt) lua plugin for Neovim
-- https://github.com/Robitx/gp.nvim/

--------------------------------------------------------------------------------
-- Default config
--------------------------------------------------------------------------------

local config = {
	-- Please start with minimal config possible.
	-- Just openai_api_key if you don't have OPENAI_API_KEY env set up.
	-- Defaults change over time to improve things, options might get deprecated.
	-- It's better to change only things where the default doesn't fit your needs.

	-- required openai api key (string or table with command and arguments)
	-- openai_api_key = { "cat", "path_to/openai_api_key" },
	-- openai_api_key = { "bw", "get", "password", "OPENAI_API_KEY" },
	-- openai_api_key: "sk-...",
	-- openai_api_key = os.getenv("env_name.."),
	openai_api_key = os.getenv("OPENAI_API_KEY"),
	-- api endpoint (you can change this to azure endpoint)
	openai_api_endpoint = "https://openai.koudela.eu",
	-- openai_api_endpoint = "https://$URL.openai.azure.com/openai/deployments/{{model}}/chat/completions?api-version=2023-03-15-preview",
	-- prefix for all commands
	cmd_prefix = "Gp",
	-- optional curl parameters (for proxy, etc.)
	-- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
	curl_params = {},

	-- directory for persisting state dynamically changed by user (like model or persona)
	state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/persisted",

	-- default command agents (model + persona)
	-- name, model and system_prompt are mandatory fields
	-- to use agent for chat set chat = true, for command set command = true
	-- to remove some default agent completely set it just with the name like:
	-- agents = {  { name = "ChatGPT4" }, ... },
	agents = {
		{
			name = "ChatGPT4",
			chat = true,
			command = false,
			-- string with model name or table with model name and parameters
			model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are a general AI assistant.\n\n"
				.. "The user provided the additional info about how they would like you to respond:\n\n"
				.. "- If you're unsure don't guess and say you don't know instead.\n"
				.. "- Ask question if you need clarification to provide better answer.\n"
				.. "- Think deeply and carefully from first principles step by step.\n"
				.. "- Zoom out first to see the big picture and then zoom in to details.\n"
				.. "- Use Socratic method to improve your thinking and coding skills.\n"
				.. "- Don't elide any code from your output if the answer requires coding.\n"
				.. "- Take a deep breath; You've got this!\n",
		},
		{
			name = "ChatGPT3-5",
			chat = true,
			command = false,
			-- string with model name or table with model name and parameters
			model = { model = "gpt-3.5-turbo-1106", temperature = 1.1, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are a general AI assistant.\n\n"
				.. "The user provided the additional info about how they would like you to respond:\n\n"
				.. "- If you're unsure don't guess and say you don't know instead.\n"
				.. "- Ask question if you need clarification to provide better answer.\n"
				.. "- Think deeply and carefully from first principles step by step.\n"
				.. "- Zoom out first to see the big picture and then zoom in to details.\n"
				.. "- Use Socratic method to improve your thinking and coding skills.\n"
				.. "- Don't elide any code from your output if the answer requires coding.\n"
				.. "- Take a deep breath; You've got this!\n",
		},
		{
			name = "CodeGPT4",
			chat = false,
			command = true,
			-- string with model name or table with model name and parameters
			model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are an AI working as a code editor.\n\n"
				.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
				.. "START AND END YOUR ANSWER WITH:\n\n```",
		},
		{
			name = "CodeGPT3-5",
			chat = false,
			command = true,
			-- string with model name or table with model name and parameters
			model = { model = "gpt-3.5-turbo-1106", temperature = 0.8, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are an AI working as a code editor.\n\n"
				.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
				.. "START AND END YOUR ANSWER WITH:\n\n```",
		},
	},

	-- directory for storing chat files
}

return config
