-- Ensure plugin manager is installed
local PACKER_BOOTSTRAP, _ = pcall(require, "core.packerInit")
local packer

if PACKER_BOOTSTRAP then
  packer = require "packer"
else
  return false
end

local use = packer.use

-- Plugins
-- Docs: https://github.com/wbthomason/packer.nvim#specifying-plugins
return packer.startup(
  function()
    -- [[ Plugin manager ]] --
    --------------------------
    use { "wbthomason/packer.nvim" }

    -- [[ Common dependencies ]] --
    -------------------------------
    use { "nvim-lua/plenary.nvim" }
    use { "nvim-lua/popup.nvim" }
    -- NerdIcons
    use {
      "kyazdani42/nvim-web-devicons",
      config = require("plugin.nvim-web-devicons"),
    }
    --  Ensures we run ftplugin/*.lua at the right time
    use { "tjdevries/astronauta.nvim" , commit = "e69d7bdc4183047c4700427922c4a3cc1e3258c6" }

    -- [[ Language Support ]] --
    ----------------------------
    -- TODO: lspsaga, lsp_signature, nvim-lsp-ts-utils
    -- Built-in LSP
    use { "neovim/nvim-lspconfig" }
    -- Simple LSP installer
    use { "williamboman/nvim-lsp-installer" }
    -- Completion engine + sources
    use {                                   -- Main engine
      "hrsh7th/nvim-cmp",
      config = require("plugin.nvim-cmp")
    }
    use { "hrsh7th/cmp-buffer" }            -- Buffer completions
    use { "hrsh7th/cmp-path" }              -- Path completions
    use { "saadparwaiz1/cmp_luasnip" }      -- Snippet completions
    use { "hrsh7th/cmp-nvim-lsp" }          -- LSP completions
    use { "hrsh7th/cmp-nvim-lua" }          -- Neovim API completions
    -- Snippets
    use { "L3MON4D3/LuaSnip" }              -- Snippet engine
    use { "rafamadriz/friendly-snippets" }  -- A bunch of snippets to use
    -- Treesitter for highlights and AST
    use {
      "nvim-treesitter/nvim-treesitter",
      config = require("plugin.treesitter"),
      run = ":TSUpdate"
    }
    use { "nvim-treesitter/playground" }

    -- [[ IDE Utilities ]] --
    -------------------------
    -- Telescope fuzzy finder
    use {
      "nvim-telescope/telescope.nvim",
      config = require("plugin.telescope"),
    }
    -- Telescope fzy override
    use { "nvim-telescope/telescope-fzy-native.nvim" }
    -- Floating terminal
    use {
      "akinsho/nvim-toggleterm.lua",
      config = require("plugin.terminal")
    }
    -- NERDCommenter for sweet block comment goodness
    use { "preservim/nerdcommenter" }


    -- [[ Functional Aesthetics ]] --
    ---------------------------------
    -- File tree with nerdicons
    use {
      "kyazdani42/nvim-tree.lua",
      config = require("plugin.nvim-tree"),
      requires = "nvim-web-devicons",
      after = "nvim-web-devicons"
    }
    -- Gitsigns for gutter + in-line blame
    use {
      "lewis6991/gitsigns.nvim",
      config = require("plugin.gitsigns")
    }
    -- Lualine --
    use {
      "nvim-lualine/lualine.nvim",
      config = require("plugin.lualine"),
      requires = "nvim-web-devicons",
      after = "nvim-web-devicons"
    }
    -- Bufferline --
    use {
      "akinsho/bufferline.nvim",
      config = require("plugin.bufferline"),
      requires = "nvim-web-devicons",
      after = "nvim-web-devicons"
    }
    -- Dim inactive buffers --
    use {
      "sunjon/shade.nvim",
      config = require("plugin.shade"),
    }
    -- Indent lines --
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = require("plugin.indent-blankline"),
      event = "BufRead"
    }

    -- Inline color display --
    use {
      "rrethy/vim-hexokinase",
      event = "BufRead",
      run = "make hexokinase"
    }

    -- [[ Misc ]] --
    ----------------
    -- Treesitter compatible with more italics
    use { "folke/tokyonight.nvim" }
    -- A collection of treesitter compatible themes (nvcode,onedark,nord,aurora,gruvbox,palenight,snazzy)
    use { "christianchiarulli/nvcode-color-schemes.vim" }

    -- [[ Loader ]] --
    ------------------
    -- Automatically set up config, always keep this at the end
    if PACKER_BOOTSTRAP then
      -- require("packer").sync() -- also works but then we get the sync screen on every startup
      require("packer").install()
      require("packer").compile()
    end
  end
)
