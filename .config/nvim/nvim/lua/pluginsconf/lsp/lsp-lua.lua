local M = {}

M.setup = function()
  local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
  local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

  require("neodev").setup {}

  local sumneko_lua_opts = {
    on_attach = common_on_attach,
    capabilities = capabilities,
    settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
      },
      telemetry = {
        enable = false,
      },
    },
  },
  }

  require("lspconfig").sumneko_lua.setup(vim.tbl_deep_extend("force", sumneko_lua_opts, {}))
end

return M
