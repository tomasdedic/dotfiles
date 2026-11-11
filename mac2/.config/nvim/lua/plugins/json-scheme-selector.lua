return {
  {
    "tomasdedic/nvim-json-schema-selector",
    ft = "yaml",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      schemas_catalog = "tomasdedic/openshift-json-schema",
      schemas_catalog_local_path = vim.fn.expand("~/GIT/OPENSHIFT/openshift-json-schema/4.16"),
      schema_catalog_branch = "main",
      local_schemas = true, -- Use local file paths (true) or GitHub URLs (false)
    },
    keys = {
      { "<leader>js", "<cmd>JsonSchemaSelect<cr>", desc = "Select YAML Schema", ft = "yaml" },
      { "<leader>jt", "<cmd>JsonSchemaToggle<cr>", desc = "Toggle Local/Remote Schemas", ft = "yaml" },
    },
  },
}
