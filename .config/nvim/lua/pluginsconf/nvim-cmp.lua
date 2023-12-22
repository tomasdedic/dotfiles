vim.o.completeopt = "menu,menuone,noselect,noinsert"

-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
--     return false
--   end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
-- end
local cmp = require "cmp"
local lspkind = require "lspkind"
local mapping = cmp.mapping.preset.insert {
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-x>"] = cmp.mapping.complete {},
  ["<C-e>"] = cmp.mapping.close(),
  ["<CR>"] = cmp.mapping.confirm { select = true },
  -- ["<C-p>"] = cmp.mapping.select_prev_item(),
  -- ["<C-n>"] = cmp.mapping.select_next_item(),
  ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
  ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
  -- Disabled tab because of copilot conflict on tab
  -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
  -- ["<Tab>"] = vim.schedule_wrap(function(fallback)
  --   if cmp.visible() and has_words_before() then
  --     cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
  --   else
  --     fallback()
  --   end
  -- end),
}

cmp.setup {
   enabled = function ()
        buftype = vim.api.nvim_get_option_value("buftype",{ buf = 0})
        if buftype == "prompt" then return false end
        if buftype == "chatgpt-input" then return false end

        local context = require 'cmp.config.context'
		-- disable autocompletion in comments 
     		return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
    end,

  formatting = {
    format = function(entry, vim_item)
      if entry.source.name == "copilot" then
        vim_item.kind = "[] Copilot"
        vim_item.kind_hl_group = "CmpItemKindCopilot"
        return vim_item
      end
      if entry.source.name == "codeium" then
        vim_item.kind = "[🜘]"
        vim_item.kind_hl_group = "CmpItemKindCopilot"
        return vim_item
      end
      if entry.source.name == "rg" then
        vim_item.kind = "RG"
        vim_item.kind_hl_group = "CmpItemKindRg"
        return vim_item
      end
      -- return lspkind.cmp_format { with_text = true, maxwidth = 50 }(entry, vim_item)
      return vim_item
    end,
  },
  -- formatting = {
  --   format = lspkind.cmp_format {
  --     mode = "text,symbol",
  --     max_width = 50,
  --     symbol_map = { 
  --       Copilot = "",
  --       Codeium = "🜘",
  --   },
  --   },
  -- },
  -- snippet = {
  --   expand = function(args)
  --     -- vim.fn["vsnip#anonymous"](args.body)
  --     require("luasnip").lsp_expand(args.body)
  --   end,
  -- },
  experimental = {
    ghost_text = true ,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
            },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = mapping,
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
    -- { name = "luasnip" },
    { name = "path" },
    -- { name = "npm", keyword_length = 4 },
    { name = "codeium", keyword_length = 3, group_index = 2 },
    { name = "rg", keyword_length = 3, group_index = 2 },
    { name = "path" },
  }, {
    { name = "buffer",
      -- load completition from all openbuffers but in init.vim set hidden must be set instead of set nohidden(bufer get offloaded)
       option = {
         get_bufnrs = function()
           return vim.api.nvim_list_bufs()
         end
           }
  },
  }),
}
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#6CC644" })
  

-- cmp.setup.filetype("lua", {
--   sources = cmp.config.sources {
--     { name = "nvim_lsp" },
--     -- { name = "nvim_lua" },
--   },
-- })

-- cmp.setup.cmdline("/", {
--   sources = {
--     { name = "buffer" },
--   },
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
