local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

require("mason").setup {
  providers = {
    "mason.providers.client",
    "mason.providers.registry-api",
  }
}
require("mason-lspconfig").setup {}
-- require("nvim-lsp-installer").setup {}
require("pluginsconf.lsp.lsp-lua").setup()
-- require("pluginsconf.lsp.lsp-typescript").setup()
require("pluginsconf.lsp.lsp-yaml").setup()
require("pluginsconf.lsp.lsp-json").setup()
require("pluginsconf.lsp.lsp-vimscript").setup()
require("pluginsconf.lsp.lsp-go").setup()
-- require("pluginsconf.lsp.lsp-terraform").setup()
require("pluginsconf.lsp.lsp-bash").setup()
require("pluginsconf.lsp.tflint").setup()


-- require("pluginsconf.lsp.null-ls").setup(common_on_attach)

