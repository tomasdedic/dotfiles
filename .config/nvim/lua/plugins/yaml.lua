return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas({
                select = {
                  "kustomization.yaml",
                  "GitHub Workflow",
                  "gRPC API Gateway & OpenAPI Config",
                  -- "Kong DBLess config",
                },
                -- replace = {
                --   ["Kong DBLess config"] = {
                --     name = "Kong DBLess config",
                --     fileMatch = { "**/api-docs/**/*.yaml" },
                --     url = "https://json.schemastore.org/kong_json_schema.json",
                --     description = "patch kong",
                --   },
                -- },
              })
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
            },
          },
        },
        helm_ls = {
          settings = {
            ["helm-ls"] = {
              valuesFiles = {
                mainValuesFile = "values.yaml",
                lintOverlayValuesFile = "values.lint.yaml",
                additionalValuesFilesGlobPattern = "values*.yaml",
              },
              helmLint = {
                enabled = true,
                ignoredMessages = {},
              },
              yamlls = {
                enabled = false,
              },
            },
          },
        },
      },
    },
  },
}
