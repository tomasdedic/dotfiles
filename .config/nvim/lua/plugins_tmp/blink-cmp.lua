--  Key                        Action
--  <C-space>  show, show_documentation, hide_documentation
--  <C-e>      hide, fallback
--  <C-y>      select_and_accept
--  <C-p>      select_prev
--  <C-n>      select_next
--  <Up>       select_prev, fallback
--  <Down>     select_next, fallback
--  <C-b>      scroll_documentation_up
--  <C-f>      scroll_documentation_down
--  <Tab>      snippet_forward, fallback
--  <S-Tab>    snippet_backward, fallback
--  <C-k>      show_signature, hide_signature, fallback

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
