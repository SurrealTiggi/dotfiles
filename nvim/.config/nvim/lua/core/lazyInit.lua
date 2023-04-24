local lazy_url = "https://github.com/folke/lazy.nvim.git"
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
	vim.notify("Installing plugin manager lazy.nvim...")

	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazy_url,
		lazy_path,
	})

	installed, lazy = pcall(require, "lazy")

	if installed then
		vim.notify("Plugin manager lazy.nvim installed successfully!")
	else
		vim.notify("Failed to install plugin manager lazy.nvim!\nLazy path: " .. lazy_path .. "\nOutput: " .. out)
	end
end

vim.opt.rtp:prepend(lazy_path)
