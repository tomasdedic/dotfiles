local fs = require("plenary.scandir")
local path = require("plenary.path")
local M = {
	-- schemas_catalog = "datreeio/CRDs-catalog",
	schemas_catalog = "tomasdedic/openshift-json-schema",
	schemas_catalog_local_path = "/Users/ext90981/tmp/apispec/openshift-json-schema/",
	schema_catalog_branch = "main",
}
M.schema_url = "https://raw.githubusercontent.com/" .. M.schemas_catalog .. "/" .. M.schema_catalog_branch

M.only_in_directory = function(fullpath)
	local stringlen = M.schemas_catalog_local_path:len()
	return fullpath:sub(stringlen + 2)
end

M.list_files = function(directory)
	local opts = {
		hidden = false,
		add_dirs = false,
	}

	local fileList = {}
	local dir = fs.scan_dir(directory, opts)
	for _, fileName in ipairs(dir) do
		table.insert(fileList, M.only_in_directory(fileName))
	end
	return fileList
end

M.init = function()
	local all_schemas = M.list_files(M.schemas_catalog_local_path)
	local p = path.new(M.schemas_catalog_local_path)

	vim.ui.select(all_schemas, { prompt = "Select schema " .. p:normalize() }, function(selection)
		if not selection then
			vim.notify("Canceled.", vim.log.levels.WARN, {})
			return
		end
		local schema_url = M.schema_url .. "/" .. selection
		local schema_modeline = "# yaml-language-server: $schema=" .. schema_url
		vim.api.nvim_buf_set_lines(0, 0, 0, false, { schema_modeline })
		vim.notify("Added schema modeline: " .. schema_modeline)
	end)
end
return M
