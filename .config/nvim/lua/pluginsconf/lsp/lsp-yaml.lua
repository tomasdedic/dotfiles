local M = {}
local util = require 'lspconfig/util'

M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

  local opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    -- cmd = { "yaml-language-server", "--stdio" },
    root_dir = util.root_pattern(vim.fn.getcwd()),
    filetypes =  {"yaml"},
    settings = {
      yaml = {
       trace = {
         server = "on",
       },
        format = {
          enable = true,
          singleQuote = false,
          bracketSpacing = true,
        },
        schemas = {
          -- https://www.schemastore.org/api/json/catalog.json
         -- ["https://openshiftjsonschema.dev/v4.9.18-standalone/all.json"] = "*.yaml",
          ["kubernetes"] = "/*",
          -- ["http://json.schemastore.org/kustomization"] = "kustomization.yaml",
          -- ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/v1.174.2/service-schema.json"] = "pipelines/*.yaml"
          -- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.0/all.json"] = "/*.yaml"
        },
      	validate = true,
        completion = true,
        hover = true,

      }
    }
  }

  require("lspconfig").yamlls.setup(opts)
  -- vim.lsp.set_log_level("trace")
end

return M

