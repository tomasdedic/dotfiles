local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}
return opts


--local null_ls = require "null-ls"
--local b = null_ls.builtins


--local eslint_opts = {
--  -- condition = function(utils)
--  --   return utils.root_has_file ".eslintrc.js" or utils.root_has_file ".eslintrc" or utils.root_has_file ".eslintrc.json"
--  -- end,
--  -- diagnostics_format = "#{m} [#{c}]",
--  prefer_local = true,
--}

--local sources = {
--  b.formatting.prettierd.with {
--    prefer_local = true,
--  },
--  -- b.formatting.rome.with {
--  --   prefer_local = true,
--  -- },
--  b.diagnostics.eslint_d.with(eslint_opts),
--  b.code_actions.eslint_d.with(eslint_opts),
--  b.formatting.stylua,
--  b.formatting.trim_whitespace.with { filetypes = { "tmux", "teal", "zsh" } },
--  -- b.formatting.shfmt,
--  -- b.diagnostics.write_good,
--  -- b.diagnostics.markdownlint,
--  -- b.diagnostics.teal,
--  -- b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
--  -- b.code_actions.gitsigns,
--  -- b.code_actions.gitrebase,
--  b.hover.dictionary,
--  --golang
--  b.formatting.gofmt,
--  b.formatting.goimports_reviser,
--  -- b.formatting.golines
--}

--local M = {}

--M.setup = function()
--  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--  require("null-ls").setup {
--    sources = sources,
--    debug = false,
--    on_attach = function(client, bufnr)
--      if client.support_method("textDocument/formatting") then
--        vim.api.nvim_clear_autocmds({
--          group =augroup,
--          buffer = bufnr,
--        })
--        vim.api.nvim_create_augroup("BufWritePre", {
--          group = augroup,
--          buffer = bufnr,
--          callback = function()
--            vim.lsp.buf.format({bufnr =bufnr})
--          end,
--        })
--      end
--    end,
--  }
--end

--return M
