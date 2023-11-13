-- local function cwd()
--   return vim.fn.getcwd()
-- end

require("lualine").setup {
  options = {
    theme = "tokyonight",
  disabled_filetypes = { 'toggleterm','packer'}
},
  extensions = { 'fzf', 'fugitive' },
  sections = {
    lualine_c = { require('auto-session.lib').current_session_name },
    lualine_a = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
  },
  winbar = {
    -- lualine_a = { {cwd} },
    lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 1 } },
    lualine_c = { { 'aerial', sep = ' ❯ ' } },
  },
  inactive_winbar = {
    lualine_b = { { 'filetype', icon_only = true }, { 'filename', path = 1 } },
  }
}
