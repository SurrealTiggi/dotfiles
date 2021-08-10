" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
"
" https://github.com/surrealtiggi/dotfiles

""  INITIAL SETUP
""" Disable ALE LSP to not conflict with coc.nvim https://github.com/dense-analysis/ale#faq-coc-nvim
let g:ale_disable_lsp = 1

""" Coc.nvim Plugins
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-html',
\ 'coc-css',
\ 'coc-sh',
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
lua require "default-config"
" lua require "settings"
" lua require "autocommands"
" lua require "commands"
" lua require("lsp").setup_handlers()
lua require "lsp"
lua require "utils"

""  THEME
" let g:nvcode_termcolors=256
colorscheme palenight
" colorscheme tokyonight

""" Show off animoo background
hi Normal     guibg=NONE ctermbg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
