-- [[ GLOBAL OPTIONS ]] --
--------------------------
local options = {
  autoread = true,                             -- reload files when changed on disk
  autowriteall = true,                         -- always autosave
  clipboard = "unnamedplus",                   -- yank across different terminals
  completeopt = { "menuone", "noselect" },     -- mostly for cmp
  cursorline = true,                           -- highlights the current line
  encoding = "utf-8",                          -- set file enconding
  expandtab = true,                            -- pressing tab inserts x spaces
  foldlevel = 99,                              -- sets fold level
  foldmethod = "indent",                       -- enable method folding
  hidden = true,                               -- don't unload hidden buffers (enabled for toggleterm)
  hlsearch = false,                            -- don't leave search words highlighted
  ignorecase = true,                           -- case-insensitive search
  incsearch = true,                            -- start searching immediately as you type
  list = true,                                 -- show trailing whitespace
  listchars = {                                -- special chars to show (leaving out eol:¬ as it gets noisy)
    eol = '⤶',
    tab = "• ",
    trail = "▫",
    precedes = "«",
    extends = "»",
    nbsp = "␣"
  },
  mouse = "a",                                 -- enable mouse scrolling
  number = true,                               -- show line numbers
  numberwidth = 4,                             -- set width for number column
  relativenumber = true,                       -- enables hybrid line numbers
  ruler = true,                                -- show ruler
  scrolloff = 8,                               -- scroll 8 spaces from top/bottom
  shiftwidth = 2,                              -- normal mode indentation becomes x spaces
  showmode = false,                            -- disable showing the current mode
  showtabline = 2,                             -- always show tabline
  signcolumn = "yes",                          -- always show signcolumn (default: auto)
  smartcase = true,                            -- enable smart case
  smartindent = true,                          -- enable smart indent
  splitbelow = true,                           -- force horizontal splits to go ↓
  splitright = true,                           -- force vertical splits to go →
  swapfile = false,                            -- disable swapfiles
  tabstop = 2,                                 -- make existing tab characters x spaces
  termguicolors = true,                        -- enable 24bit colors
  ttimeoutlen = 10,                            -- adjust timeout to avoid escape key contention
  undofile = true,                             -- enable persistent undo
  updatetime = 100,                            -- faster completion (default: 4000ms)
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Extra options to apply that only work in vim syntax
vim.cmd [[set iskeyword+=-]]                  -- Extends keyword actions to include '-'

-- TODO: Remove if they're not needed with neovim
-- vim.cmd "syntax on"
-- vim.cmd "filetype plugin indent on"
