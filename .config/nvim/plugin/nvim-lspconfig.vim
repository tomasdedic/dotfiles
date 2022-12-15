"float terminal
" nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
" tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
"saga scroll
" nnoremap <A-j> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" nnoremap <A-k> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>


lua << EOF
vim.lsp.set_log_level("error")

--local prettier = require "efm/prettier"
--local eslint = require "efm/eslint"
--local language_formatters = {
--  typescript = {prettier, eslint},
--  javascript = {prettier, eslint},
--  typescriptreact = {prettier, eslint},
--  javascriptreact = {prettier, eslint},
--  yaml = {prettier, yamllint},
--  -- yaml = {prettier},
--  json = {prettier},
--  html = {prettier},
--  scss = {prettier},
--  css = {prettier},
--  markdown = {prettier},
--  lua = {
--    {formatCommand = "lua-format -i", formatStdin = true}
--  }
--}

local nvim_lsp = require "lspconfig"

-- efm = {
--    filetypes = vim.tbl_keys(language_formatters),
--    root_dir = nvim_lsp.util.root_pattern("package.json","yarn.lock", ".git"),
--    init_options = {
--      documentFormatting = true,
--      codeAction = true
--    },
--    settings = {
--      rootMarkers = {".git/"},
--      languages = language_formatters
--    }
--  }



local on_attach = function(client, bufnr)


    -- require('completion').on_attach()
    -- require 'illuminate'.on_attach(client)
    -- require 'lsp_signature'.on_attach(client)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gk', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

    buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',opts)
    buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>',opts)
    -- buf_set_keymap('n', '<leader>law','<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<leader>lrw','<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<leader>llw','<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',opts)
    -- buf_set_keymap('n', '<leader>lt','<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
   buf_set_keymap('n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>lrf', '<cmd>lua vim.lsp.buf.references()<CR>',opts)
    buf_set_keymap('n', '<leader>ld','<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',opts)
    buf_set_keymap('n', '<leader>ll','<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>',opts)
    -- saga
    --buf_set_keymap("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<cr>", opts)
    --buf_set_keymap("n", "ga", "<cmd>lua require('lspsaga.codeaction').code_action()<cr>", opts)
    --buf_set_keymap("v", "ga", "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<cr>", opts)
    --buf_set_keymap("n", "gk",         "<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>", opts)
    ---- buf_set_keymap('n', '<c-k>',     "<cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>", opts)
    --buf_set_keymap("n", "<leader>r", "<cmd>lua require('lspsaga.rename').rename()<cr>", opts)
    --buf_set_keymap("n", "gd",        "<cmd>lua require'lspsaga.provider'.preview_definition()<cr>", opts)
    --buf_set_keymap("n", "<leader>d", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<cr>", opts)
    --buf_set_keymap("n", "[g",        "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<cr>", opts)
    --buf_set_keymap("n", "]g",        "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
    --buf_set_keymap("n", "<c-b>", "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<cr>", opts)
    --buf_set_keymap("n", "<c-f>", "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<cr>", opts)

    vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()")
    -- This is causing an out of bounds error, see if this changed in a nightly
    --vim.api.nvim_command("autocmd InsertLeave <buffer> lua vim.lsp.diagnostic.set_loclist({open_loclist = false})")
    vim.api.nvim_command [[ highlight TSCurrentScope ctermbg=NONE guibg=NONE ]]
   -- vim.api.nvim_command [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

end

---lsp servers----
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

local lspconfig = require'lspconfig'

require("nvim-lsp-installer").setup {}

-- LSPs
-- require'lspinstall'.setup()
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = {"bashls","tflint"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

nvim_lsp.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {"gopls"},
  settings = {
      gopls = {
          analyses = {
              fillstruct = true,
          },
      },
  },
  filetypes = {"go","gomod"},
  root_dir = util.root_pattern("go.mod", ".git"),
  }

nvim_lsp.terraformls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern(vim.fn.getcwd()),
  filetypes =  {"terraform"},
  cmd = { "terraform-ls", "serve" },
  root_dir = util.root_pattern(".terraform", ".git"),
  --root_dir = util.root_pattern(vim.fn.getcwd()),
  }

nvim_lsp.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern(vim.fn.getcwd()),
  filetypes =  {"yaml"},
  settings = {
      yaml = {
        format = {
          enable = true,
          singleQuote = false,
          bracketSpacing = true
        },
        schemas = {
          -- https://www.schemastore.org/api/json/catalog.json
          --  ["kubernetes"] = "manifests/*.yaml",
          -- ["kubernetes"] = "*.yaml",
          ["https://openshiftjsonschema.dev/v4.9.18-standalone/all.json"] = "*.yaml",
          --["/home/ts/GIT/work/openshift/oshi/scheme/scheme.json"] = "*.yaml",
          ["http://json.schemastore.org/kustomization"]= "kustomization.yaml",
          ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/v1.174.2/service-schema.json"] = "pipelines/*.yaml"
          -- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.0/all.json"] = "/*.yaml"
        },
      -- schemaStore = {  enable = true },
      	validate = true,
        completion = true
      }
    },
  }

EOF
