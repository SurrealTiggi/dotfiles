-- [[ GLOBAL VARS ]] --
-----------------------
-- Utility vars
DATA_PATH = vim.fn.stdpath "data" -- $HOME/.local/share/nvim
CACHE_PATH = vim.fn.stdpath "cache" -- $HOME/.cache/nvim
TERMINAL = vim.fn.expand "$TERMINAL"
USER = vim.fn.expand "$USER"

-- Global colors
COLORS = nil
local colors_ok, colors = pcall(require, "core.colors")
if colors_ok then
  COLORS = colors
end

-- Global symbols
SYMBOLS = nil
local symbols_ok, symbols = pcall(require, "core.symbols")
if symbols_ok then
  SYMBOLS = symbols
end
