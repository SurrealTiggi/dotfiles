-- Ensure plugin manager is installed
local present, _ = pcall(require, "core.packerInit")
local packer

if present then
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
    -- Treesitter for highlights and AST
    use {
      "nvim-treesitter/nvim-treesitter",
      config = require("plugin.treesitter"),
      event = "BufRead",
      run = ":TSUpdate"
    }

    -- [[ IDE Utilities ]] --
    -------------------------
    -- Telescope fuzzy finder
    use {
      "nvim-telescope/telescope.nvim",
      config = require("plugin.telescope"),
    }
    -- Telescope fzf override
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    }

    -- [[ Misc ]] --
    ----------------
    -- Treesitter compatible with more italics
    use { "folke/tokyonight.nvim", event = "ColorSchemePre" }
    -- A collection of treesitter compatible themes (nvcode,onedark,nord,aurora,gruvbox,palenight,snazzy)
    use { "christianchiarulli/nvcode-color-schemes.vim", event = "ColorSchemePre" }

    -- TODO: Comment out if it gives issues and just run :PackerSync manually
    packer.install()
    packer.compile()
  end
)
