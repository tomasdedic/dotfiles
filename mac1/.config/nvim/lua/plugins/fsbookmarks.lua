return {
  {
    "tya5/fsbookmark.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      explorer = { enabled = true, key = "b" },
      icons = { bookmark = "*", broken = "!", global = "@", workspace = "~", shared = "+" },
      workspace = { enabled = true },
    },
    keys = {
      {
        "<leader>ma",
        function()
          require("fsbookmark").add()
        end,
        desc = "Add bookmark",
      },
      {
        "<leader>mf",
        function()
          require("fsbookmark").picker()
        end,
        desc = "Find bookmarks",
      },
      {
        "<leader>mt",
        function()
          require("fsbookmark").toggle()
        end,
        desc = "Toggle bookmark",
      },
      {
        "<leader>me",
        function()
          require("fsbookmark").edit()
        end,
        desc = "Edit bookmark",
      },
      {
        "<leader>mr",
        function()
          require("fsbookmark").remove()
        end,
        desc = "Remove bookmark",
      },
    },
  },
}
