local M = {}
local util = require("lspconfig/util")

M.setup = function()
	local handlers = require("pluginsconf.lsp.lsp-common").handlers
	local capabilities = require("pluginsconf.lsp.lsp-common").capabilities
	local common_on_attach = require("pluginsconf.lsp.lsp-common").common_on_attach

	-- yaml-companion is a wrapper on yamls(lspconfig)
	local opts = require("yaml-companion").setup({
		builtin_matchers = {
			-- Detects Kubernetes files based on content
			kubernetes = { enabled = false },
			cloud_init = { enabled = false },
		},

		schemas = {
			-- not loaded automatically, manually select with
			-- :Telescope yaml_schema
			-- find new ones: https://www.schemastore.org/json/
			{
				name = "OpenShift 4.16",
				uri = "file:///Users/ext90981/tmp/apispec/k8s-manifest-validation/scripts/openshift-json-schema/master-standalone/all.json",
			},
			-- {
			-- 	name = "Kubernetes 1.22.4",
			-- 	uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
			-- },
		},

		lspconfig = {
			handlers = handlers,
			on_attach = common_on_attach,
			capabilities = capabilities,
			cmd = { "yaml-language-server", "--stdio" },
			root_dir = util.root_pattern(vim.fn.getcwd()),
			filetypes = { "yaml" },
			settings = {
				redhat = { telemetry = { enabled = false } },
				yaml = {
					trace = {
						server = "debug",
					},
					schemaStore = {
						enable = false,
						url = "",
					},
					format = {
						enable = true,
						singleQuote = false,
						bracketSpacing = true,
					},
					-- schemas from store, matched by filename
					-- loaded automatically
					schemas = require("schemastore").yaml.schemas({
						select = {
							"kustomization.yaml",
							"GitHub Workflow",
						},
					}),
					-- schemas = {
					-- https://www.schemastore.org/api/json/catalog.json
					-- ["https://openshiftjsonschema.dev/v4.9.18-standalone/all.json"] = "*.yaml",
					-- ["kubernetes"] = "/*",
					-- ["http://json.schemastore.org/kustomization"] = "kustomization.yaml",
					-- ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/v1.174.2/service-schema.json"] = "pipelines/*.yaml"
					-- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.0/all.json"] = "/*.yaml"
					-- },
					-- validate:off otherwise it will kill yaml with errors for Openshift manifest
					-- also 1. Matches multiple schemas when only one must validate. [0] when using custom schemas
					validate = false,
					completion = true,
					hover = true,
				},
			},
		},
	})

	require("lspconfig").yamlls.setup(opts)
	vim.lsp.set_log_level("trace")
end

return M
