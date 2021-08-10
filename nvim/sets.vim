""" Global settings
set encoding=utf-8
set autowriteall                                                  " always autosave
set autoread                                                      " reload files when changed on disk
set ttimeoutlen=10                                                " adjust timeout to avoid escape key contention
set tabstop=2                                                     " make existing tab characters x spaces
set shiftwidth=2                                                  " normal mode indentation becomes x spaces
set expandtab                                                     " pressing tab inserts x spaces
set ignorecase                                                    " case-insensitive search
set hidden                                                        " Don't unload hidden buffers (enabled for toggleterm)
set list                                                          " show trailing whitespace
set listchars=tab:•\ ,trail:▫,precedes:«,extends:»,nbsp:␣         " special chars to show (leaving out eol:¬ as it gets noisy)
set number                                                        " show line numbers
set relativenumber                                                " enables hybrid line numbers
set ruler                                                         " show ruler
set foldmethod=indent                                             " enable method folding
set foldlevel=99                                                  " sets fold level
set clipboard=unnamedplus                                         " yank across different terminals
set termguicolors                                                 " Enable 24bit colors
set noshowmode                                                    " Disable showing a line when in certain modes
set showtabline=2                                                 " Always show tabline
set incsearch                                                     " Start searching immediately as you type
set scrolloff=8                                                   " Scroll 8 spaces from top/bottom
set nohlsearch                                                    " Don't leave search words highlighted
set cursorline                                                    " Show cursorline
set updatetime=100
" set tags+=./.tags,.tags,../.tags,../../.tags                    " Recursively check parent dirs for tags files

""" Syntax highlighting
syntax on
filetype plugin indent on
