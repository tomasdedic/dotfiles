-- require("lazydev").setup()
-- require("mason").setup()
-- require("mason-lspconfig").setup()

require("pluginsconf.lsp.lsp-lua").setup()
-- require("pluginsconf.lsp.lsp-typescript").setup()
require("pluginsconf.lsp.lsp-yaml").setup()
require("pluginsconf.lsp.lsp-json").setup()
-- require("pluginsconf.lsp.lsp-vimscript").setup()
-- require("pluginsconf.lsp.lsp-rust").setup()
-- require("pluginsconf.lsp.lsp-prisma").setup()
-- require("pluginsconf.lsp.lsp-python").setup()
require("pluginsconf.lsp.lsp-bash").setup()
require("pluginsconf.lsp.tflint").setup()
require("pluginsconf.lsp.lsp-go").setup()
require("pluginsconf.lsp.lsp-terraform").setup()
require("pluginsconf.lsp.lsp-helm").setup()
require("pluginsconf.lsp.lsp-markdown").setup()
require("pluginsconf.lsp.lsp-ghactions").setup()

vim.diagnostic.config({
	virtual_text = true, -- Show inline error/warning messages
	signs = true, -- Show signs in the gutter
	underline = true, -- Underline problematic code
	update_in_insert = false,
})
