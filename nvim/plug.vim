""  PLUGINS (vim-plug)
" vim-plug loader
call plug#begin('~/.config/nvim/plugged.nightly')
"""  LSP Core
Plug 'neovim/nvim-lspconfig'                                      "
Plug 'kabouzeid/nvim-lspinstall'

"""  Utilities
Plug 'lukas-reineke/indent-blankline.nvim'                        " Indent lines for convenience



"" OLD CRAP TO CLEAN UP
Plug 'mustache/vim-mustache-handlebars'                 " [REPLACE???] Mustache/handlebar syntax highlights and ftdetect

Plug 'neoclide/coc.nvim', {'branch': 'release'}         " [REPLACE] Coc.nvim
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }      " [REPLACE] Golang dev
Plug 'honza/vim-snippets'                               " [REPLACE] All the snippets
Plug 'hashivim/vim-terraform'                           " [REPLACE] Terraform dev

"""  Code quality
Plug 'dense-analysis/ale'                               " [REPLACE???] General purpose configurable linter
Plug 'editorconfig/editorconfig-vim'                    " [REPLACE/REMOVE???] EditorConfig
Plug 'pangloss/vim-javascript'                          " [REMOVE] Javascript syntax
Plug 'leafgarland/typescript-vim'                       " [REMOVE] Typescript syntax
Plug 'maxmellon/vim-jsx-pretty'                         " [REMOVE] JSX syntax
Plug 'peitalin/vim-jsx-typescript'                      " [REMOVE] TSX syntax
Plug 'plasticboy/vim-markdown'                          " [REMOVE] Markdown helpers (includes folding)


Plug 'mg979/vim-visual-multi', {'branch': 'master'}     " [REPLACE???] Multi-cursor in vim
Plug 'ludovicchabant/vim-gutentags'                     " [REPLACE???] ctags for Go-To-Definition | <C-]>. Remember brew install --HEAD universal-ctags/universal-ctags/universal-ctags
Plug 'preservim/nerdcommenter'                          " [REPLACE] NERDCommenter for block comments
Plug 'tpope/vim-fugitive'                               " [REPLACE???] Definitive git plugin | :Git
Plug 'tpope/vim-rhubarb'                                " [REMOVE???] Enable :GBrowse when :GV
Plug 'junegunn/gv.vim'                                  " [REPLACE???] Git commit browser | :GV
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " [REMOVE] FZF/Rg | :Rg
Plug 'junegunn/fzf.vim'                                 " [REMOVE] FZF.vim
Plug 'fannheyward/telescope-coc.nvim'                   " [REMOVE]
" Plug 'antoinemadec/coc-fzf', {'branch': 'release'}      " [REMOVE] Coc.fzf
Plug 'stsewd/fzf-checkout.vim'                          " [REPLACE???] Git checkout with FZF - needs fzf and fzf.vim
Plug 'preservim/tagbar'                                 " [REPLACE] Tagbar for easy tags
Plug 'APZelos/blamer.nvim'                              " [REPLACE] In-line git blame
Plug 'christianrondeau/vim-base64'                      " [REPLACE???] Base64 encoder/decoder | <leader>atob,<leader>btoa
" Plug 'janko/vim-test'
" Plug 'puremourning/vimspector'
" Plug 'sagi-z/vimspectorpy', { 'do': { -> vimspectorpy#update() } }
" Plug 'mbbill/undotree'
"
"""  Functional Aesthetics

Plug 'itchyny/lightline.vim'                            " [REPLACE] Lightline theme
Plug 'mengelbrecht/lightline-bufferline'                " [REPLACE] Bufferline functionality for lightline
Plug 'maximbaz/lightline-ale'                           " [REPLACE] Add ale status to lightline
Plug 'airblade/vim-gitgutter'                           " [REPLACE] Git gutter
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " [REPLACE] Display colors next to color codes
"""  Make things pretty
" Plug 'cocopon/iceberg.vim'                              " Iceberg colorscheme
Plug 'ghifarit53/tokyonight-vim'                        " Tokyo Night colorscheme
Plug 'ryanoasis/vim-devicons'                           " [REMOVE] VIM Material Icons for plugins

" vim-plug closure
call plug#end()
