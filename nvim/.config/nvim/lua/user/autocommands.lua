-- [[ AUTOCOMMANDS ]] --
---------------------------------------
-- Reload neovim whenever plugins file changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Automatically reload current file if buffer changes
vim.cmd([[
  au FocusGained,BufEnter * :checktime
]])

-- vimrc folding (https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file)
vim.cmd([[
  augroup fold_vimrc
    autocmd!
    autocmd FileType vim
                        \ setlocal foldmethod=expr |
                        \ set fde=getline(v\:lnum)=~'^\"\"'?'>'.(matchend(getline(v\:lnum),'\"\"*')-1)\:'='
  augroup END
]])

-- Use treesitter for folding if possible
vim.cmd([[
  augroup fold_go
    autocmd!
    autocmd FileType go,python setlocal foldmethod=expr | set fde=nvim_treesitter#foldexpr()
  augroup END
]])

-- Force a rescan for js/ts buffers
vim.cmd([[
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
]])
