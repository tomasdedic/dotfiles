-- Terminal mode tag for the winbar: T terminal (insert) mode, N Normal mode.
-- The focused window shows the live mode. Other terminal windows show the mode you left them in,
-- which is also the mode you get when you go back (see the WinLeave/WinEnter autocmds).
local function term_tag(focused)
  return {
    function()
      local normal
      if focused then
        normal = vim.fn.mode() ~= "t"
      else
        normal = vim.b.term_left_normal == true
      end
      return normal and "N" or "T"
    end,
    cond = function()
      return vim.bo.buftype == "terminal"
    end,
  }
end

-- winbar: "T term://1" for terminals (no [-] modifiable mark), the relative path otherwise
local function winbar_a(focused)
  local function is_term()
    return vim.bo.buftype == "terminal"
  end
  return {
    term_tag(focused),
    { "filename", path = 1, file_status = false, cond = is_term },
    {
      "filename",
      path = 1,
      cond = function()
        return not is_term()
      end,
    },
  }
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {

        options = {
          theme = "catppuccin-macchiato",
          disabled_filetypes = { winbar = { "snacks_picker_list", "toggleterm", "packer", "qf" } },
          globalstatus = true,
        },
        extensions = { "fzf", "fugitive" },
        sections = {

          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
            -- {
            --   function()
            --     return vim.fn.substitute(LazyVim.root(), vim.env.HOME, "~", "")
            --   end,
            --   color = { bg = "indianred" },
            -- },
            -- {
            --   "filename",
            --   file_status = true,
            --   path = 0,
            -- },
            {
              function()
                local cwd = vim.fn.getcwd()
                local cache = vim.g._lualine_remote_cache or {}
                if not cache[cwd] then
                  local remote = vim.fn.system("git remote get-url origin 2>/dev/null"):gsub("%s+$", "")
                  cache[cwd] = remote ~= "" and ((remote:match("([^/]+)$") or ""):gsub("%.git$", "")) or ""
                  vim.g._lualine_remote_cache = cache
                end
                return cache[cwd]
              end,
            },
            {
              "branch",
              color = { bg = "yellow" },
            },
            {
              function()
                local msg = ""
                local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  ---@diagnostic disable-next-line: undefined-field
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end
                return msg
              end,
              icon = "",
              color = { fg = "grey53" },
            },
          },
          lualine_b = {},
          lualine_c = {},
          -- lualine_b = {
          --   {
          --     function()
          --       return require("grapple").name_or_index()
          --     end,
          --     cond = function()
          --       return package.loaded["grapple"] and require("grapple").exists()
          --     end,
          --   },
          -- },
          lualine_x = {
            -- { require("yaml_nvim").get_yaml_key, color = { fg = "grey53" } },
            {
              function()
                local msg = ""
                local yaml = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                if yaml ~= "yaml" then
                  return msg
                else
                  msg = require("yaml_nvim").get_yaml_key() or ""
                  return msg
                end
              end,
              color = { fg = "grey53" },
            },
          },
          lualine_y = { "filetype" },
        },
        tabline = {
          lualine_a = {
            {
              function()
                return vim.fn.substitute(LazyVim.root(), vim.env.HOME, "~", "")
              end,
              color = { bg = "indianred" },
            },
          },
          lualine_b = {
            {
              function()
                return vim.fn.substitute(vim.fn.getcwd(), vim.env.HOME, "~", "")
              end,
            },
          },
        },
        winbar = {
          lualine_a = winbar_a(true),
          -- lualine_x = {
          --   {
          --     function()
          --       return "cwd:" .. vim.fn.substitute(vim.fn.getcwd(), vim.env.HOME, "~", "")
          --     end,
          --     color = { fg = "indianred" },
          --   },
          -- },
          -- lualine_y = {
          --   {
          --     function()
          --       return vim.fn.substitute(LazyVim.root(), vim.env.HOME, "~", "")
          --     end,
          --     color = { fg = "indianred" },
          --   },
          -- },
        },
        inactive_winbar = {
          lualine_a = winbar_a(false),
          -- lualine_y = {
          --   {
          --     function()
          --       return vim.fn.substitute(LazyVim.root(), vim.env.HOME, "~", "")
          --     end,
          --     color = { fg = "indianred" },
          --   },
          -- },
        },
      }
    end,
  },
}
