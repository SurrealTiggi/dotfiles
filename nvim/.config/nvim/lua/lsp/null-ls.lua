-- [[ NULL-LS ]] --
-------------------
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

-- [[ Local configs ]] --
-------------------------
-- TODO: Register a custom source to format terragrunt files
-- TODO: Add local configs for plugins that need more TLC
-- eg. https://github.com/vuki656/nvim-config/blob/117bc9a21e23fb8f217f761dfb5b9fb8362dcaa7/lua/plugins/formatter-linter/init.lua

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local methods = null_ls.methods
-- local code_actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- local tflint = require("lsp.custom")
-- [[ Setup ]] --
-----------------
null_ls.setup({
	log_level = "debug",
	-- Attach to active LSP and run auto-format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
	debug = false,
	sources = {
		-- Formatters
		formatting.trim_newlines,
		formatting.trim_whitespace,
		formatting.prettier.with({
			disabled_filetypes = { "yaml" },
		}),
		-- formatting.prettier.with({
		-- prefer_local = "node_modules/.bin",
		-- command = "prettier-standard",
		-- extra_args = { "--format" }
		-- }),
		formatting.isort,
		formatting.black,
		formatting.gofumpt,
		formatting.goimports,
		formatting.stylua,
		formatting.shfmt,
		formatting.terraform_fmt,
		formatting.packer,

		-- Diagnostics
		-- NOTE: would be nice to switch to flakeheaven for pyproject.toml support
		-- but command doesn't seem to support `flakeheave lint`
		diagnostics.flake8.with({
			extra_args = { "--max-line-length", "88" },
		}),
		-- diagnostics.staticcheck,
		diagnostics.golangci_lint,
		diagnostics.eslint,
		diagnostics.standardjs,
		-- TODO: Tweak config for markdownlint as defaults are super noisy
		-- diagnostics.mdl,
		-- diagnostics.write_good,
		diagnostics.stylelint,
		diagnostics.shellcheck,
		diagnostics.yamllint.with({ extra_args = { "-d", "relaxed" } }),
		-- tflint,

		-- Code Actions
		-- TODO: Could add git + refactoring.nvim
	},
})
