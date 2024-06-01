local M = {}

M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

  local opts = vim.tbl_deep_extend("force", {}, {
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      formatting = true,
    }),
    on_attach = function(client, bufnr)
      common_on_attach(client, bufnr)
    end,
    filetypes = { "json", "jsonc" },
    settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
  })

  require("lspconfig").jsonls.setup(opts)
end

return M
