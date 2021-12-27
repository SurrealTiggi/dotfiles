-- ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
-- ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
-- ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
-- ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
-- ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
--
-- https://github.com/surrealtiggi/dotfiles

-- [[ Neovim configurations for the ages ]] --

require "init"                -- Any global stuff to bootstrap first
require "user.options"        -- Vim general options
require "user.plugins"        -- Plugin management + plugin configs
require "user.keybinds"       -- Keymap config
require "user.functions"      -- Utility functions

require "user.autocommands"   -- All autocommands

-- [[ Things I'm too lazy to move ]] --
-- TODO: Move these, obvs...
---------------------------------------
-- Colorscheme
vim.cmd "colorscheme palenight"

-- Random plugin settings
vim.cmd([[
  " NERDCommenter
  let g:NERDSpaceDelims = 1
  let g:NERDCompactSexyComs = 1

  " Vim-hexokinase
  let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba'
  " let g:Hexokinase_highlighters = ['foregroundfull']
]])
