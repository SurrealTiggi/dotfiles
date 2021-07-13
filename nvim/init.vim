" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
"
" https://github.com/surrealtiggi/dotfiles
""  INITIAL SETUP
""" Automatically configure vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    silent execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    silent execute '!ln -s ~/.config/nvim/init.vim ~/.vimrc'
endif
""" Disable ALE LSP to not conflict with coc.nvim https://github.com/dense-analysis/ale#faq-coc-nvim
let g:ale_disable_lsp = 1

""" Coc.nvim Plugins
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-html',
\ 'coc-css',
\ 'coc-sh',
\ 'coc-go',
\ 'coc-pyright',
\ 'coc-snippets',
\ 'coc-emmet',
\ 'coc-pairs',
\ 'coc-tailwindcss',
\ ]


""  VIM IMPORTS
runtime ./sets.vim
runtime ./plug.vim
runtime ./keybinds.vim
""  LUA IMPORTS
lua require "nvimTree"
lua require "telescope-nvim"
lua require "treesitter"

""  THEME
let g:nvcode_termcolors=256
colorscheme palenight
""" Show off animoo background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
