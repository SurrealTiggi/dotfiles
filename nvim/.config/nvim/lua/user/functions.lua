-- [[ GLOBAL UTILITY FUNCTIONS ]] --
------------------------------------
-- Easy folding
vim.cmd([[
  function! ToggleFold()
       if &foldlevel >= 20
           "normal! zM<CR> (folds all)
           set foldlevel=0
       else
           "normal! zR<CR> (unfolds everything)
           set foldlevel=20
       endif
  endfunction
]])

-- Refresh NvimTree on open
vim.cmd([[
  function! NvimTreeToggleAndRefresh()
    :NvimTreeToggle
    :NvimTreeRefresh
  endfunction
]])
