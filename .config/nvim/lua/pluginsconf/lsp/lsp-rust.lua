local M = {}

M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  require("lspconfig").rust_analyzer.setup(vim.tbl_deep_extend("force", opts, {}))
end

return M
