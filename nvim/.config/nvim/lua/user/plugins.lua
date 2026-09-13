-- Plugins
-- Docs: https://github.com/folke/lazy.nvim#examples
local common = {
	-- [[ Common dependencies ]] --
	-------------------------------
	{ "nvim-lua/plenary.nvim" },
	-- NerdIcons
	{
		"nvim-tree/nvim-web-devicons",
		config = require("plugins.nvim-web-devicons"),
	},
}

local ide = {
	-- [[ IDE Utilities ]] --
	-------------------------
	-- Telescope fuzzy finder (replaced with snacks.picker)
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
		config = require("plugins.telescope"),
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},
	},
	-- Floating terminal
	{
		"akinsho/nvim-toggleterm.lua",
		config = require("plugins.terminal"),
	},
	-- Snacks.nvim - Collection of useful utilities
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = function()
			local git_symbols = SYMBOLS.git_symbols.git
			return {
				-- Enable the modules you want to use
				explorer = {
					enabled = true,
					icons = {
						git = {
							unstaged = git_symbols.unstaged,
							staged = git_symbols.staged,
							unmerged = git_symbols.unmerged,
							renamed = git_symbols.renamed,
							untracked = git_symbols.untracked,
							deleted = git_symbols.deleted,
							ignored = git_symbols.ignored,
						},
					},
				},
				picker = {
					enabled = true,
					-- Global picker keymaps (applies to all pickers)
					win = {
						input = {
							keys = {
								["<c-s>"] = { "edit_vsplit", mode = { "i", "n" } }, -- Vertical split
								["<c-x>"] = { "edit_split", mode = { "i", "n" } }, -- Horizontal split
								["<c-t>"] = { "tab", mode = { "i", "n" } }, -- New tab
							},
						},
						list = {
							keys = {
								["<c-s>"] = "edit_vsplit", -- Vertical split
								["<c-x>"] = "edit_split", -- Horizontal split
								["<c-t>"] = "tab", -- New tab
							},
						},
					},
					sources = {
						files = {
							hidden = true, -- Show hidden files/folders
							follow = true, -- Follow symlinks
						},
						grep = {
							hidden = true, -- Search in hidden files/folders
						},
						recent = {
							hidden = true, -- Show hidden files in recent files
						},
						git_log = {
							hidden = true, -- Include commits from hidden files
						},
						git_log_file = {
							hidden = true, -- Include commits from hidden files
						},
						git_branches = {
							-- No hidden option needed for branches
						},
						explorer = {
							hidden = true, -- Show hidden files by default
							win = {
								list = {
									keys = {
										-- Override split keymaps to match nvim-tree behavior
										["<c-s>"] = "edit_vsplit", -- Vertical split
										["<c-x>"] = "edit_split", -- Horizontal split
										["<c-t>"] = "tab", -- New tab
										-- Add toggle behavior
										["<c-n>"] = "close",
										["q"] = "close",
										-- File operations matching nvim-tree
										["a"] = "explorer_add",
										["c"] = "explorer_copy",
										["x"] = "explorer_cut",
										["p"] = "explorer_paste",
										-- Page navigation (simulate with repeated key presses)
										["<PageUp>"] = function()
											local count = 6
											vim.cmd("normal! " .. count .. "k")
										end,
										["<PageDown>"] = function()
											local count = 6
											vim.cmd("normal! " .. count .. "j")
										end,
										-- Keep Ctrl+u/d as full page scroll
										["<C-u>"] = "list_scroll_up",
										["<C-d>"] = "list_scroll_down",
									},
								},
							},
							-- Auto-close on file open
							follow = false,
							auto_close = true,
						},
					},
				},
				notifier = {
					enabled = true,
				},
				bigfile = {
					enabled = true,
				},
				quickfile = {
					enabled = true,
				},
				statuscolumn = {
					enabled = true,
				},
			}
		end,
		keys = {
			{
				"<C-n>",
				function()
					local snacks = require("snacks")
					-- Simple toggle: if any explorer buffer exists and is visible, close all windows, else open
					local found = false
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
						if ft == "snacks_explorer" then
							vim.api.nvim_win_close(win, false)
							found = true
						end
					end
					if not found then
						snacks.explorer.open()
					end
				end,
				desc = "Toggle Snacks Explorer",
			},

			{
				"<C-p>",
				function()
					require("snacks").picker.files()
				end,
				desc = "Find Files (Snacks)",
			},
			{
				"<C-h>",
				function()
					require("snacks").picker.recent()
				end,
				desc = "Recent Files (Snacks)",
			},
			{
				"<C-f>",
				function()
					require("snacks").picker.grep()
				end,
				desc = "Live Grep (Snacks)",
			},
		},
	},
	-- File tree with nerdicons (keeping as backup, now using snacks.explorer)
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false, -- Disabled in favor of snacks.explorer
		config = require("plugins.nvim-tree"),
	},
	-- Oil.nvim - Edit filesystem like a buffer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = false, -- Keep nvim-tree as default
				columns = {
					"icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-v>"] = "actions.select_vsplit",
					["<C-s>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-r>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
				},
				use_default_keymaps = true,
				view_options = {
					show_hidden = false,
				},
			})
		end,
	},
	-- Yazi.nvim - Terminal file manager integration
	-- NOTE: Avoid hovering over images - causes terminal color errors and popups
	-- If it happens, just press q to quit yazi and reopen
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ll",
				"<cmd>Yazi<cr>",
				desc = "Open yazi",
			},
		},
		opts = {
			open_file_function = function(chosen_file)
				-- Change directory when entering a folder
				if vim.fn.isdirectory(chosen_file) == 1 then
					vim.cmd("cd " .. vim.fn.fnameescape(chosen_file))
					-- Update nvim-tree if it's loaded
					local ok, api = pcall(require, "nvim-tree.api")
					if ok then
						api.tree.change_root(chosen_file)
					end
					vim.notify("Changed directory to: " .. chosen_file, vim.log.levels.INFO)
				else
					vim.cmd("edit " .. vim.fn.fnameescape(chosen_file))
				end
			end,
			keymaps = {
				open_file_in_vertical_split = "<c-v>",
				open_file_in_horizontal_split = "<c-s>",
				open_file_in_tab = "<c-t>",
			},
		},
	},
	-- Gitsigns for gutter + in-line blame
	{
		"lewis6991/gitsigns.nvim",
		config = require("plugins.gitsigns"),
	},
	-- Trouble
	{
		"folke/trouble.nvim",
		opts = {
			focus = true,
		},
		config = require("plugins.trouble"),
		dependencies = "nvim-web-devicons",
	},
	-- Symbol outline tree (modern fork of symbols-outline)
	{
		"hedyhli/outline.nvim",
		config = require("plugins.outline"),
	},
}

local languages = {
	-- [[ Language Support ]] --
	----------------------------
	-- Completion engine + sources
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = require("plugins.nvim-cmp"),
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-path", -- Path completions
			"hrsh7th/cmp-nvim-lua", -- Neovim API completions
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"onsails/lspkind.nvim", -- vs-code like pictograms
			-- "saadparwaiz1/cmp_luasnip", -- Snippet completions
			-- "rafamadriz/friendly-snippets", -- A bunch of snippets to use
		},
	},
	-- Treesitter for highlights and AST
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = require("plugins.treesitter"),
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
		},
	},
	-- Helm file detection
	{ "towolf/vim-helm" },
	-- Markdown rendering in-buffer
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			heading = {
				enabled = true,
				sign = true,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
			code = {
				enabled = true,
				sign = true,
				style = "full",
				width = "block",
			},
			checkbox = {
				enabled = true,
				checked = { icon = "󰄬 " },
				unchecked = { icon = "󰄱 " },
			},
		},
	},
}

local formatter = {
	-- [[ File Formatters ]] --
	---------------------------
	-- Autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = require("plugins.conform"),
	},
	-- Formatter and linter engine
	{ "nvimtools/none-ls.nvim" },
}

local utils = {
	-- [[ Utilities ]] --
	---------------------
	-- Codeium
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_chat = true,
			})
		end,
	},
	-- Minuet AI - LLM completion (Claude, GPT, Gemini, etc.)
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = {
			"nvim-cmp",
		},
		config = function()
			require("minuet").setup({
				provider = "claude",
				provider_options = {
					claude = {
						model = "claude-sonnet-5",
						max_tokens = 512,
					},
				},
				-- Customize the system prompt using the template structure
				-- This uses the default template but with custom guidelines
				system = {
					-- Use the default suffix-first template structure
					template = "{{{prompt}}}\n{{{guidelines}}}\n{{{n_completion_template}}}",
					guidelines = "You are an expert coding assistant. Provide concise, accurate code completions.",
				},
				-- Throttle to manage API costs
				throttle = 1000, -- Wait 1s between requests
				-- Debounce to avoid too many requests while typing
				debounce = 500,
				-- Optional: add context lines for better completions
				n_completions = 1,
				-- Stream for faster feedback
				stream = true,
			})
		end,
	},
	-- b64.nvim
	{ "taybart/b64.nvim" },
	-- SOPS for secrets
	{
		"diogo464/sops.nvim",
		opts = {},
	},
	-- NERDCommenter for sweet block comment goodness
	{ "preservim/nerdcommenter" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
		keys = {
			{
				"<leader>td",
				function()
					require("user.functions").toggle_todo_trouble()
				end,
				desc = "Toggle Todo (Trouble)",
			},
			{ "<leader>tt", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
		},
		config = function()
			require("todo-comments").setup({})
		end,
	},
	-- GoToDefinition previewer
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},
	-- TODO: Try numToStr/Comment.nvim
	-- { "numToStr/Comment.nvim" , opts = {} },
}

local aesthetics = {
	-- [[ Functional Aesthetics ]] --
	---------------------------------
	-- General purpose async notifications (now using snacks.notifier)
	{
		"rcarriga/nvim-notify",
		enabled = false,
		config = require("plugins.nvim-notify"),
	},
	-- scope.nvim for hidding buffers in tabs
	{
		"tiagovla/scope.nvim",
		config = function()
			require("scope").setup()
		end,
	},
	-- Lualine --
	-- TODO: Add LSP info see https://github.com/nvim-lualine/lualine.nvim#screenshots
	-- FIXME: Use same symbols as SYMBOLS.diagnostic_signs
	-- TODO: Check feline-nvim/feline.nvim for inspiration
	-- TODO: Check https://github.com/windwp/windline.nvim
	{
		"nvim-lualine/lualine.nvim",
		config = require("plugins.lualine"),
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- Bufferline --
	{
		"akinsho/bufferline.nvim",
		config = require("plugins.bufferline"),
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- Dim inactive buffers --
	-- {
	-- "levouh/tint.nvim",
	-- config = require("plugins.tint"),
	-- },
	-- Indent lines --
	{
		"lukas-reineke/indent-blankline.nvim",
		config = require("plugins.indent-blankline"),
	},
	-- Inline color display (modern, no build required)
	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufRead",
		config = function()
			require("nvim-highlight-colors").setup({
				render = "background", -- 'background', 'foreground', 'virtual'
				enable_named_colors = true,
				enable_tailwind = true,
			})
		end,
	},
	-- Diagnostics in scrollbar --
	{
		"petertriho/nvim-scrollbar",
		config = require("plugins.scrollbar"),
	},
	-- Show function signature while typing
	{ "ray-x/lsp_signature.nvim" },
	-- Colorschemes
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{ "folke/tokyonight.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "christianchiarulli/nvcode-color-schemes.vim" },
}

local lsp = {
	{
		"williamboman/mason.nvim",
		lazy = false, -- Load immediately
		priority = 100, -- Load before other plugins
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = require("lsp-new.mason"),
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false, -- Load immediately so mason can configure it
		priority = 99, -- Load right after mason
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = require("lsp-new.lspconfig"),
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
			"leoluz/nvim-dap-go",
		},
		config = require("plugins.dap"),
	},
}

-- Options
-- Docs: https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
local opts = {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
}

require("lazy").setup({
	common,
	ide,
	languages,
	formatter,
	utils,
	aesthetics,
	lsp,
}, opts)
