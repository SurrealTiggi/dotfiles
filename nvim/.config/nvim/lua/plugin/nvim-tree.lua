return function()
	local g = vim.g

	-- g.nvim_tree_quit_on_open = 1
	g.nvim_tree_width_allow_resize = 1

	g.nvim_tree_show_icons = {
		git = 1,
		folders = 1,
		files = 1,
	}

	g.nvim_tree_special_files = "" -- Don't highlight any files

	-- Purely for aesthetics
	g.nvim_tree_icons = SYMBOLS.git_symbols

	require("nvim-tree").setup({
		git = {
			ignore = true, -- Hide any files specified in .gitignore
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
			hide_root_folder = true,
			width = 35,
			auto_resize = true,
			mappings = {
				list = {
					{ key = "<C-s>", action = "vsplit" },
					{ key = "<C-i>", action = "split" },
					{ key = "<C-t>", action = "tabnew" },
					{ key = "I", action = "toggle_git_ignored" },
					{ key = "H", action = "toggle_dotfiles" },
				},
			},
		},
		renderer = {
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
