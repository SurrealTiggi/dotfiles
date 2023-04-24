-- [[ NEOVIM LSP ]] --
----------------------
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

-- require("lsp.lsp-installer") -- [DEPRECATED]
require("lsp.handlers").setup()
require("lsp.null-ls")

-- New:
require("neodev").setup()
require("lsp.mason")
