local M = {}
local util = require 'lspconfig/util'

M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    cmd = {"gopls"},
    filetypes = {"go","gomod","gowork","gotmpl"},
    root_dir = util.root_pattern("go.work","go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported =true,
        usePlaceholders =true,
        analyses = {
          unusedparams = true,
        }
      }
    }
  }

  require("lspconfig").gopls.setup(opts)
end

return M
