local ft = require('Comment.ft')

-- 1. Using set function

ft
  -- set both line and block commentstring
 .set('hcl', {'#%s', '/*%s*/'})
 -- Or set both line and block commentstring
 -- .set('javascript', {'//%s', '/*%s*/'})

require("Comment").setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

