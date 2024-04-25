vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_json_frontmatter = 1
vim.g.vim_markdown_auto_insert_bullets = 0
vim.g.vim_markdown_new_list_item_indent = 0
vim.g.vim_markdown_toc_autofit = 1
vim.g.vim_markdown_folding_level = 3
-- vim.g.indentLine_conceallevel = 2
-- nastaveni chovani kurzoru pri prejeti prez specialni tagy
--  set concealcursor="nv"
--  vim.g.indentLine_concealcursor = "nv"
-- vim.g.indentLine_concealcursor = "inc"
-- vim.g.indentLine_char_list = "['|', '¦', '┆', '┊']"
vim.g.vim_markdown_conceal_code_blocks = 0
-- vim.g.vim_markdown_conceal = 2
vim.cmd [[
autocmd FileType markdown set ts=2 sts=2 sw=2 expandtab
]]
