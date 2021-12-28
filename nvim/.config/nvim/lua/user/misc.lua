-- [[ MISCELLANEOUS ]] --
-------------------------
-- Colorscheme
vim.cmd "colorscheme palenight"

-- LSP Symbol Highlights (see :h vim.lsp.buf.document_highlight)
-- TODO: Use vim.api.nvim_set_hl() instead (see https://github.com/tiagovla/tokyodark.nvim/blob/230a6d0cd40692e4bd763623d1ce5671b7c4f150/lua/tokyodark/highlights.lua)
vim.cmd([[
  hi LspReferenceRead gui=italic,underline cterm=italic,underline guifg=#fde016
  hi LspReferenceText gui=italic,underline cterm=italic,underline guifg=#fde016
  hi LspReferenceWrite gui=italic,underline cterm=italic,underline guifg=#fde016
]])

-- Make the cursorline brighter
vim.cmd([[
  hi CursorLine term=bold cterm=bold guibg=#1b1f27
]])

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
