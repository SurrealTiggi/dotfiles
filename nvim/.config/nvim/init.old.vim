" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
"
" https://github.com/surrealtiggi/dotfiles

"" OLD STUFF TO CLEAN UP
""" Disable ALE LSP to not conflict with coc.nvim https://github.com/dense-analysis/ale#faq-coc-nvim
" let g:ale_disable_lsp = 1

""" Coc.nvim Plugins
" let g:coc_global_extensions = [
"\ 'coc-json',
"\ 'coc-tsserver',
"\ 'coc-html',
"\ 'coc-css',
"\ 'coc-sh',
"\ 'coc-pyright',
"\ 'coc-snippets',
"\ 'coc-emmet',
"\ 'coc-pairs',
"\ 'coc-tailwindcss',
"\ ]


""  VIM IMPORTS
""" [Auto] plugin/ -- Used for autocommands, global functions and vim plugin specific settings
""" [Auto] ftplugin/ -- Used to autoload language specific LSP
runtime ./settings.vim

""  LUA IMPORTS
lua require "init"
lua require "user.options"
lua require "user.plugins"
lua require "user.keybinds"
lua require "user.functions"

lua require "user.autocommands"

""  THEME
colorscheme palenight
" colorscheme tokyonight

""" Show off animoo background
" FIXME: Disabled as inactive buffer dimming doesn't work as well with this
" hi Normal     guibg=NONE ctermbg=NONE
" hi LineNr     ctermbg=NONE guibg=NONE
" hi SignColumn ctermbg=NONE guibg=NONE
