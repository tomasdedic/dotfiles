" automacommand for lint
au BufWritePost <buffer> lua require('lint').try_lint()

lua <<EOF
require('lint').linters_by_ft = {
  yaml = {'yamllint'},
  sh = {'shellcheck'},
  markdown = {'markdownlint'}

}
EOF

