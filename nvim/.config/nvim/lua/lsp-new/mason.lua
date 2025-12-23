return function()
	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")
	local mason_tool_installer = require("mason-tool-installer")

	-- Language servers
	-- Docs: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
	local servers = {
		-- LSP's we don't override
		"ansiblels",
		"bashls",
		"helm_ls",
		"html",
		"jsonnet_ls",
		"tailwindcss",
		"terraformls",
		-- LSPs we override
		"gopls",
		"pyright",
		"rust_analyzer",
		"ts_ls",
		"jsonls",
		"lua_ls",
		"cssls",
	}

	-- enable mason and configure icons
	mason.setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	-- Ensure all servers are installed
	mason_lspconfig.setup({
		ensure_installed = servers,
		automatic_installation = true,
		-- Setup handlers immediately in the setup call
		handlers = {
			-- default handler for installed servers
			function(server_name)
				local lspconfig = require("lspconfig")
				local cmp_nvim_lsp = require("cmp_nvim_lsp")
				local capabilities = cmp_nvim_lsp.default_capabilities()

				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["svelte"] = function()
				local lspconfig = require("lspconfig")
				local cmp_nvim_lsp = require("cmp_nvim_lsp")
				local capabilities = cmp_nvim_lsp.default_capabilities()

				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,
			["graphql"] = function()
				local lspconfig = require("lspconfig")
				local cmp_nvim_lsp = require("cmp_nvim_lsp")
				local capabilities = cmp_nvim_lsp.default_capabilities()

				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			["emmet_ls"] = function()
				local lspconfig = require("lspconfig")
				local cmp_nvim_lsp = require("cmp_nvim_lsp")
				local capabilities = cmp_nvim_lsp.default_capabilities()

				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
				})
			end,
			["lua_ls"] = function()
				local lspconfig = require("lspconfig")
				local cmp_nvim_lsp = require("cmp_nvim_lsp")
				local capabilities = cmp_nvim_lsp.default_capabilities()

				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		},
	})

	mason_tool_installer.setup({
		ensure_installed = {
			"prettier", -- prettier formatter
			"stylua", -- lua formatter
			"isort", -- python formatter
			"black", -- python formatter
			"pylint",
			"eslint_d",
			"delve",
			"debugpy",
		},
	})
end
