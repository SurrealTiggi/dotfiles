-- [[ MISC CONFIG ]] --
----------------------
-- Random LSP configurations to keep things neat
local M = {}

-- Diagnostics
M.diagnostics_config = {
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		border = "rounded",
		source = "always",
		header = SYMBOLS.misc.debug .. (" ‹Diagnostics› " or "Normal"),
	},
}

-- SignatureHelp
M.lsp_signature_opts = {
	floating_window = false,
	hint_enable = true,
	hint_prefix = SYMBOLS.misc.hint_prefix .. " ",
	handler_opts = {
		border = "shadow",
		hi_parameter = "LspSignatureActiveParameter",
	},
}

return M
