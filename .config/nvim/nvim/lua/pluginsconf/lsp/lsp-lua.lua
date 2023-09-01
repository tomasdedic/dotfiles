local M = {}

M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

  require("neodev").setup {}

  local lua_ls_opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
  }

  require("lspconfig").lua_ls.setup(vim.tbl_deep_extend("force", lua_ls_opts, {}))
end

return M
