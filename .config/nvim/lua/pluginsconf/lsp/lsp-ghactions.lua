local M = {}
local util = require("lspconfig/util")

M.setup = function()
	local handlers = require("pluginsconf.lsp.lsp-common").handlers
	local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
	local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

	local opts = {
		handlers = handlers,
		capabilities = capabilities,
		on_attach = common_on_attach,
		root_dir = util.root_pattern(vim.fn.getcwd()),
		filetypes = { "yaml.gh" },
		-- root_dir = util.root_pattern(vim.fn.getcwd()),
		-- root_dir = util.root_pattern(".terraform", ".git"),
	}

	require("lspconfig").gh_actions_ls.setup(opts)
end

return M
