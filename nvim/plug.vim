""  PLUGINS (vim-plug)
" vim-plug loader
call plug#begin('~/.config/nvim/plugged.nightly')
"""  Language Support
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Coc.nvim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }      " Golang dev
Plug 'honza/vim-snippets'                               " All the snippets
Plug 'hashivim/vim-terraform'                           " Terraform dev
"""  Code quality
Plug 'dense-analysis/ale'                               " General purpose configurable linter
Plug 'editorconfig/editorconfig-vim'                    " EditorConfig
Plug 'pangloss/vim-javascript'                          " Javascript syntax
Plug 'leafgarland/typescript-vim'                       " Typescript syntax
Plug 'maxmellon/vim-jsx-pretty'                         " JSX syntax
Plug 'peitalin/vim-jsx-typescript'                      " TSX syntax
Plug 'plasticboy/vim-markdown'                          " Markdown helpers (includes folding)
"""  Utilities
Plug 'kassio/neoterm'                                   " Terminal in vim
Plug 'tpope/vim-fugitive'                               " Definitive git plugin | :Git
Plug 'tpope/vim-rhubarb'                                " Enable :GBrowse when :GV
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'fannheyward/telescope-coc.nvim'
Plug 'junegunn/gv.vim'                                  " Git commit browser | :GV
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " FZF/Rg | :Rg
Plug 'junegunn/fzf.vim'                                 " FZF.vim
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}      " Coc.fzf
Plug 'stsewd/fzf-checkout.vim'                          " Git checkout with FZF
Plug 'preservim/nerdcommenter'                          " NERDCommenter for block comments
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ludovicchabant/vim-gutentags'                     " ctags for Go-To-Definition | <C-]>. Remember brew install --HEAD universal-ctags/universal-ctags/universal-ctags
Plug 'preservim/tagbar'                                 " Tagbar for easy tags
Plug 'APZelos/blamer.nvim'                              " In-line git blame
Plug 'christianrondeau/vim-base64'                      " Base64 encoder/decoder | <leader>atob,<leader>btoa
Plug 'mg979/vim-visual-multi', {'branch': 'master'}     " Multi-cursor in vim
" Plug 'janko/vim-test'
" Plug 'puremourning/vimspector'
" Plug 'sagi-z/vimspectorpy', { 'do': { -> vimspectorpy#update() } }
" Plug 'mbbill/undotree'
"""  Functional Aesthetics
Plug 'itchyny/lightline.vim'                            " Lightline theme
Plug 'mengelbrecht/lightline-bufferline'                " Bufferline functionality for lightline
Plug 'maximbaz/lightline-ale'                           " Add ale status to lightline
Plug 'airblade/vim-gitgutter'                           " Git gutter
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Display colors next to color codes
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " The best highlights
Plug 'nvim-treesitter/playground'
"""  Make things pretty
Plug 'christianchiarulli/nvcode-color-schemes.vim'      " A collection of treesitter compatible themes (nvcode,onedark,nord,aurora,gruvbox,palenight,snazzy)
" Plug 'cocopon/iceberg.vim'                              " Iceberg colorscheme
Plug 'ghifarit53/tokyonight-vim'                        " Tokyo Night colorscheme
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'                           " VIM Material Icons for plugins

" vim-plug closure
call plug#end()
