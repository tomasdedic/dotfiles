local M = {}
local util = require 'lspconfig/util'

M.setup = function()
  vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

  local opts = {
    capabilities = capabilities,
    on_attach = common_on_attach,
    --root_dir = util.root_pattern(vim.fn.getcwd()),
    filetypes =  {"terraform"},
    cmd = { "terraform-ls", "serve", "-log-file", "/dev/null" },
    root_dir = util.root_pattern('*.tf', '*.tfvars'),
  }

  require("lspconfig").terraformls.setup(opts)
end

return M
