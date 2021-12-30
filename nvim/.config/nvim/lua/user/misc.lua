-- [[ MISCELLANEOUS ]] --
-------------------------
-- Set nvim-notify as main notifier
-- TODO: Explore nvim-notify documentation
vim.notify = require("notify")

-- Colorscheme
vim.cmd "colorscheme palenight"
-- vim.cmd "colorscheme aurora"

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
vim.cmd([[
  " NERDCommenter
  let g:NERDSpaceDelims = 1
  let g:NERDCompactSexyComs = 1

  " Vim-hexokinase
  let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba'
  " let g:Hexokinase_highlighters = ['foregroundfull']
]])
