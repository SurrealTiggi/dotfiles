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


""" Disable vi compatibility
set nocompatible

""" Syntax highlighting
syntax on
filetype plugin indent on
""  GENERAL SETTINGS
""" Global settings
set encoding=utf-8
set autowriteall                                                  " always autosave
set autoread                                                      " reload files when changed on disk
set ttimeoutlen=10                                                " adjust timeout to avoid escape key contention
set tabstop=2                                                     " make existing tab characters x spaces
set shiftwidth=2                                                  " normal mode indentation becomes x spaces
set expandtab                                                     " pressing tab inserts x spaces
set ignorecase                                                    " case-insensitive search
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
" set tags+=./.tags,.tags,../.tags,../../.tags                    " Recursively check parent dirs for tags files
""" Set leader
nnoremap <SPACE> <Nop>
let mapleader=" "

""  VIM IMPORTS
runtime ./plug.vim
runtime ./functions.vim
runtime ./keybinds.vim
""  LUA IMPORTS
lua require "nvimTree"
lua require "telescope-nvim"

""  FUNCTIONS
""" Show documentation in floating preview window
" From https://github.com/neoclide/coc.nvim#example-vim-configuration
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
nnoremap <silent>K :call <SID>show_documentation()<CR>
""" Folding
function! ToggleFold()
     if &foldlevel >= 20
         "normal! zM<CR> (folds all)
         set foldlevel=0
     else
         "normal! zR<CR> (unfolds everything)
         set foldlevel=20
     endif
endfunction

""" Refresh NvimTree on open
function! NvimTreeToggleAndRefresh()
  :NvimTreeToggle
  :NvimTreeRefresh
endfunction

""" Lightline
function! LightlineGitBranch()
  let l:bname = fugitive#head()
  return l:bname != '' ? g:gitbranch_icon . ' ' . l:bname : ''
endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler' && &readonly ? '' : ''
endfunction
function! LightlineModified()
  return &modifiable && &modified ? '' : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . '[' . &fileencoding . ']') : ''
endfunction

function! CocCurrentFunction() abort
  return get(b:, 'coc_current_function', '') . '()'
endfunction

function! Timer()
  " return strftime("%H:%S")
  return strftime("%H:%M %d-%b-%y") . " IST" "Timer in status line
  " return !date
endfunction

""" FZF/Rg
" From :help fzf-vim-example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --glob "!{**/node_modules/*,**/.git/*,**/go.sum,**/package-lock.json,**/yarn.lock,**/bin/*,**/build/*,**/.nuxt/*,**/.next/*}" --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

""" Helper for <tab> trigger completion
" From https://github.com/neoclide/coc-snippets#examples
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


""  PLUGIN SETTINGS
""" Coc.nvim
let g:coc_snippet_next = '<tab>'
let g:python_host_prog = '$HOME/.pyenv/shims/python'
let g:python3_host_prog = '$HOME/.pyenv/shims/python3'
""" vim-terraform
let g:terraform_align = 1
let g:terraform_fmt_on_save = 0 " Leave it to ale
let g:terraform_fold_sections = 1 " Enable folding
""" NVim Treesitter
lua require'nvim-treesitter.configs'.setup { ensure_installed = "bash","css","go","graphql","html","javascript","typescript","jsdoc","json","python","regex","rust","toml","vue","yaml", highlight = { enable = true}}
""" NVCode
let g:nvcode_termcolors=256
""" ALE linter
let g:ale_linters = {
      \ 'go': ['golangci-lint'],
      \ 'python': ['flake8'],
      \ 'terraform': ['terraform'],
      \ 'markdown': ['mdl', 'writegood'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'css': ['stylelint'],
      \ 'html': ['htmlhint'],
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'python': ['isort', 'black'],
      \ 'terraform': ['terraform'],
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'html': ['prettier'],
      \ 'css': ['stylelint', 'prettier'],
      \}

let g:ale_fix_on_save = 1
let g:ale_go_golangci_lint_options = '--fast'
" let g:ale_python_black_options = '-l 79' " 88 is the default
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'
" let g:ale_python_flake8_options = '--max-complexity 10'
" let g:ale_python_flake8_options = '--max-complexity 10 --max-line-length 88'

let g:ale_echo_msg_error_str = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_format = '%severity% [%linter%:%code%] %s'
" let g:ale_sign_warning = ""
" let g:ale_sign_error = "﯇"
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
""" lightline
let g:lightline = {}
" let g:lightline.colorscheme = 'seoul256'
let g:lightline.colorscheme = 'tokyonight'
let g:lightline.component_function = {
      \   'gitbranch': 'LightlineGitBranch',
      \   'filename': 'LightlineFilename',
      \   'readonly': 'LightlineReadOnly',
      \   'modified': 'LightlineModified',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'lsp': 'coc#status',
      \   'time': 'Timer',
      \   'currentfunction': 'CocCurrentFunction',
      \ }
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_infos': 'lightline#ale#infos',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors',
      \ 'linter_ok': 'lightline#ale#ok',
      \ 'buffers': 'lightline#bufferline#buffers',
      \ }
let g:lightline.component_type = {
      \ 'linter_checking': 'right',
      \ 'linter_infos': 'right',
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error',
      \ 'linter_ok': 'right',
      \ 'time': 'left',
      \ 'buffers': 'tabsel',
      \ }
" let g:lightline.component = {'separator': ''}
let g:lightline.component = {'lineinfo': ' %3l:%-2c'}
let g:gitbranch_icon = ''
let g:lightline.active = {
      \ 'left':
      \   [[ 'mode', 'paste' ],
      \    [ 'gitbranch'],
      \    [ 'currentfunction','readonly', 'filename', 'modified' ]],
      \ 'right':
      \   [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
      \    [ 'lineinfo', 'percent' ],
      \    [ 'fileformat', 'filetype' ]]
      \ }

" let g:lightline.tabline = {'left': [['tabs']], 'right': [['lsp']]}
let g:lightline.tabline = {'left': [['buffers']], 'right': [['lsp']]}
" let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#unicode_symbols = 1

let g:lightline.separator = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:lightline.subseparator = { 'left': "\ue0b1", 'right': "\ue0b3" }

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"

""" Gutentags
let g:gutentags_ctags_extra_args = ['--options=/Users/tbaptista/.ctagsrc']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

""" FZF/Rg
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'vsplit',
      \ 'ctrl-i': 'split'}

""" vim-go
let g:go_def_mapping_enabled = 0      " Let coc-go handle mappings
let g:go_code_completion_enabled = 0  " Let coc-go handle completion
let g:go_gopls_options = ['-remote=auto']
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor
let g:go_auto_sameids = 1             " Highlight matching names in viewport
let g:go_doc_popup_window = 1         " use a popup window for :GoDoc [K]
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']

""" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_map_togglefold = "o"

""" Git gutter
set updatetime=100

""" GitBlame
if has("nvim")
  let g:blamer_enabled = 1
  let g:blamer_delay = 250
endif

""" visual-multi
let g:VM_default_mappings = 0                       " Remove all default maps
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps["Select Cursor Down"] = '<C-S-Down>'
let g:VM_maps["Select Cursor Up"]   = '<C-S-Up>'
""" Neoterm
let g:neoterm_default_mod = "botright"
let g:neoterm_autoinsert = 1

""" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
""" Vimspector + vim-test
" let test#strategy = "neovim"
" let test#neovim#term_position = "vertical"


""  AUTO
""" Automatically install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
""" Automatically reload current file if buffer changes
au FocusGained,BufEnter * :checktime

""" use treesitter for folding if possible
augroup fold_go
  autocmd!
  autocmd FileType go,python setlocal foldmethod=expr | set fde=nvim_treesitter#foldexpr()
augroup END
""" vimrc folding (https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file)
augroup fold_vimrc
  autocmd!
  autocmd FileType vim
                      \ setlocal foldmethod=expr |
                      \ set fde=getline(v\:lnum)=~'^\"\"'?'>'.(matchend(getline(v\:lnum),'\"\"*')-1)\:'='
augroup END
""" Build tags for python correctly
" autocmd BufWritePost *.py silent! !ctags -R --extras=+f --python-kinds=-i --languages=python 2&gt; /dev/null &amp;
""" Force a rescan for js/ts buffers
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
""  THEME
colorscheme palenight
""" Show off animoo background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
