-- [[ MISCELLANEOUS ]] --
-------------------------
-- Set nvim-notify as main notifier
vim.notify = require("notify")

-- [[ Highlight Groups ]] --
----------------------------
-- @SurrealTiggi could move all these to COLORS and initialise in lua/init.lua?
-- LSP Symbol Highlights (see :h vim.lsp.buf.document_highlight)
-- TODO: Use vim.api.nvim_set_hl() instead (see https://github.com/tiagovla/tokyodark.nvim/blob/230a6d0cd40692e4bd763623d1ce5671b7c4f150/lua/tokyodark/highlights.lua)
vim.cmd([[
  hi! LspReferenceRead gui=italic,underline cterm=italic,underline guibg=NONE guifg=#fde016
  hi! LspReferenceText gui=italic,underline cterm=italic,underline guibg=NONE guifg=#fde016
  hi! LspReferenceWrite gui=italic,underline cterm=italic,underline guibg=NONE guifg=#fde016
]])

-- LSP Signature active parameter highlighting
vim.cmd([[
  hi! LspSignatureActiveParameter gui=bold,underline cterm=bold,underline guibg=NONE guifg=#e74125
]])

-- LSP Diagnostics
vim.cmd([[
  hi! DiagnosticSignError guifg=#db4b4b
  hi! DiagnosticSignWarn guifg=#e0af68
  hi! DiagnosticSignHint guifg=#10B981
  hi! DiagnosticSignInfo guifg=#0db9d7
]])

-- Make the cursorline brighter
vim.cmd([[
  hi! CursorLine term=bold cterm=bold guibg=#1b1f27
]])

-- Make floating windows the same color as the background
-- vim.cmd([[
-- hi! FloatBorder guibg=NONE ctermbg=NONE
-- hi! NormalFloat guibg=NONE ctermbg=NONE
-- ]])

-- Show off animoo background
-- @SurrealTiggi: Disabled as inactive buffer dimming doesn't work as well with this
-- vim.cmd([[
-- hi Normal     guibg=NONE ctermbg=NONE
-- hi LineNr     ctermbg=NONE guibg=NONE
-- hi SignColumn ctermbg=NONE guibg=NONE
-- ]])

-- Random plugin settings
-- Outline tree
-- FIXME: Would prefer to stick this in plugin settings
-- see https://github.com/simrat39/symbols-outline.nvim/issues/19
vim.g.symbols_outline = {
	auto_preview = false,
	auto_close = true,
	symbols = {
		File = { icon = SYMBOLS.lsp_symbols["File"], hl = "TSURI" },
		Module = { icon = SYMBOLS.lsp_symbols["Module"], hl = "TSNamespace" },
		Namespace = { icon = SYMBOLS.lsp_symbols["Namespace"], hl = "TSNamespace" },
		Package = { icon = SYMBOLS.lsp_symbols["Package"], hl = "TSNamespace" },
		Class = { icon = SYMBOLS.lsp_symbols["Class"], hl = "TSType" },
		Method = { icon = SYMBOLS.lsp_symbols["Method"], hl = "TSMethod" },
		Property = { icon = SYMBOLS.lsp_symbols["Property"], hl = "TSMethod" },
		Field = { icon = SYMBOLS.lsp_symbols["Field"], hl = "TSField" },
		Constructor = { icon = SYMBOLS.lsp_symbols["Constructor"], hl = "TSConstructor" },
		Enum = { icon = SYMBOLS.lsp_symbols["Enum"], hl = "TSType" },
		Interface = { icon = SYMBOLS.lsp_symbols["Interface"], hl = "TSType" },
		Function = { icon = SYMBOLS.lsp_symbols["Function"], hl = "TSFunction" },
		Variable = { icon = SYMBOLS.lsp_symbols["Variable"], hl = "TSConstant" },
		Constant = { icon = SYMBOLS.lsp_symbols["Constant"], hl = "TSConstant" },
		String = { icon = SYMBOLS.lsp_symbols["String"], hl = "TSString" },
		Number = { icon = SYMBOLS.lsp_symbols["Number"], hl = "TSNumber" },
		Boolean = { icon = SYMBOLS.lsp_symbols["Boolean"], hl = "TSBoolean" },
		Array = { icon = SYMBOLS.lsp_symbols["Array"], hl = "TSConstant" },
		Object = { icon = SYMBOLS.lsp_symbols["Object"], hl = "TSType" },
		Key = { icon = SYMBOLS.lsp_symbols["Key"], hl = "TSType" },
		Null = { icon = SYMBOLS.lsp_symbols["Null"], hl = "TSType" },
		EnumMember = { icon = SYMBOLS.lsp_symbols["EnumMember"], hl = "TSField" },
		Struct = { icon = SYMBOLS.lsp_symbols["Struct"], hl = "TSType" },
		Event = { icon = SYMBOLS.lsp_symbols["Event"], hl = "TSType" },
		Operator = { icon = SYMBOLS.lsp_symbols["Operator"], hl = "TSOperator" },
		TypeParameter = { icon = SYMBOLS.lsp_symbols["TypeParameter"], hl = "TSParameter" },
	},
}

vim.cmd([[
  " NERDCommenter
  let g:NERDSpaceDelims = 1
  let g:NERDCompactSexyComs = 1

  " Vim-hexokinase
  let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba'
  " let g:Hexokinase_highlighters = ['foregroundfull']
]])
