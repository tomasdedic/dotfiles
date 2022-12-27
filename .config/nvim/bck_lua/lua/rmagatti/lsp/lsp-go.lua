local M = {}
local util = require 'lspconfig/util'

M.setup = function()
  local capabilities = require("rmagatti.lsp.lsp-common").capabilities
  local common_on_attach = require("rmagatti.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    filetypes = {"go","gomod"};
    root_dir = util.root_pattern("go.mod", ".git");
  }

  require("lspconfig").gopls.setup(opts)
end

return M
