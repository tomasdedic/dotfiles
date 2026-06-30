return {

  {
    {
      "cbochs/grapple.nvim",
      opts = {
        scope = "global", -- also try out "git_branch"
        icons = false, -- setting to "true" requires "nvim-web-devicons"
        status = false,
      },
      keys = {
        { "<leader>H", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
        { "<leader>h", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
        { "<leader>a", "<cmd>Grapple toggle_scopes<cr>", desc = "Toggle scopes" },

        -- { "<c-h>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
        -- { "<c-t>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
        -- { "<c-n>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
        -- { "<c-s>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },
        --
        -- { "<c-s-n>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
        -- { "<c-s-p>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
      },
    },
  },
}
