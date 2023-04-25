return function()
	local g = vim.g

	-- NOTE: https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach
	local function on_attach(bufnr)
		local api = require("nvim-tree.api")

		-- Global options
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		-- -- Keymaps
		vim.keymap.set("n", "<C-s>", api.node.open.vertical, opts("Open: Vertical Split"))
		vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
		vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
		vim.keymap.set("n", "a", api.fs.create, opts("Create"))
		vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
		vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
		vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
		vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
		vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
		vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
		vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
		vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	end

	-- g.nvim_tree_quit_on_open = 1
	-- g.nvim_tree_width_allow_resize = 1

	require("nvim-tree").setup({
		on_attach = on_attach,
		git = {
			ignore = true, -- Hide any files specified in .gitignore
		},
		filesystem_watchers = { -- Disabling since it's not refreshing the tree as intented *shrug*
			enable = false,
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		hijack_cursor = true,
		diagnostics = {
			enable = false,
		},
		view = {
			width = 35,
			adaptive_size = true,
		},
		renderer = {
			root_folder_label = false,
			icons = {
				glyphs = SYMBOLS.git_symbols,
				show = {
					git = true,
					folder = true,
					file = true,
				},
			},
			special_files = {}, -- Don't highlight any files
			indent_markers = {
				enable = true,
			},
		},
		filters = {
			dotfiles = false,
			custom = {
				"\\~$",
				"bower_components",
				"node_modules",
				".cache",
				"__pycache__",
				".pytest_cache",
				".mypy_cache",
				"^.vim$",
				".DS_Store",
				".terragrunt-cache",
				".git$",
				".aws-sam",
				"dist",
				"resources$[[dir]]",
				"go.sum",
				"build$[[dir]]",
				"bin$[[dir]]",
				"yarn.lock",
				".nuxt$[[dir]]",
				".next$[[dir]]",
			},
			exclude = {
				"nvim",
			},
		},
	})
end
