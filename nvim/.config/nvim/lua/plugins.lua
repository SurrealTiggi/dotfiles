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
    --  Ensures we run ftplugin/*.lua at the right time
    use { "tjdevries/astronauta.nvim" , commit = "e69d7bdc4183047c4700427922c4a3cc1e3258c6" }

    -- [[ Language Support ]] --
    ----------------------------
    -- Built-in LSP
    use { 'neovim/nvim-lspconfig' }
    --[[
    use({
      'neovim/nvim-lspconfig',
      config = require('modules.config.nvim-lspconfig'),
      event = 'ColorScheme',
      requires = {
        { 'kabouzeid/nvim-lspinstall', module = 'lspinstall' },
        { 'glepnir/lspsaga.nvim', module = 'lspsaga' },
        { 'ray-x/lsp_signature.nvim', module = 'lsp_signature' },
        {
          'jose-elias-alvarez/nvim-lsp-ts-utils',
          module = 'nvim-lsp-ts-utils',
        },
      },
    })
    ]]
    -- Treesitter for highlights and AST
    use {
      "nvim-treesitter/nvim-treesitter",
      config = require("plugin.treesitter"),
      run = ":TSUpdate"
    }

    -- [[ IDE Utilities ]] --
    -------------------------
    -- Telescope fuzzy finder
    use {
      "nvim-telescope/telescope.nvim",
      config = require("plugin.telescope"),
    }
    -- Telescope fzy override
    use {
      "nvim-telescope/telescope-fzy-native.nvim",
    }
    -- Floating terminal
    use {
      "akinsho/nvim-toggleterm.lua",
      event = "BufWinEnter",
      config = require("plugin.terminal")
    }
    -- NERDCommenter for sweet block comment goodness
    use { "preservim/nerdcommenter" }
    -- Gitsigns for gutter + in-line blame
    use { 
      "lewis6991/gitsigns.nvim",
      config = require("plugin.gitsigns"),
      event = "BufRead"
    }

    -- [[ Functional Aesthetics ]] --
    ---------------------------------
    -- NerdIcons
    use {
      "kyazdani42/nvim-web-devicons",
      config = require("plugin.nvim-web-devicons"),
      -- module = "nvim-web-devicons",
    }

    -- File tree with nerdicons
    use {
      "kyazdani42/nvim-tree.lua",
      config = require("plugin.nvim-tree"),
      -- module = "nvim-tree",
    }

    -- Dim inactive buffers --
    use {
      "sunjon/shade.nvim",
      config = require("plugin.shade"),
    }

    -- [[ Misc ]] --
    ----------------
    -- Treesitter compatible with more italics
    use { "folke/tokyonight.nvim" }
    -- A collection of treesitter compatible themes (nvcode,onedark,nord,aurora,gruvbox,palenight,snazzy)
    use { "christianchiarulli/nvcode-color-schemes.vim", event = "ColorSchemePre" }

    -- [[ Loader ]] --
    ------------------
    -- Automatically set up config, always keep this at the end
    if PACKER_BOOTSTRAP then
      -- require('packer').sync() -- also works but then we get the sync screen on every startup
      require('packer').install()
      require('packer').compile()
    end
  end
)
