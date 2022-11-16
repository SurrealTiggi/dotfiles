-- [[ GLOBAL UTILITY FUNCTIONS ]] --
------------------------------------

-- [[ Vim functions ]] --
-------------------------
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
    lua require'user.functions'.nvim_toggle()
  endfunction
]])

-- [[ Lua functions ]] --
-------------------------
-- General purpose util function table
local M = {}

-- NvimTree conditional toggle if a buffer is open or not
M.nvim_toggle = function()
	local nvim_tree = require("nvim-tree")
	local nvim_tree_actions = require("nvim-tree.actions.reloaders.reloaders")
	local b = vim.api.nvim_buf_get_name(0)

	if b == nil or b == "" then
		nvim_tree.toggle(false)
	else
		nvim_tree.toggle(true)
	end
	nvim_tree_actions.reload_explorer()
end

-- LSP Symbols for outline tree
M.outline_symbols = function()
	local installed, pkg_symbols = pcall(require, "symbols-outline.config")
	if not installed then
		return
	end

	local outline_symbols = {}

	-- FIXME: For some reason this object is nil until *everything* is initiaised...
	-- see https://github.com/simrat39/symbols-outline.nvim/issues/19
	for type, definition in pairs(pkg_symbols.options.symbols) do
		local my_def = { hl = definition.hl, icon = SYMBOLS.lsp_symbols[type] or definition.icon }
		outline_symbols[type] = my_def
	end

	return outline_symbols
end

-- Telescope current buffer fuzzy finder
M.curr_buf = function()
	local opt = require("telescope.themes").get_dropdown({ height = 10, previewer = false })
	require("telescope.builtin").current_buffer_fuzzy_find(opt)
end

return M
