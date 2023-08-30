vim.cmd [[
  let g:deepl#endpoint = "https://api-free.deepl.com/v2/translate"
  let g:deepl#auth_key = "954c193c-74f6-d530-0508-6ca8863fca0d:fx"

  " replace a visual selection
  vmap t<C-e> <Cmd>call deepl#v("CS", "EN")<CR>
  vmap t<C-r> <Cmd>call deepl#v("EN", "CS")<CR>

  " translate a current line and display on a new line
  " nmap t<C-e> yypV<Cmd>call deepl#v("EN")<CR>

  " specify the source language
  " translate from FR to EN
  nmap t<C-e> yypV<Cmd>call deepl#v("CS", "EN")<CR>
  nmap t<C-r> yypV<Cmd>call deepl#v("EN", "CS")<CR>
]]
