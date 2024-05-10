local M = {}

M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      },
    },
  }

  require("lspconfig").lua_ls.setup(vim.tbl_deep_extend("force", opts, {}))
end

return M
