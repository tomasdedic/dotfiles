return {
  {
    {
      "ThePrimeagen/harpoon",
      enabled = false,
      branch = "harpoon2",
      opts = {
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      },
    },
    -- {
    --   "frenchef156/harpoon-lists.nvim",
    --   dependencies = {
    --     {
    --       "ThePrimeagen/harpoon",
    --       branch = "harpoon2",
    --     },
    --     "nvim-lua/plenary.nvim",
    --   },
    --   config = function()
    --     local harpoonLists = require("harpoon-lists")
    --
    --     -- REQUIRED
    --     harpoonLists:setup()
    --
    --     -- Add keymaps here. Use harpoonLists instead of the harpoon object --
    --   end,
    -- },
  },
}
