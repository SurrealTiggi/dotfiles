-- Folding doesn't work when opening anything via Telescope for some reason
-- so overriding a bunch of builtins to fix it
-- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-934727312

-- syntax adapted from https://github.com/martinsione/dotfiles

return function()
	local installed, telescope = pcall(require, "telescope")
	if not installed then
		return
	end

	-- Imports for convenience
	local actions = require("telescope.actions")
	local pickers = require("telescope.pickers")
	local previewers = require("telescope.previewers")
	local builtin = require("telescope.builtin")
	local actions_set = require("telescope.actions.set")
	local fb_actions = require("telescope").extensions.file_browser.actions

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

	-- Disable folding in Telescope buffers
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "TelescopeResults", "TelescopePrompt" },
		callback = function()
			vim.opt_local.foldenable = false
			vim.opt_local.foldmethod = "manual"
		end,
	})

	-- [[ Main telescope config ]] --
	telescope.setup({
		path_display = { shorten = 5 },
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
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,

			file_sorter = require("telescope.sorters").get_fzy_sorter,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",          -- Search hidden files
				"--glob=!.git/",     -- But exclude .git directory
			},
			file_ignore_patterns = {
				"%.terraform/",
				"%.git/",
				"go%.sum$",
				"go%.mod$",
				"package%-lock%.json$",
				"yarn%.lock$",
				"poetry%.lock$",
				"lazy%-lock%.json$",
			},
			mappings = {
				i = {
					-- ["<Right>"] = actions.select_default,
					-- Disable default vertical/horizontal selectors
					-- ["<C-X>"] = false,
					["<C-V>"] = false,
					-- Normalise vertical/horizontal split
					-- ["<C-x>"] = actions.select_horizontal,
					["<C-S>"] = actions.select_vertical,
					["<S-i>"] = fb_actions.toggle_hidden,
				},
			},
		},
		pickers = {
			find_files = vim.tbl_extend("force", fixfolds, {
				hidden = true,
				no_ignore = false,
				follow = true,
			}),
			buffers = fixfolds,
			git_files = fixfolds,
			grep_string = fixfolds,
			live_grep = fixfolds,
			oldfiles = fixfolds,
			lsp_references = vim.tbl_extend("force", fixfolds, {
				initial_mode = "normal",
				show_line = false,
			}),
			git_bcommits = vim.tbl_extend("force", fixfolds, {
				git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "--format=%h %s - %an (%cr)" },
			}),
			git_commits = vim.tbl_extend("force", fixfolds, {
				git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "--format=%h %s - %an (%cr)" },
			}),
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			file_browser = {
				-- theme = "dropdown",
			},
		},
	})
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("file_browser")
	-- Removed notify extension (now using snacks.notifier)
	-- require("telescope").load_extension("notify")
end
