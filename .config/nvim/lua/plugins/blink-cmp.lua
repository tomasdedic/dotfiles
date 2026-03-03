--add completion from all buffers
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<M-x>"] = { "show", "fallback" },
        ["<CR>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.accept()
            end
          end,
          "fallback",
        },
      },
      completion = {
        list = {
          selection = {
            auto_insert = true,
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          buffer = {
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(buf)
                  return vim.bo[buf].buflisted
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
        },
      },
    },
  },
}
