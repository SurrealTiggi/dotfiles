" ~/.vim
"├── autoload
"│   └── pathogen.vim
"└── bundle
"    ├── nerdtree
"    ├── vim-airline
"    ├── vim-fugitive
"    ├── vim-gitgutter
"    └── vim-signify

execute pathogen#infect()
syntax on
filetype plugin indent on

set ttimeoutlen=50
set sts=2
set ts=1
set sw=2
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#branch#enabled=1

if !exists('g:airline_symbols')
          let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
