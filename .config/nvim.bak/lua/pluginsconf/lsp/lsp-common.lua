local mappings = require("pluginsconf.lsp.lsp-mappings")
local signature = require("pluginsconf.lsp.lsp-signature")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}
--- function already defines common mappings and `lsp_signature.nvim`
-- @param client the lsp client
-- @param bufnr the buffer number
local common_on_attach = function(client, bufnr)
	-- highlight not working
	-- if client.server_capabilities.documentHighlightProvider then
	-- 	vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
	-- 	vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
	-- 	vim.api.nvim_create_autocmd("CursorHold", {
	-- 		callback = vim.lsp.buf.document_highlight,
	-- 		buffer = bufnr,
	-- 		group = "lsp_document_highlight",
	-- 		desc = "Document Highlight",
	-- 	})
	-- 	vim.api.nvim_create_autocmd("CursorMoved", {
	-- 		callback = vim.lsp.buf.clear_references,
	-- 		buffer = bufnr,
	-- 		group = "lsp_document_highlight",
	-- 		desc = "Clear All the References",
	-- 	})
	-- end
	mappings.on_attach(client, bufnr)
	signature.on_attach()
end

local M = {
	common_on_attach = common_on_attach,
	mappings = mappings,
	signature = signature,
	capabilities = capabilities,
	handlers = handlers,
}

return M
