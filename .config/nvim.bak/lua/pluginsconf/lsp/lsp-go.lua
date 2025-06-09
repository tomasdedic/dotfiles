local M = {}
local util = require 'lspconfig/util'
M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach
  local handlers = require("pluginsconf.lsp.lsp-common").handlers

  local opts = {
    handlers = handlers,
    on_attach = common_on_attach,
    capabilities = capabilities,
    cmd = {"gopls"},
    filetypes = {"go","gomod","gowork","gotmpl"},
    root_dir = util.root_pattern("go.work","go.mod", ".git"),
    settings = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
    }
  }

  require("lspconfig").gopls.setup(vim.tbl_deep_extend("force", opts, {}))
end

return M
