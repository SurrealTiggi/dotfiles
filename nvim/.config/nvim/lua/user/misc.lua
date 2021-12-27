-- [[ MISCELLANEOUS ]] --
-------------------------
-- Colorscheme
vim.cmd "colorscheme palenight"

-- Random plugin settings
vim.cmd([[
  " NERDCommenter
  let g:NERDSpaceDelims = 1
  let g:NERDCompactSexyComs = 1

  " Vim-hexokinase
  let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba'
  " let g:Hexokinase_highlighters = ['foregroundfull']
]])

-- Show off animoo background
-- FIXME: Disabled as inactive buffer dimming doesn't work as well with this
-- vim.cmd([[
  -- hi Normal     guibg=NONE ctermbg=NONE
  -- hi LineNr     ctermbg=NONE guibg=NONE
  -- hi SignColumn ctermbg=NONE guibg=NONE
-- ]])
