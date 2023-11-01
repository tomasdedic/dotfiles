-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/ts/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/ts/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/ts/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/ts/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/ts/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["auto-session"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\5\0\0\a~/\15~/Projects\16~/Downloads\6/\1\0\1\14log_level\nerror\nsetup\17auto-session\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["bufferize.vim"] = {
    commands = { "Bufferize" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/bufferize.vim",
    url = "https://github.com/AndrewRadev/bufferize.vim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-npm"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fcmp-npm\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-npm",
    url = "https://github.com/David-Kunz/cmp-npm"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    after_files = { "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-rg/after/plugin/cmp-rg.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  ["cmp-vsnip"] = {
    after_files = { "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-vsnip/after/plugin/cmp_vsnip.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["codeium.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fcodeium\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/codeium.nvim",
    url = "https://github.com/Exafunction/codeium.nvim"
  },
  ["deepl.vim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22pluginsconf.deepl\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/deepl.vim",
    url = "https://github.com/ryicoh/deepl.vim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen" },
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginsconf.diffview\frequire\0" },
    keys = { { "", "<leader>ddo" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  firenvim = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginsconf.firenvim\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/firenvim",
    url = "https://github.com/glacambre/firenvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  fzf = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    load_after = {
      ["nvim-bqf"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginsconf.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gopher.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rcommands\1\0\0\1\0\5\niferr\niferr\timpl\timpl\fgotests\21~/go/bin/gotests\17gomodifytags\17gomodifytags\ago\ago\nsetup\vgopher\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/gopher.nvim",
    url = "https://github.com/olexsmir/gopher.nvim"
  },
  ["indent-blankline.nvim"] = {
    after_files = { "/Users/ts/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim/after/plugin/commands.lua" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["leap.nvim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\25add_default_mappings\tleap\frequire\0" },
    keys = { { "n", "s" }, { "n", "S" }, { "n", "f" }, { "n", "F" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24pluginsconf.lualine\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-tool-installer"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\0\1\a\0\0\ngopls\fgolines\22goimports-reviser\ajq\vtflint\24lua-language-server\nsetup\25mason-tool-installer\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/mason-tool-installer",
    url = "https://github.com/WhoIsSethDaniel/mason-tool-installer"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "\27LJ\2\n�\1\0\0\4\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0(nnoremap <leader>gg <cmd>Neogit<CR>\bcmd\bvim\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    keys = { { "n", "<leader>gg" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28pluginsconf.lsp.null-ls\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31pluginsconf.nvim-autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    after = { "fzf.vim" },
    config = { "\27LJ\2\nE\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16auto_enable\2\nsetup\bbqf\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    after = { "cmp-path", "cmp-rg", "cmp-buffer", "cmp-cmdline", "cmp-vsnip", "cmp-npm" },
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginsconf.nvim-cmp\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    after = { "telescope-dap.nvim", "nvim-dap-virtual-text", "nvim-dap-ui" },
    config = { "\27LJ\2\nd\0\0\3\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\1K\0\1\0\20pluginsconf.dap\bdap\19load_extension\14telescope\frequire\0" },
    keys = { { "n", "<leader>db" }, { "n", "<leader>dB" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27pluginsconf.dap.dap-ui\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20pluginsconf.lsp\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\n�\1\0\0\3\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\6\0B\0\2\1K\0\1\0Vnnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>\bcmd\bvim\1\0\2\30enable_persistent_history\2\20continuous_sync\2\nsetup\fneoclip\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27pluginsconf.treesitter\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"pluginsconf.nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["papercolor-theme"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/papercolor-theme",
    url = "https://github.com/NLKNguyen/papercolor-theme"
  },
  playground = {
    commands = { "TSPlaygroundToggle" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["session-lens"] = {
    config = { "\27LJ\2\nv\0\0\3\0\5\0\n6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0'\2\4\0B\0\2\1K\0\1\0\17session-lens\19load_extension\14telescope\29pluginsconf.session-lens\frequire\0" },
    keys = { { "", "<C-s>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/session-lens",
    url = "https://github.com/rmagatti/session-lens"
  },
  ["sqlite.lua"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/sqlite.lua",
    url = "https://github.com/tami5/sqlite.lua"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = { "\27LJ\2\ni\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\27highlight_hovered_item\2\16show_guides\2\nsetup\20symbols-outline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["targets.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-dap.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bdap\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    after = { "telescope-fzf-native.nvim" },
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginsconf.telescope\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27pluginsconf.toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27pluginsconf.tokyonight\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  undotree = {
    config = { "\27LJ\2\nH\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0)nnoremap <leader>u :UndotreeShow<CR>\bcmd\bvim\0" },
    keys = { { "", "<leader>u" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-better-whitespace"] = {
    config = { "\27LJ\2\n�\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0~let g:better_whitespace_filetypes_blacklist=['toggleterm','diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive'] -let g:better_whitespace_ctermcolor='174'\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-cool",
    url = "https://github.com/romainl/vim-cool"
  },
  ["vim-dirvish"] = {
    config = { "\27LJ\2\n�\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\2             command! PwdDirvish silent Dirvish $PWD\n             command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish \n             nnoremap <leader>fs :PwdDirvish<CR>\n             nnoremap <leader>ff :VLeftDirvish<CR>\n           \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-dirvish",
    url = "https://github.com/justinmk/vim-dirvish"
  },
  ["vim-dirvish-dovish"] = {
    config = { "\27LJ\2\n�\a\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\a           let g:dirvish_dovish_map_keys = 0\n\n           augroup dirvish_config\n           autocmd!\n           \" unmap dirvish default\n           autocmd FileType dirvish silent! unmap <buffer><C-p>\n           autocmd FileType dirvish silent! unmap <buffer>p\n\n           \" My mappings\n           autocmd FileType dirvish silent! map <buffer>i <Plug>(dovish_create_file)\n           autocmd FileType dirvish silent! map <buffer>I <Plug>(dovish_create_directory)\n           autocmd FileType dirvish silent! map <buffer>dd <Plug>(dovish_delete)\n           autocmd FileType dirvish silent! map <buffer>r <Plug>(dovish_rename)\n           autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)\n           autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)\n           autocmd FileType dirvish silent! map <buffer>p <Plug>(dovish_copy)\n           autocmd FileType dirvish silent! map <buffer>P <Plug>(dovish_move)\n           augroup END\n         \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-dirvish-dovish",
    url = "https://github.com/roginfarrer/vim-dirvish-dovish"
  },
  ["vim-easy-align"] = {
    commands = { "EasyAlign" },
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginsconf.easyalign\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-exchange"] = {
    keys = { { "n", "cx" }, { "x", "X" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/vim-exchange",
    url = "https://github.com/tommcdo/vim-exchange"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\n�\5\0\0\6\0\23\00056\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\t\0'\4\a\0005\5\n\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\v\0'\4\f\0005\5\r\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\20\0'\4\21\0005\5\22\0B\0\5\1K\0\1\0\1\0\1\vsilent\2\16:0Gclog<CR>\15<leader>gh\1\0\1\vsilent\2\21:diffget //3<CR>\ag;\1\0\1\vsilent\2\21:diffget //2<CR>\agj\1\0\1\vsilent\2\22:Gvdiffsplit!<CR>\15<leader>gd\1\0\1\vsilent\2\agb\1\0\1\vsilent\2\24:<C-u>Git blame<CR>\15<leader>gb\6n\bset\vkeymap�\1    nnoremap <silent> <leader>gb :<C-u>Git blame<CR>\n    nnoremap <silent> gb :<C-u>Git blame<CR>\n    nnoremap <leader>gd :Gvdiffsplit!<CR>\n    nnoremap gj :diffget //2<CR>\n    nnoremap g; :diffget //3<CR>\n  \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-helm"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/vim-helm",
    url = "https://github.com/towolf/vim-helm"
  },
  ["vim-indentwise"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-indentwise",
    url = "https://github.com/jeetsukumaran/vim-indentwise"
  },
  ["vim-markdown"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginsconf.markdown\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/preservim/vim-markdown"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-ripgrep"] = {
    commands = { "Rg" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/vim-ripgrep",
    url = "https://github.com/jremmen/vim-ripgrep"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    config = { "vim.g.startuptime_tries = 10" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-surround"] = {
    keys = { { "n", "cs" }, { "n", "ds" }, { "x", "S" }, { "n", "ys" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-terraform"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/vim-terraform",
    url = "https://github.com/hashivim/vim-terraform"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\ne\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0Flet g:VM_custom_motions  = {'h': 'h', 'j': 'j', 'k':'k', 'l':'l'}\bcmd\bvim\0" },
    keys = { { "", "<C-n>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    config = { "\27LJ\2\nR\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0003let g:vsnip_snippet_dir=\"~/.config/nvim/vsnip\"\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginsconf.which-key\frequire\0" },
    loaded = true,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["yaml-revealer"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/yaml-revealer",
    url = "https://github.com/Einenlum/yaml-revealer"
  },
  ["zen-mode.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\b\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0h        nnoremap <leader>zz :lua require(\"zen-mode\").toggle({ window = { width = .80 }})<CR>\n      \bcmd\bvim\fplugins\1\0\0\nkitty\1\0\0\1\0\2\fenabled\2\tfont\a+4\nsetup\rzen-mode\frequire\0" },
    keys = { { "", "<leader>zz" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ts/.local/share/nvim/site/pack/packer/opt/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^leap"] = "leap.nvim",
  ["^lsp_signature"] = "lsp_signature.nvim",
  ["^neodev"] = "neodev.nvim",
  ["^sqlite"] = "sqlite.lua",
  ["^telescope%._extensions%.dap"] = "telescope-dap.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\2\0\6\0\t6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0K\0\1\0\1\2\0\0\15toggleterm&indent_blankline_filetype_exclude\1\2\0\0\rterminal%indent_blankline_buftype_exclude\6g\bvim\0", "setup", "indent-blankline.nvim")
time([[Setup for indent-blankline.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"pluginsconf.nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\n�\5\0\0\6\0\23\00056\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\t\0'\4\a\0005\5\n\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\v\0'\4\f\0005\5\r\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\20\0'\4\21\0005\5\22\0B\0\5\1K\0\1\0\1\0\1\vsilent\2\16:0Gclog<CR>\15<leader>gh\1\0\1\vsilent\2\21:diffget //3<CR>\ag;\1\0\1\vsilent\2\21:diffget //2<CR>\agj\1\0\1\vsilent\2\22:Gvdiffsplit!<CR>\15<leader>gd\1\0\1\vsilent\2\agb\1\0\1\vsilent\2\24:<C-u>Git blame<CR>\15<leader>gb\6n\bset\vkeymap�\1    nnoremap <silent> <leader>gb :<C-u>Git blame<CR>\n    nnoremap <silent> gb :<C-u>Git blame<CR>\n    nnoremap <leader>gd :Gvdiffsplit!<CR>\n    nnoremap gj :diffget //2<CR>\n    nnoremap g; :diffget //3<CR>\n  \bcmd\bvim\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginsconf.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28pluginsconf.lsp.null-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: nvim-neoclip.lua
time([[Config for nvim-neoclip.lua]], true)
try_loadstring("\27LJ\2\n�\1\0\0\3\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\6\0B\0\2\1K\0\1\0Vnnoremap <leader>y <cmd>lua require('telescope').extensions.neoclip.default()<CR>\bcmd\bvim\1\0\2\30enable_persistent_history\2\20continuous_sync\2\nsetup\fneoclip\frequire\0", "config", "nvim-neoclip.lua")
time([[Config for nvim-neoclip.lua]], false)
-- Config for: vim-dirvish-dovish
time([[Config for vim-dirvish-dovish]], true)
try_loadstring("\27LJ\2\n�\a\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\a           let g:dirvish_dovish_map_keys = 0\n\n           augroup dirvish_config\n           autocmd!\n           \" unmap dirvish default\n           autocmd FileType dirvish silent! unmap <buffer><C-p>\n           autocmd FileType dirvish silent! unmap <buffer>p\n\n           \" My mappings\n           autocmd FileType dirvish silent! map <buffer>i <Plug>(dovish_create_file)\n           autocmd FileType dirvish silent! map <buffer>I <Plug>(dovish_create_directory)\n           autocmd FileType dirvish silent! map <buffer>dd <Plug>(dovish_delete)\n           autocmd FileType dirvish silent! map <buffer>r <Plug>(dovish_rename)\n           autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)\n           autocmd FileType dirvish silent! map <buffer>yy <Plug>(dovish_yank)\n           autocmd FileType dirvish silent! map <buffer>p <Plug>(dovish_copy)\n           autocmd FileType dirvish silent! map <buffer>P <Plug>(dovish_move)\n           augroup END\n         \bcmd\bvim\0", "config", "vim-dirvish-dovish")
time([[Config for vim-dirvish-dovish]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20pluginsconf.lsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: vim-dirvish
time([[Config for vim-dirvish]], true)
try_loadstring("\27LJ\2\n�\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\2             command! PwdDirvish silent Dirvish $PWD\n             command! VLeftDirvish leftabove vsplit | vertical resize 50 | silent Dirvish \n             nnoremap <leader>fs :PwdDirvish<CR>\n             nnoremap <leader>ff :VLeftDirvish<CR>\n           \bcmd\bvim\0", "config", "vim-dirvish")
time([[Config for vim-dirvish]], false)
-- Config for: deepl.vim
time([[Config for deepl.vim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22pluginsconf.deepl\frequire\0", "config", "deepl.vim")
time([[Config for deepl.vim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginsconf.nvim-cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24pluginsconf.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: vim-better-whitespace
time([[Config for vim-better-whitespace]], true)
try_loadstring("\27LJ\2\n�\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0~let g:better_whitespace_filetypes_blacklist=['toggleterm','diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive'] -let g:better_whitespace_ctermcolor='174'\bcmd\bvim\0", "config", "vim-better-whitespace")
time([[Config for vim-better-whitespace]], false)
-- Config for: vim-vsnip
time([[Config for vim-vsnip]], true)
try_loadstring("\27LJ\2\nR\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0003let g:vsnip_snippet_dir=\"~/.config/nvim/vsnip\"\bcmd\bvim\0", "config", "vim-vsnip")
time([[Config for vim-vsnip]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27pluginsconf.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: firenvim
time([[Config for firenvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25pluginsconf.firenvim\frequire\0", "config", "firenvim")
time([[Config for firenvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27pluginsconf.tokyonight\frequire\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26pluginsconf.which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27pluginsconf.toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: mason-tool-installer
time([[Config for mason-tool-installer]], true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21ensure_installed\1\0\0\1\a\0\0\ngopls\fgolines\22goimports-reviser\ajq\vtflint\24lua-language-server\nsetup\25mason-tool-installer\frequire\0", "config", "mason-tool-installer")
time([[Config for mason-tool-installer]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\5\0\0\a~/\15~/Projects\16~/Downloads\6/\1\0\1\14log_level\nerror\nsetup\17auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: codeium.nvim
time([[Config for codeium.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fcodeium\frequire\0", "config", "codeium.nvim")
time([[Config for codeium.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd cmp-npm ]]

-- Config for: cmp-npm
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fcmp-npm\frequire\0", "config", "cmp-npm")

vim.cmd [[ packadd cmp-vsnip ]]
vim.cmd [[ packadd cmp-cmdline ]]
vim.cmd [[ packadd cmp-buffer ]]
vim.cmd [[ packadd cmp-rg ]]
vim.cmd [[ packadd cmp-path ]]
vim.cmd [[ packadd telescope-fzf-native.nvim ]]

-- Config for: telescope-fzf-native.nvim
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bfzf\19load_extension\14telescope\frequire\0", "config", "telescope-fzf-native.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'DiffviewOpen', function(cmdargs)
          require('packer.load')({'diffview.nvim'}, { cmd = 'DiffviewOpen', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'diffview.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DiffviewOpen ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'SymbolsOutline', function(cmdargs)
          require('packer.load')({'symbols-outline.nvim'}, { cmd = 'SymbolsOutline', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'symbols-outline.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('SymbolsOutline ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'StartupTime', function(cmdargs)
          require('packer.load')({'vim-startuptime'}, { cmd = 'StartupTime', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-startuptime'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('StartupTime ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'SymbolsOutlineClose', function(cmdargs)
          require('packer.load')({'symbols-outline.nvim'}, { cmd = 'SymbolsOutlineClose', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'symbols-outline.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('SymbolsOutlineClose ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'EasyAlign', function(cmdargs)
          require('packer.load')({'vim-easy-align'}, { cmd = 'EasyAlign', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-easy-align'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('EasyAlign ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Neogit', function(cmdargs)
          require('packer.load')({'neogit'}, { cmd = 'Neogit', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'neogit'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Neogit ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Bufferize', function(cmdargs)
          require('packer.load')({'bufferize.vim'}, { cmd = 'Bufferize', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'bufferize.vim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Bufferize ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSPlaygroundToggle', function(cmdargs)
          require('packer.load')({'playground'}, { cmd = 'TSPlaygroundToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'playground'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSPlaygroundToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Rg', function(cmdargs)
          require('packer.load')({'vim-ripgrep'}, { cmd = 'Rg', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-ripgrep'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Rg ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'SymbolsOutlineOpen', function(cmdargs)
          require('packer.load')({'symbols-outline.nvim'}, { cmd = 'SymbolsOutlineOpen', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'symbols-outline.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('SymbolsOutlineOpen ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[xnoremap <silent> X <cmd>lua require("packer.load")({'vim-exchange'}, { keys = "X", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>zz <cmd>lua require("packer.load")({'zen-mode.nvim'}, { keys = "<lt>leader>zz", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> cs <cmd>lua require("packer.load")({'vim-surround'}, { keys = "cs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-s> <cmd>lua require("packer.load")({'session-lens'}, { keys = "<lt>C-s>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> s <cmd>lua require("packer.load")({'leap.nvim'}, { keys = "s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>dB <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>leader>dB", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>db <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>leader>db", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> F <cmd>lua require("packer.load")({'leap.nvim'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ds <cmd>lua require("packer.load")({'vim-surround'}, { keys = "ds", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>ddo <cmd>lua require("packer.load")({'diffview.nvim'}, { keys = "<lt>leader>ddo", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ys <cmd>lua require("packer.load")({'vim-surround'}, { keys = "ys", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> f <cmd>lua require("packer.load")({'leap.nvim'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> S <cmd>lua require("packer.load")({'leap.nvim'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>u <cmd>lua require("packer.load")({'undotree'}, { keys = "<lt>leader>u", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>gg <cmd>lua require("packer.load")({'neogit'}, { keys = "<lt>leader>gg", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> cx <cmd>lua require("packer.load")({'vim-exchange'}, { keys = "cx", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-n> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>C-n>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> S <cmd>lua require("packer.load")({'vim-surround'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)]]
vim.cmd [[au FileType yaml ++once lua require("packer.load")({'yaml-revealer'}, { ft = "yaml" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'gopher.nvim'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType terraform ++once lua require("packer.load")({'vim-terraform'}, { ft = "terraform" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'neodev.nvim'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType md ++once lua require("packer.load")({'vim-markdown'}, { ft = "md" }, _G.packer_plugins)]]
vim.cmd [[au FileType helm ++once lua require("packer.load")({'yaml-revealer', 'vim-helm'}, { ft = "helm" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs', 'indent-blankline.nvim'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'gitsigns.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'targets.vim', 'nvim-ts-rainbow', 'nvim-treesitter-textsubjects', 'fzf', 'nvim-treesitter-textobjects'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/ts/.local/share/nvim/site/pack/packer/opt/vim-terraform/ftdetect/hcl.vim]], true)
vim.cmd [[source /Users/ts/.local/share/nvim/site/pack/packer/opt/vim-terraform/ftdetect/hcl.vim]]
time([[Sourcing ftdetect script at: /Users/ts/.local/share/nvim/site/pack/packer/opt/vim-terraform/ftdetect/hcl.vim]], false)
time([[Sourcing ftdetect script at: /Users/ts/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/ts/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/ts/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/ts/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]], true)
vim.cmd [[source /Users/ts/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]]
time([[Sourcing ftdetect script at: /Users/ts/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end