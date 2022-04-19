lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
  window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-x>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
       { name = "buffer",
         -- load completition from all openbuffers but in init.vim set hidden must be set instead of set nohidden(bufer get offloaded)
          option = {
          -- Default: [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%([\-.]\w*\)*\)]]
          -- A vim's regular expression for creating a word list from buffer content.
          -- You can set this to \k\+ if you want to use the iskeyword option for recognizing words.
          --  keyword_pattern = [[\k\+]],
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
              }
        },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
 -- cmp.setup.cmdline('/', {
 --   sources = {
 --     { name = 'buffer' }
 --   }
 -- })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  --require('lspconfig')('terraformls').setup {
  --  capabilities = capabilities
  --}
EOF
