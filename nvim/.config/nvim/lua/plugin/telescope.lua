-- Folding doesn't work when opening anything via Telescope for some reason
-- so overriding a bunch of builtins to fix it
-- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-934727312

-- syntax adapted from https://github.com/martinsione/dotfiles

return function()
	local installed, telescope = pcall(require, "telescope")
	if not installed then
		return
	end

	-- [[ Imports for convenience ]] --
	local actions = require("telescope.actions")
	local pickers = require("telescope.pickers")
	local previewers = require("telescope.previewers")
	local builtin = require("telescope.builtin")
	local actions_set = require("telescope.actions.set")

	local fixfolds = {
		hidden = true,
		attach_mappings = function(_)
			actions_set.select:enhance({
				post = function()
					vim.cmd(":normal! zx")
				end,
			})
			return true
		end,
	}

	-- [[ Main telescope config ]] --
	telescope.setup({
		defaults = {
			prompt_prefix = SYMBOLS.misc.search .. " ",
			selection_caret = SYMBOLS.misc.selector .. " ",
			layout_config = {
				height = 0.9,
				width = 0.75,
				preview_cutoff = 120,
				prompt_position = "top",
			},
			sorting_strategy = "ascending",
			path_display = { shorten = 5 },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,

			file_sorter = require("telescope.sorters").get_fzy_sorter,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

			vimgrep_arguments = {
				"ag",
				"--hidden",
				"--nocolor",
				"--noheading",
				"--filename",
				"--numbers",
				"--column",
				"--smart-case",
			},
			file_ignore_patterns = {
				"^.git/",
				"go.sum",
				"go.mod",
				"package-lock.json",
				"yarn.lock",
			},
			mappings = {
				i = {
					["<cr>"] = actions.select_default + actions.center,
					-- Disable default vertical/horizontal selectors
					-- ["<C-X>"] = false,
					["<C-V>"] = false,
					-- Normalise vertical/horizontal split
					-- ["<C-I>"] = actions.select_horizontal,
					["<C-S>"] = actions.select_vertical,
				},
			},
		},
		pickers = {
			find_files = fixfolds,
			buffers = fixfolds,
			git_files = fixfolds,
			grep_string = fixfolds,
			live_grep = fixfolds,
			oldfiles = fixfolds,
			-- find_files = {
			-- find_command = { "fd", "--type=file", "--hidden" }
			-- }
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			},
			file_browser = {
				-- theme = "dropdown",
			},
		},
	})
	require("telescope").load_extension("fzy_native")
	require("telescope").load_extension("file_browser")
end
