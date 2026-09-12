return function()
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	-- automatic_enable (default) runs vim.lsp.enable for every installed server;
	-- per-server settings live in lsp-new/lspconfig.lua via vim.lsp.config
	require("mason-lspconfig").setup({
		-- stylua ships an LSP mode since 2.5; conform already runs it as a formatter
		automatic_enable = { exclude = { "stylua" } },
		ensure_installed = {
			"ansiblels",
			"bashls",
			"cssls",
			"gopls",
			"helm_ls",
			"html",
			"jsonls",
			"jsonnet_ls",
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"tailwindcss",
			"terraformls",
			"ts_ls",
		},
	})

	require("mason-tool-installer").setup({
		ensure_installed = {
			"prettier",
			"stylua",
			"isort",
			"black",
			"pylint",
			"eslint_d",
			"delve",
			"debugpy",
		},
	})
end
