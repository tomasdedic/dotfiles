return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>m", group = "bookmarks", icon = "*" },
        { "<leader>t", group = "terminal", icon = ">", mode = { "n", "x" } },
        { "<leader>j", group = "molten", icon = "#", mode = { "n", "v" } },
      },
    },
  },
}
