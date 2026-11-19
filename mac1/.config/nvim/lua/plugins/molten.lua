-- Interactive code with a Jupyter kernel. Cells are "# %%" blocks in a .py file.
-- Python split: nvim host = ~/.venvs/nvim (pynvim, jupyter_client), kernel = repo venv.
return {
  {
    "benlubas/molten-nvim",
    version = "^1", -- stay below v2, the API breaks there
    -- Loaded at startup, not on ft/event. It is a python3 rplugin: if it is not on the runtimepath
    -- when :UpdateRemotePlugins runs, the manifest drops it and no Molten command ever exists.
    lazy = false,
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    init = function()
      -- Ghostty speaks the kitty protocol, so image.nvim is the only usable provider in tmux.
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 15
      vim.g.molten_virt_text_output = true
      vim.g.molten_wrap_output = true
      -- image only in the virtual text, not in the float too
      vim.g.molten_image_location = "virt" -- needs virt_text_output = true
      -- no float when the cursor enters a cell; ,jo still opens it
      vim.g.molten_auto_open_output = false
    end,
    keys = {
      {
        "<leader>ji",
        function()
          local root = LazyVim.root()
          local name = vim.fn.fnamemodify(root, ":t")
          if vim.fn.isdirectory(root .. "/.venv") == 0 then
            name = "python3" -- no repo venv, use the global kernel
          end
          vim.cmd("MoltenInit " .. name)
        end,
        desc = "Molten: init kernel for repo",
      },
      { "<leader>jI", "<cmd>MoltenInit<cr>", desc = "Molten: pick kernel" },
      { "<leader>jl", "<cmd>MoltenEvaluateLine<cr>", desc = "Molten: run line" },
      { "<leader>jr", "<cmd>MoltenReevaluateCell<cr>", desc = "Molten: rerun cell" },
      { "<leader>jv", ":<C-u>MoltenEvaluateVisual<cr>gv", mode = "v", desc = "Molten: run selection" },
      { "<leader>jn", "<cmd>MoltenNext<cr>", desc = "Molten: next cell" },
      { "<leader>jp", "<cmd>MoltenPrev<cr>", desc = "Molten: previous cell" },
      { "<leader>jo", "<cmd>noautocmd MoltenEnterOutput<cr>", desc = "Molten: enter output" },
      { "<leader>jh", "<cmd>MoltenHideOutput<cr>", desc = "Molten: hide output" },
      { "<leader>jd", "<cmd>MoltenDelete<cr>", desc = "Molten: delete cell" },
      { "<leader>jq", "<cmd>MoltenInterrupt<cr>", desc = "Molten: interrupt kernel" },
      { "<leader>jx", "<cmd>MoltenExportOutput<cr>", desc = "Molten: export to .ipynb" },
    },
  },

  -- Inline image backend for molten. Needs the luarocks module:
  --   luarocks install --lua-version=5.1 --local image.nvim
  -- plus the package.path/cpath lines in lua/config/options.lua for --local rocks.
  {
    "3rd/image.nvim",
    build = false,
    opts = {
      backend = "kitty",
      processor = "magick_cli",
      max_width = 120,
      max_height = 25,
    },
  },
}
