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
    -- use { "tjdevries/astronauta.nvim" , commit = "e69d7bdc4183047c4700427922c4a3cc1e3258c6" }

    -- [[ Language Support ]] --
    ----------------------------
    -- TODO: null-ls, nvim-lsp-ts-utils
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
    -- Show function signature while typing
    use { "ray-x/lsp_signature.nvim" }
    -- Nicer Rename
    use {
      "CosmicNvim/cosmic-ui",
      config = require("plugin.cosmic-ui"),
      requires = { "MunifTanjim/nui.nvim"}
    }
    -- Trouble
    -- TODO: Explore config
    use {
      "folke/trouble.nvim",
      requires = "nvim-web-devicons",
      config = function()
        require("trouble").setup {auto_close=true, height=25}
      end
    }
    -- LSPSaga
    -- TODO: Explore config
    use { "tami5/lspsaga.nvim" }
    -- GoToDefinition previewer
    -- TODO: Explore config
    use {
      "rmagatti/goto-preview",
      config = function()
        require("goto-preview").setup({})
      end
    }
    -- Symbol outline tree
    -- TODO: Explore config
    use {
      "simrat39/symbols-outline.nvim"
    }

    -- Nicer code actions w/diff
    -- FIXME: No diff, wait for https://github.com/weilbith/nvim-code-action-menu/issues/35
    -- use {
      -- "weilbith/nvim-code-action-menu",
      -- cmd = "CodeActionMenu"
    -- }

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
    -- General purpose async notifications
    use { "rcarriga/nvim-notify" }

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
    -- TODO: Add LSP info see https://github.com/nvim-lualine/lualine.nvim#screenshots
    -- TODO: Check feline-nvim/feline.nvim for inspiration
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
    -- FIXME: Disabled as it breaks some floating windows such as Rename and GoToPreview
    -- use {
      -- "sunjon/shade.nvim",
      -- config = require("plugin.shade"),
    -- }
    -- Indent lines --
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = require("plugin.indent-blankline"),
      event = "BufRead"
    }
    -- Dashboard
    -- FIXME: Only loads manually by calling :Alpha. Possibly related to startup screen disappearing
    use {
      "goolord/alpha-nvim",
      config = require("plugin.alpha-nvim"),
      requires = "nvim-web-devicons",
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
