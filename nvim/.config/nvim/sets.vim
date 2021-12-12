""" Global settings
set autoread                                                      " reload files when changed on disk
set autowriteall                                                  " always autosave
set clipboard=unnamedplus                                         " yank across different terminals
set completeopt=menuone,noselect                                  " mostly for cmp
set cursorline                                                    " highlights the current line
set encoding=utf-8                                                " set file enconding
set expandtab                                                     " pressing tab inserts x spaces
set foldlevel=99                                                  " sets fold level
set foldmethod=indent                                             " enable method folding
set hidden                                                        " don't unload hidden buffers (enabled for toggleterm)
set ignorecase                                                    " case-insensitive search
set incsearch                                                     " start searching immediately as you type
set list                                                          " show trailing whitespace
set listchars=tab:•\ ,trail:▫,precedes:«,extends:»,nbsp:␣         " special chars to show (leaving out eol:¬ as it gets noisy)
set mouse=a                                                       " enable mouse scrolling
set nohlsearch                                                    " don't leave search words highlighted
set noshowmode                                                    " disable showing the current mode
set noswapfile                                                    " disable swapfiles
set number                                                        " show line numbers
set numberwidth=4                                                 " set width for number column
set relativenumber                                                " enables hybrid line numbers
set ruler                                                         " show ruler
set scrolloff=8                                                   " scroll 8 spaces from top/bottom
set shiftwidth=2                                                  " normal mode indentation becomes x spaces
set showtabline=2                                                 " always show tabline
set signcolumn=yes                                                " always show signcolumn (default: auto)
set smartcase                                                     " enable smart case
set smartindent                                                   " enable smart indent
set splitright                                                    " force vertical splits to go →
set splitbelow                                                    " force horizontal splits to go ↓
set tabstop=2                                                     " make existing tab characters x spaces
set termguicolors                                                 " enable 24bit colors
set ttimeoutlen=10                                                " adjust timeout to avoid escape key contention
set updatetime=100                                                " faster completion (default: 4000ms)
set undofile                                                      " enable persistent undo
" set tags+=./.tags,.tags,../.tags,../../.tags                    " recursively check parent dirs for tags files

""" Syntax highlighting
syntax on
filetype plugin indent on
