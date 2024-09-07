-- Plugins
-- Docs: https://github.com/folke/lazy.nvim#examples
local common = {
	-- [[ Common dependencies ]] --
	-------------------------------
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },
	-- NerdIcons
	{
		"nvim-tree/nvim-web-devicons",
		config = require("plugins.nvim-web-devicons"),
	},
}

local ide = {
	-- [[ IDE Utilities ]] --
	-------------------------
	-- Telescope fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		config = require("plugins.telescope"),
		dependencies = {
			"nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
	},
	-- Floating terminal
	{
		"akinsho/nvim-toggleterm.lua",
		config = require("plugins.terminal"),
	},
	-- File tree with nerdicons
	{
		"nvim-tree/nvim-tree.lua",
		config = require("plugins.nvim-tree"),
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
	-- LSPSaga
	{
		"glepnir/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
	},
	-- Symbol outline tree
	{
		"simrat39/symbols-outline.nvim",
		config = require("plugins.symbols"),
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
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = require("plugins.treesitter"),
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
		},
	},
	-- Helm file detection
	{ "towolf/vim-helm" },
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
	-- b64.nvim
	{ "taybart/b64.nvim" },
	-- NERDCommenter for sweet block comment goodness
	{ "preservim/nerdcommenter" },
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
	-- General purpose async notifications
	{
		"rcarriga/nvim-notify",
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
			"kyazdani42/nvim-web-devicons",
		},
	},
	-- Bufferline --
	{
		"akinsho/bufferline.nvim",
		config = require("plugins.bufferline"),
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	-- Dim inactive buffers --
	{
		"levouh/tint.nvim",
		config = require("plugins.tint"),
	},
	-- Indent lines --
	{
		"lukas-reineke/indent-blankline.nvim",
		config = require("plugins.indent-blankline"),
	},
	-- Dashboard --
	-- FIXME: Crashes
	-- {
	-- "goolord/alpha-nvim",
	-- config = require("plugins.alpha-nvim"),
	-- -- requires = "nvim-web-devicons",
	-- },
	-- Inline color display --
	{
		"rrethy/vim-hexokinase",
		event = "BufRead",
		build = "make hexokinase",
	},
	-- Diagnostics in scrollbar --
	{
		"petertriho/nvim-scrollbar",
		config = require("plugins.scrollbar"),
	},
	-- Show function signature while typing
	{ "ray-x/lsp_signature.nvim" },
	-- Nicer Rename
	{
		"CosmicNvim/cosmic-ui",
		config = require("plugins.cosmic-ui"),
		dependencies = { "MunifTanjim/nui.nvim" },
	},
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
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = require("lsp-new.lspconfig"),
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = require("lsp-new.mason"),
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
