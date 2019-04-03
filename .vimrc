" ~/.vim
"├── autoload
"│   └── pathogen.vim
"└── bundle
"    ├── nerdtree                   Directory browser in vim
"    ├── nerdtree-git-plugin        Git support for NERDTree
"    ├── vim-airline                Airline theme
"    ├── vim-fugitive               Git wrapper
"    ├── vim-signify                Best git gutter
"    └── nord-vim                   Nord colorscheme


" Pathogen
execute pathogen#infect()

" Disable vi compatibility
set nocompatible

" Syntax highlighting
syntax on

" ftdetect/indent plugin
filetype plugin indent on

" General
set encoding=utf-8
set autoread                                        " reload files when changed on disk
set ttimeoutlen=10                                  " adjust timeout to avoid escape key contention
"set softtabstop=2                                  " insert mode tab and backspace use x spaces
set tabstop=2                                       " make existing tab characters x spaces
set shiftwidth=2                                    " normal mode indentation becomes x spaces
set expandtab                                       " pressing tab inserts x spaces
set ignorecase                                      " case-insensitive search
set list                                            " show trailing whitespace
set listchars=tab:.\ ,trail:▫
set number                                          " show line numbers
set ruler                                           " show ruler

" in case you forgot to sudo
cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!

" Plugin Settings
" airline
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#branch#enabled=1

if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Theme
colorscheme nord
