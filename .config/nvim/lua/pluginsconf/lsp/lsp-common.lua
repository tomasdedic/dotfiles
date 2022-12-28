local mappings = require "pluginsconf.lsp.lsp-mappings"
local signature = require "pluginsconf.lsp.lsp-signature"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

--- function already defines common mappings and `lsp_signature.nvim`
-- @param client the lsp client
-- @param bufnr the buffer number
local common_on_attach = function(client, bufnr)
  mappings.on_attach(client, bufnr)
  signature.on_attach()
end

local M = {
  common_on_attach = common_on_attach,
  mappings = mappings,
  signature = signature,
  capabilities = capabilities,
}

return M

