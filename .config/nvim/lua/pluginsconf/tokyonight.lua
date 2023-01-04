-- -- Example config in Lua
-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "terminal", "plug" }
--
-- if vim.g.neovide then
--   vim.g.tokyonight_dark_float = false
-- end
--
-- -- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- -- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
--
-- vim.cmd [[colorscheme tokyonight]]
require("tokyonight").setup({
style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  -- light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help","packer","terminal" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.2, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
     on_colors = function(colors)
      colors.border = "#565f89"
      end,
})
vim.cmd [[colorscheme tokyonight]]
