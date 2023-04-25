local LAZY_BOOTSTRAP = pcall(require, "core.lazyInit")
local lazy

if LAZY_BOOTSTRAP then
	lazy = require("lazy")
else
	return false
end

-- Options
-- Docs: https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
-- TODO: Move these to core.lazyInit
local opts = {}

-- Plugins
-- Docs: https://github.com/folke/lazy.nvim#examples
local plugins = {
	-- [[ Common dependencies ]] --
	-------------------------------
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },
	-- NerdIcons
	{
		"kyazdani42/nvim-web-devicons",
		config = require("plugin.nvim-web-devicons"),
	},
	-- [[ Language Support ]] --
	----------------------------
	-- LSP Configuration & Plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim", -- Automatically install LSPs to stdpath for neovim
				config = true,
			},
			"williamboman/mason-lspconfig.nvim", -- Bridge plugin between mason and lspconfig
			{
				"j-hui/fidget.nvim", -- Useful status updates for LSP TODO: Explore settings
				opts = {},
			},
			"folke/neodev.nvim", -- Additional lua configuration
		},
	},
	-- Completion engine + sources
	{
		"hrsh7th/nvim-cmp",
		config = require("plugin.nvim-cmp"),
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-path", -- Path completions
			"hrsh7th/cmp-nvim-lua", -- Neovim API completions
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
			"L3MON4D3/LuaSnip", -- Snippet engine
			"rafamadriz/friendly-snippets", -- A bunch of snippets to use
		},
	},
	-- Treesitter for highlights and AST
	{
		"nvim-treesitter/nvim-treesitter",
		config = require("plugin.treesitter"),
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-context",
		},
	},
	-- Formatter and linter engine
	{ "jose-elias-alvarez/null-ls.nvim" },
	-- Show function signature while typing
	{ "ray-x/lsp_signature.nvim" },
	-- Nicer Rename
	{
		"CosmicNvim/cosmic-ui",
		config = require("plugin.cosmic-ui"),
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	-- Trouble
	-- TODO: Explore config
	{
		"folke/trouble.nvim",
		config = require("plugin.trouble"),
		dependencies = "nvim-web-devicons",
	},
	-- LSPSaga
	-- TODO: Explore config
	-- TODO: Add which LSP is throwing diagnostic to next/previous window
	{
		"glepnir/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
	},
	-- GoToDefinition previewer
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},
	-- Symbol outline tree
	{
		"simrat39/symbols-outline.nvim",
		config = require("plugin.symbols"),
	},
	-- TS/JS LSP improvements
	{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
	-- Mustache/Handlebars
	{ "mustache/vim-mustache-handlebars" },
	-- Helm
	{ "towolf/vim-helm" },
	-- Prisma
	{ "pantharshit00/vim-prisma" },

	-- [[ IDE Utilities ]] --
	-------------------------
	-- Telescope fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		config = require("plugin.telescope"),
		dependencies = {
			"nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
	},
	-- Floating terminal
	{
		"akinsho/nvim-toggleterm.lua",
		config = require("plugin.terminal"),
	},
	-- TODO: Try numToStr/Comment.nvim
	-- { "numToStr/Comment.nvim" , opts = {} },
	-- NERDCommenter for sweet block comment goodness
	{ "preservim/nerdcommenter" },
	-- General purpose async notifications
	-- TODO: Move to the bottom right
	{
		"rcarriga/nvim-notify",
		config = require("plugin.nvim-notify"),
	},
	-- Autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	-- b64.nvim
	{ "taybart/b64.nvim" },
	-- scope.nvim for hidding buffers in tabs
	{
		"tiagovla/scope.nvim",
		config = function()
			require("scope").setup()
		end,
	},
	-- Github Copilot
	{ "github/copilot.vim" },

	-- [[ Functional Aesthetics ]] --
	---------------------------------
	-- File tree with nerdicons
	{
		"kyazdani42/nvim-tree.lua",
		config = require("plugin.nvim-tree"),
	},
	-- Gitsigns for gutter + in-line blame
	{
		"lewis6991/gitsigns.nvim",
		config = require("plugin.gitsigns"),
	},
	-- Lualine --
	-- TODO: Add LSP info see https://github.com/nvim-lualine/lualine.nvim#screenshots
	-- FIXME: Use same symbols as SYMBOLS.diagnostic_signs
	-- TODO: Check feline-nvim/feline.nvim for inspiration
	-- TODO: Check https://github.com/windwp/windline.nvim
	{
		"nvim-lualine/lualine.nvim",
		config = require("plugin.lualine"),
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	-- Bufferline --
	{
		"akinsho/bufferline.nvim",
		config = require("plugin.bufferline"),
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	-- Dim inactive buffers --
	{
		"levouh/tint.nvim",
		config = require("plugin.tint"),
	},
	-- Indent lines --
	{
		"lukas-reineke/indent-blankline.nvim",
		config = require("plugin.indent-blankline"),
	},
	-- Dashboard --
	-- FIXME: Crashes
	-- {
	-- "goolord/alpha-nvim",
	-- config = require("plugin.alpha-nvim"),
	-- -- requires = "nvim-web-devicons",
	-- },
	-- Inline color display --
	{
		"rrethy/vim-hexokinase",
		event = "BufRead",
		build = "make hexokinase",
	},
	-- Nicer folds --
	{
		"anuvyklack/pretty-fold.nvim",
		config = require("plugin.pretty-fold"),
	},
	-- Diagnostics in scrollbar --
	{
		"petertriho/nvim-scrollbar",
		config = require("plugin.scrollbar"),
	},

	-- [[ Misc ]] --
	----------------
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

lazy.setup(plugins, opts)
