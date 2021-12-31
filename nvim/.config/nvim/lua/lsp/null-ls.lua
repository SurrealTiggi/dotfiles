-- [[ NULL-LS ]] --
-------------------
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

-- [[ Local configs ]] --
-------------------------
-- TODO: Add local configs for plugins that need more TLC
-- eg. https://github.com/vuki656/nvim-config/blob/117bc9a21e23fb8f217f761dfb5b9fb8362dcaa7/lua/plugins/formatter-linter/init.lua

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- [[ Setup ]] --
-----------------
null_ls.setup({
  -- Attach to active LSP and run auto-format on save
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,

	debug = false,
	sources = {
    -- Formatters
    formatting.trim_newlines,
    formatting.trim_whitespace,
    formatting.prettier,
    formatting.isort,
    formatting.black,
    formatting.gofumpt,
    formatting.stylua,
    formatting.shfmt,

    -- Diagnostics
    diagnostics.flake8.with({ extra_args = {"--max-line-length", "88"} }),
    diagnostics.staticcheck,
    diagnostics.golangci_lint,
    diagnostics.eslint,
    diagnostics.mdl,
    diagnostics.write_good,
    diagnostics.stylelint,
    diagnostics.shellcheck,

    -- Code Actions
    -- TODO: Could add git + refactoring.nvim
	},
})