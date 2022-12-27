local M = {}
local util = require 'lspconfig/util'

M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

  local opts = {
    capabilities = capabilities,
    on_attach = common_on_attach,
    root_dir = util.root_pattern(vim.fn.getcwd()),
    filetypes =  {"terraform"},
    cmd = { "terraform-ls", "serve", "-log-file", "/dev/null" },
    -- root_dir = util.root_pattern(".terraform", ".git"),
  }

  require("lspconfig").terraformls.setup(opts)
end

return M
