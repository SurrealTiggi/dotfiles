-- [[ AUTOCOMMANDS ]] --
---------------------------------------
-- Reload neovim whenever plugins file changes
-- vim.cmd([[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- augroup end
-- ]])

-- Automatically reload current file if buffer changes
vim.cmd([[
  augroup refresh_buffer
    autocmd!
    autocmd FocusGained,BufEnter * :checktime
  augroup END
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
  augroup rescan_ts_js_buffer
    autocmd!
    autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
    autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
  augroup END
]])

-- Disable completion in navigator floating windows
vim.cmd([[
  augroup navigator_no_cmp
    autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
    autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }
  augroup END
]])

-- Terraform
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

-- JSONNET
vim.cmd([[autocmd BufRead,BufNewFile *.libsonnet set filetype=jsonnet]])

-- Load vim-dadbod-completion for SQL files
-- TODO: not installed yet
-- vim.cmd([[
-- augroup DadBodSQL
-- au!
-- autocmd FileType sql,mysql,plsql lua require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
-- augroup END
-- ]])
