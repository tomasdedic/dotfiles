--add completion from all buffers
return {
  {
    "saghen/blink.cmp",
    opts = {
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
