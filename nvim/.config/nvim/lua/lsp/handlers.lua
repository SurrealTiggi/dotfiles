-- [[ LSP HANDLERS ]] --
------------------------
-- Load in our config
local exists, my_cfg = pcall(require, "lsp.misc-config")
if not exists then
	return
end
-- Ensure completion engine is installed
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

-- Highlight all instances of symbol under cursor
local function lsp_highlight_document(client, bufnr)
	local augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", {})

	-- Only enable if the active LSP supports it
	if client.supports_method("textDocument/documentHighlight") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("CursorHold", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.clear_references()
			end,
		})
	end
end

-- Bring in default LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local M = {}

-- Initial setup
M.setup = function()
	-- Setup diagnostic signs
	for type, icon in pairs(SYMBOLS.diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { texthl = hl, text = icon, numhl = hl })
	end

	vim.diagnostic.config(my_cfg.diagnostics_config)

	-- Setup hoverdoc
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	-- Setup signatureHelp
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

-- Setup on-attach
M.on_attach = function(client, bufnr)
	-- Add lsp_signature
	require("lsp_signature").on_attach(my_cfg.lsp_signature_opts)

	-- :lua =vim.lsp.get_active_clients()[1].server_capabilities -- lists object
	-- [Python] Remove LSP formatting since we'll use black
	if client.name == "pyright" then
		client.server_capabilities.documentFormattingProvider = false
	end

	-- [Golang] Remove LSP formatting since we'll use gofumpt
	if client.name == "gopls" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end

	-- [Lua] Remove LSP formatting since we'll use stylua
	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	-- [Terraform] Remove LSP formatting so null-ls controls it
	if client.name == "terraformls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	-- [JSON] Remove LSP formatting since we'll use null-ls
	if client.name == "jsonls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	-- [JS/TS] Remove LSP formatting since we'll use null-ls
	-- NOTE: Check lsp.settings.tsserver as well, since this is largely ignored
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end

	-- lsp_keymaps(bufnr)
	lsp_highlight_document(client, bufnr)
end

-- Merge LSP capabilities with completion engine
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
