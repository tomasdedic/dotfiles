local M = {}
local util = require 'lspconfig/util'

M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach
  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    cmd = { "helm_ls", "serve" },
    filetypes =  {"helm"},
    root_dir = function(fname)
      return util.root_pattern('Chart.yaml')(fname)
    end,
    }
  require("lspconfig").helm_ls.setup(opts)
end

return M
