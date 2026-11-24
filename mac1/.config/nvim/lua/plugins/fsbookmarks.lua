return {
  {
    "tomasdedic/fsbookmark.nvim",
    -- dir = "~/GIT/moje/fsbookmark.nvim", -- local checkout; remove to use GitHub
    dependencies = { "folke/snacks.nvim" },
    opts = {
      -- b/B are mapped in the snacks explorer config instead: b cycles the scope, B filters
      explorer = { enabled = true, key = false, global_key = false },
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
