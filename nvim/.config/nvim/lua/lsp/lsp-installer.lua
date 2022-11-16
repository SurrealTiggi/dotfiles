-- [[ LSP Installer ]] --
-------------------------
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Can also be used to set options and overrides for specific language servers
lsp_installer.on_server_ready(function(server)
	-- Use our common handlers
	local opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	-- Golang
	if server.name == "gopls" then
		local gopls_opts = require("lsp.settings.gopls")
		opts = vim.tbl_deep_extend("force", gopls_opts, opts)
	end

	-- Python
	if server.name == "pyright" then
		local pyright_opts = require("lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	-- Rust
	-- TODO: Try https://github.com/simrat39/rust-tools.nvim
	-- TODO: See https://github.com/simrat39/rust-tools.nvim/pull/139
	if server.name == "rust_analyzer" then
		local rust_analyzer_opts = require("lsp.settings.rust_analyzer")
		opts = vim.tbl_deep_extend("force", rust_analyzer_opts, opts)
	end

	-- JS/TS (using nvim-lsp-ts-utils for a better experience)
	-- @SurrealTiggi note that we override `on_attach` via the "keep" keyword
	-- see h: vim.tbl_deep_extend
	if server.name == "tsserver" then
		local tsserver_opts = require("lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("keep", tsserver_opts, opts)
	end

	-- JSON
	if server.name == "jsonls" then
		local jsonls_opts = require("lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	-- Lua
	if server.name == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	-- CSS
	if server.name == "cssls" then
		local css_opts = require("lsp.settings.cssls")
		opts = vim.tbl_deep_extend("force", css_opts, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
