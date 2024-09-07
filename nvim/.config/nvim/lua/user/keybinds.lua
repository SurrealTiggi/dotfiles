-- [[ KEYBINDS ]] --
--------------------
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Set leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Code Navigation ]] --
---------------------------
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- ✓ Go to definition

-- TODO: Double check these
keymap("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts) -- ✓ Preview definition
keymap("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", opts) -- ✓ Close all previews
keymap("n", "grn", "<cmd>lua require('cosmic-ui').rename()<CR>", opts) -- ✓ Rename under cursor
keymap("n", "gl", "<cmd>Trouble diagnostics toggle<CR>", opts) -- ✓ Get workspace diagnostics
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- ✓ Hoverdoc
keymap("n", "<C-j>", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- ✓ Next diagnostic
keymap("n", "<C-k>", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- ✓ Previous diagnostic
keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts) -- ✓ Get references
-- TODO: Show lightbulb in gutter when a code-action is available
keymap("n", "ga", "<cmd>Lspsaga code_action<CR>", opts) -- ✓ Code actions
keymap("n", "gs", "<cmd>SymbolsOutline<CR>", opts) -- ✓ Get document symbols

-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

-- [[ Legacy config ]] --
-------------------------
-- NOTE: Just importing original config for now because I like the folding
vim.cmd([[
  runtime ./lua/user/keybinds.vim"
]])
