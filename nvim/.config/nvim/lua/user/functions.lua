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

-- LSP Symbols for outline tree
-- NOTE: This function was for the old symbols-outline plugin
-- Now using outline.nvim which has its own configuration in lua/plugins/outline.lua
-- M.outline_symbols = function()
-- 	Removed - no longer needed with outline.nvim
-- end

-- Telescope current buffer fuzzy finder
M.curr_buf = function()
	local opt = require("telescope.themes").get_dropdown({ height = 10, previewer = false })
	require("telescope.builtin").current_buffer_fuzzy_find(opt)
end

-- Gitsigns next hunk and preview
M.next_hunk_and_preview = function()
	local gitsigns = require("gitsigns")

	-- Close any existing preview window first
	vim.cmd("pclose")

	-- Store the current window to return focus later
	local main_win = vim.api.nvim_get_current_win()

	-- Always jump to the next hunk (including staged hunks)
	---@diagnostic disable-next-line: missing-fields
	gitsigns.nav_hunk("next", { target = "all" })

	-- Preview the hunk inline after a short delay
	vim.defer_fn(function()
		gitsigns.preview_hunk_inline()
		-- Return focus to the main window so subsequent calls work
		pcall(vim.api.nvim_set_current_win, main_win)
	end, 100)
end

-- Gitsigns previous hunk and preview
M.prev_hunk_and_preview = function()
	local gitsigns = require("gitsigns")

	-- Close any existing preview window first
	vim.cmd("pclose")

	-- Store the current window to return focus later
	local main_win = vim.api.nvim_get_current_win()

	-- Always jump to the previous hunk (including staged hunks)
	---@diagnostic disable-next-line: missing-fields
	gitsigns.nav_hunk("prev", { target = "all" })

	-- Preview the hunk inline after a short delay
	vim.defer_fn(function()
		gitsigns.preview_hunk_inline()
		-- Return focus to the main window so subsequent calls work
		pcall(vim.api.nvim_set_current_win, main_win)
	end, 100)
end

-- Toggle TodoTrouble with focus
M.toggle_todo_trouble = function()
	local trouble_win
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "trouble" then
			trouble_win = win
			break
		end
	end

	if not trouble_win then
		vim.cmd("Trouble todo toggle focus=true")
	elseif vim.api.nvim_get_current_win() == trouble_win then
		vim.cmd("Trouble close")
	else
		vim.api.nvim_set_current_win(trouble_win)
	end
end

-- Toggle AI completion providers
M.toggle_ai_provider = function(provider)
	local cmp = require("cmp")
	local config = cmp.get_config()
	local sources = config.sources or {}

	-- Find the provider source
	local found = false
	for i, source in ipairs(sources) do
		if source.name == provider then
			-- Remove the source
			table.remove(sources, i)
			found = true
			print(provider .. " disabled")
			break
		end
	end

	-- If not found, add it back at the beginning
	if not found then
		table.insert(sources, 1, { name = provider })
		print(provider .. " enabled")
	end

	-- Update the config
	cmp.setup({ sources = sources })
end

M.enable_minuet = function()
	M.toggle_ai_provider("minuet")
end

M.disable_minuet = function()
	M.toggle_ai_provider("minuet")
end

M.enable_codeium = function()
	M.toggle_ai_provider("codeium")
end

M.disable_codeium = function()
	M.toggle_ai_provider("codeium")
end

-- Open PR that merged the current line in browser
M.open_pr_for_line = function()
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")

	-- Get the commit hash for the current line
	local blame_output = vim.fn.systemlist(string.format("git blame -L %d,%d --porcelain %s", line, line, file))
	if vim.v.shell_error ~= 0 or #blame_output == 0 then
		vim.notify("Failed to run git blame", vim.log.levels.ERROR)
		return
	end

	local commit_hash = blame_output[1]:match("^(%x+)")
	if not commit_hash or commit_hash:match("^0+$") then
		vim.notify("Line not yet committed", vim.log.levels.WARN)
		return
	end

	-- Get commit message and parse for PR number
	local commit_msg = vim.fn.systemlist(string.format("git log -1 --pretty=%%B %s", commit_hash))
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to get commit message", vim.log.levels.ERROR)
		return
	end

	local pr_num = nil
	for _, msg_line in ipairs(commit_msg) do
		pr_num = msg_line:match("#(%d+)") or msg_line:match("pull request #?(%d+)")
		if pr_num then
			break
		end
	end

	-- Get remote URL
	local remote_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
	if not remote_url then
		vim.notify("Could not get remote URL", vim.log.levels.ERROR)
		return
	end

	-- Convert git URL to HTTPS URL
	local https_url = remote_url
		:gsub("^ssh://git@github%.com/", "https://github.com/") -- Handle ssh://git@github.com/
		:gsub("^git@github%.com:", "https://github.com/") -- Handle git@github.com:
		:gsub("%.git$", "") -- Remove .git suffix

	local url
	local message
	if pr_num then
		-- Open PR if found
		url = https_url .. "/pull/" .. pr_num
		message = "Opening PR #" .. pr_num .. " for commit " .. commit_hash:sub(1, 7)
	else
		-- Fallback to commit URL
		url = https_url .. "/commit/" .. commit_hash
		message = "Opening commit " .. commit_hash:sub(1, 7) .. " (no PR found)"
	end

	-- Open the URL in browser
	vim.fn.system(string.format("open '%s'", url))
	vim.notify(message, vim.log.levels.INFO, { timeout = 2000 })
end

return M
