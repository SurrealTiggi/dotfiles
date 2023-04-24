-- [[ Mason.nvim ]] --
----------------------
local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

-- Common handlers for all LSP servers
local opts = {
	on_attach = require("lsp.handlers").on_attach,
	capabilities = require("lsp.handlers").capabilities,
}

-- Language servers
-- Docs: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
	-- LSP's we don't override
	"ansiblels",
	"bashls",
	"html",
	"jsonnet_ls",
	"terraformls",
	"tflint",
	-- LSPs we override
	"gopls",
	"pyright",
	"rust_analyzer",
	"tsserver",
	"jsonls",
	"lua_ls",
	"cssls",
}

-- Ensure all servers are installed
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

-- Register a handler that's called for all installed servers
-- We override where needed
require("mason-lspconfig").setup_handlers({
	-- Default handler
	function(server)
		require("lspconfig")[server].setup(opts)
	end,

	-- Golang
	["gopls"] = function()
		local gopls_opts = require("lsp.settings.gopls")
		opts = vim.tbl_deep_extend("force", opts, gopls_opts)
		require("lspconfig")["gopls"].setup(opts)
	end,

	-- Python
	["pyright"] = function()
		local pyright_opts = require("lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", opts, pyright_opts)
		require("lspconfig")["pyright"].setup(opts)
	end,

	-- Rust
	["rust_analyzer"] = function()
		local rust_analyzer_opts = require("lsp.settings.rust_analyzer")
		opts = vim.tbl_deep_extend("force", opts, rust_analyzer_opts)
		require("lspconfig")["rust_analyzer"].setup(opts)
	end,

	-- JS/TS (using nvim-lsp-ts-utils for a better experience)
	-- NOTE: we override `on_attach` via the "keep" keyword
	["tsserver"] = function()
		local tsserver_opts = require("lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("keep", opts, tsserver_opts)
		require("lspconfig")["tsserver"].setup(opts)
	end,

	-- JSON
	["jsonls"] = function()
		local jsonls_opts = require("lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", opts, jsonls_opts)
		require("lspconfig")["jsonls"].setup(opts)
	end,

	-- Lua
	["lua_ls"] = function()
		local lua_opts = require("lsp.settings.lua_ls")
		opts = vim.tbl_deep_extend("force", opts, lua_opts)
		require("lspconfig")["lua_ls"].setup(opts)
	end,

	-- CSS
	["cssls"] = function()
		local css_opts = require("lsp.settings.cssls")
		opts = vim.tbl_deep_extend("force", opts, css_opts)
		require("lspconfig")["cssls"].setup(opts)
	end,
})
