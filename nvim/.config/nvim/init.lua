-- ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
-- ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
-- ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
-- ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
-- ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
--
-- https://github.com/surrealtiggi/dotfiles

-- [[ Folder structure ]] --
----------------------------
--  lua                      -- Main lua code source folder
-- │  core                   -- For core config, functions and structs
-- │  lsp                    -- For all LSP specific config
-- │ └  settings             -- Settings for individual language servers
-- │  plugin                 -- Configurations for non-LSP plugins
-- │  user                   -- Literally verything else
-- └  init.lua               -- For global variables, or can be used to simplify main init.lua
--  init.lua                 -- Main entrypoint, neovim loads this first

-- [[ Neovim configurations for the ages ]] --
----------------------------------------------
require("init") -- Global variables and basic things to load up
require("core.options") -- Vim general options
require("core.lazy") -- Lazy.nvim plugin management + lsp

require("user.keybinds") -- Keymap config
require("user.plugins") -- Lazy.nvim plugin management + plugin configs
require("user.functions") -- Utility functions

-- require("user.autocommands") -- All autocommands
require("user.misc") -- Everything else, eg. colorscheme, vim plugin settings, etc.

-- require("lsp") -- Setup LSP

-- See TODO.md for all outstanding tasks and enhancements
