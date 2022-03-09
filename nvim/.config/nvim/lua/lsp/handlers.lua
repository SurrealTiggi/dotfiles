-- [[ LSP HANDLERS ]] --
------------------------
-- Load in our config
local exists, my_cfg = pcall(require, "lsp.lsp-config")
if not exists then
	return
end
-- Ensure completion engine is installed
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

-- Highlight all instances of symbol under cursor
local function lsp_highlight_document(client)
	-- Only enable if the active LSP supports it
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

-- Setup basic keybinds
-- @SurrealTiggi moved to user.keybinds
-- local function lsp_keymaps(bufnr)
-- -- Quick function to keep things more readable
-- local function buf_set_keymap(...)
-- vim.api.nvim_buf_set_keymap(bufnr, ...)
-- end

-- -- General keybind options
-- local opts = { noremap = true, silent = true }
-- end

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

	-- [Python] Remove LSP formatting since we'll use black
	if client.name == "pyright" then
		client.resolved_capabilities.document_formatting = false
	end

	-- [Golang] Remove LSP formatting since we'll use gofumpt and explicitly enable highlight
	if client.name == "gopls" then
		client.resolved_capabilities.document_highlight = true
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	-- [Lua] Remove LSP formatting since we'll use stylua
	if client.name == "sumneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end

	-- [Terraform] Remove LSP formatting so null-ls controls it
	if client.name == "terraformls" then
		client.resolved_capabilities.document_formatting = false
	end

	-- [JSON] Remove LSP formatting since we'll use null-ls
	if client.name == "jsonls" then
		client.resolved_capabilities.document_formatting = false
	end

	-- lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

-- Merge LSP capabilities with completion engine
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
