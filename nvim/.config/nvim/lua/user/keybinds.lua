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

-- Preview and UI
keymap("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts) -- ✓ Preview definition
keymap("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", opts) -- ✓ Close all previews
keymap("n", "grn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- ✓ Rename under cursor
keymap("n", "gl", "<cmd>Trouble diagnostics toggle<CR>", opts) -- ✓ Get workspace diagnostics
keymap("n", "gs", "<cmd>Outline<CR>", opts) -- ✓ Get document symbols (outline.nvim)

-- Note: LSP keybinds (K, <C-j>, <C-k>, [d, ]d, gr, ga, gD, gi, gt, gR) are configured in lsp-new/lspconfig.lua via LspAttach autocmd

-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

-- [[ Filepath Copy ]] --
-------------------------
-- Copy absolute path to clipboard with notification
vim.keymap.set("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Yanked: "' .. path .. '"', vim.log.levels.INFO, { timeout = 2000 })
end, { noremap = true, silent = true, desc = "Copy absolute path to clipboard" })

-- Copy relative path to clipboard with notification
vim.keymap.set("n", "<leader>yP", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify('Yanked: "' .. path .. '"', vim.log.levels.INFO, { timeout = 2000 })
end, { noremap = true, silent = true, desc = "Copy relative path to clipboard" })

-- [[ Git Navigation ]] --
--------------------------
-- Open PR for current line in browser
vim.keymap.set("n", "<leader>gb", function()
	require("user.functions").open_pr_for_line()
end, { noremap = true, silent = true, desc = "Open PR that merged current line" })

-- [[ Legacy config ]] --
-------------------------
-- NOTE: Just importing original config for now because I like the folding
vim.cmd([[
  runtime ./lua/user/keybinds.vim"
]])
