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
if empty(glob("~/.vim/autoload/plug.vim"))
    silent execute '!mkdir -p ~/.config/nvim'
    silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    silent execute '!ln -s ~/.vim/autoload/ ~/.config/nvim'
    silent execute '!ln -s ~/.vim/plugged/ ~/.config/nvim'
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

""  PLUGINS (vim-plug)
" vim-plug loader
if has('nvim-0.5')
  call plug#begin('~/.vim/plugged.nightly')
else
  call plug#begin('~/.vim/plugged')
endif
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
Plug 'junegunn/gv.vim'                                  " Git commit browser | :GV
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " FZF/Rg | :Rg
Plug 'junegunn/fzf.vim'                                 " FZF.vim
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}      " Coc.fzf
Plug 'stsewd/fzf-checkout.vim'                          " Git checkout with FZF
Plug 'preservim/nerdcommenter'                          " NERDCommenter for block comments
Plug 'preservim/nerdtree'                               " NERDTree for navigation
Plug 'ludovicchabant/vim-gutentags'                     " ctags for Go-To-Definition | <C-]>. Remember brew install --HEAD universal-ctags/universal-ctags/universal-ctags
Plug 'preservim/tagbar'                                 " Tagbar for easy tags
Plug 'APZelos/blamer.nvim'                              " In-line git blame
Plug 'christianrondeau/vim-base64'                      " Base64 encoder/decoder | <leader>atob,<leader>btoa
Plug 'mg979/vim-visual-multi', {'branch': 'master'}     " Multi-cursor in vim
" Plug 'mbbill/undotree'
"""  Functional Aesthetics
Plug 'itchyny/lightline.vim'                            " Lightline theme
Plug 'mengelbrecht/lightline-bufferline'                " Bufferline functionality for lightline
Plug 'maximbaz/lightline-ale'                           " Add ale status to lightline
Plug 'airblade/vim-gitgutter'                           " Git gutter
Plug 'Xuyuanp/nerdtree-git-plugin'                      " Git status in NERDTree
Plug 'lambdalisue/glyph-palette.vim'                    " Color highlights for NERDTree
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Display colors next to color codes
if has('nvim-0.5')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " The best highlights
endif
"""  Make things pretty
Plug 'christianchiarulli/nvcode-color-schemes.vim'      " A collection of treesitter compatible themes (nvcode,onedark,nord,aurora,gruvbox,palenight,snazzy)
Plug 'cocopon/iceberg.vim'                              " Iceberg colorscheme
Plug 'ghifarit53/tokyonight-vim'                        " Tokyo Night colorscheme
Plug 'ryanoasis/vim-devicons'                           " VIM Material Icons for plugins

" vim-plug closure
call plug#end()

""  FUNCTIONS
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
 """ Refresh NERDTree on open
function! NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
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
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
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
if has('nvim-0.5')
  lua require'nvim-treesitter.configs'.setup { ensure_installed = "bash","css","go","graphql","html","javascript","typescript","jsdoc","json","python","regex","rust","toml","vue","yaml", highlight = { enable = true}}
endif
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
      \    [ 'fileformat', 'fileencoding', 'filetype' ]]
      \ }

" Sticking with tabs and not buffers for now, some plugins(nerdtree,<C-h>) default to a tab so
" can get confusing
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

"
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
if has('nvim-0.4')
  let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
endif

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
""" Neoterm
let g:neoterm_default_mod = "botright"
let g:neoterm_autoinsert = 1

""" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

""" NERDTree
let g:NERDTreeIgnore=[
      \ '\~$', 'bower_components', 'node_modules', '__pycache__', '^.pytest_cache', '^.mypy_cache','^.vim',
      \ '^.git$', '.aws-sam$', '^dist$', '^.terraform$', 'resources$[[dir]]',
      \ 'build$[[dir]]', 'bin$[[dir]]', 'yarn.lock', '.nuxt$[[dir]]', '.next$[[dir]]'
      \ ]
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1

"""" Purely for aesthetics
" let g:NERDTreeDirArrowExpandable = "▸"
" let g:NERDTreeDirArrowCollapsible = "▾"
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "",
    \ "Staged"    : "●",
    \ "Untracked" : "",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "",
    \ "Dirty"     : "*",
    \ "Clean"     : "",
    \ 'Ignored'   : '',
    \ "Unknown"   : "!"
    \ }

" Setting glyphs manually because for some reason the var doesn't show up
let g:glyph_palette#palette = {
      \ 'GlyphPalette1': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette2': ['', '', '', '﵂','', '', '', '', ''],
      \ 'GlyphPalette3': ['λ', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette4': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette6': ['', '', ''],
      \ 'GlyphPalette7': ['', '', '', '', '', '', '', '', '', ''] ,
      \ 'GlyphPalette9': ['', '',  '', 'ﬥ', ''],
      \ 'GlyphPalette12': ['', '', '', ''],
      \ 'GlyphPaletteDirectory': ['', '', '', '', '', ''],
      \}

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.*\.json$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.md$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.sh$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.rst$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.gitignore$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['Makefile$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.y.*ml$'] = 'ﬥ'
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['^.gitlab-ci\.y.*ml$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.toml$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.tf$'] = ''
""  AUTO
""" Automatically install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
""" Automatically reload current file if buffer changes
au FocusGained,BufEnter * :checktime
""" Reload glyphs for NERDTree
augroup my-glyph-palette
  autocmd! *
  autocmd FileType nerdtree call glyph_palette#apply()
augroup END
""" use treesitter for folding if possible
augroup fold_go
  autocmd!
  if has('nvim-0.5')
    autocmd FileType go,python setlocal foldmethod=expr | set fde=nvim_treesitter#foldexpr()
  else
    autocmd FileType go setlocal foldmethod=syntax
  endif
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
""  KEY BINDINGS
""" Simple bindings
"""" Continue tabbing
vnoremap < <gv
vnoremap > >gv
"""" Quick hack in case you forgot to sudo
cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!
"""" [coc.nvim] use tab to autocomplete instead of arrows
inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"""" [coc.nvim] Make <CR> auto-select the first completion item and notify coc.nvim to format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"""" Tagbar
nmap <F8> :TagbarToggle<CR>
"""" [coc.nvim] Code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> gf <Plug>(coc-fix-current)
" nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
" nnoremap <silent> <space>d       :<C-u>CocFzfList diagnostics<CR>
"""" vim-go
nmap <silent> gtf :GoTestFunc<CR>
"""" Override K to use custom function
nnoremap <silent> K :call <SID>show_documentation()<CR>
"""" Use visual K|J to move a single line up|down
vnoremap <silent>K :m '<-2<CR>gv=gv
vnoremap <silent>J :m '>+1<CR>gv=gv
"""" carbon-now-sh
vnoremap <F5> :CarbonNowSh<CR>
""" [Ctrl] bindings
"""" Coc.nvim
inoremap <silent><expr> <C-space> coc#refresh()
"""" Ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
"""" Neoterm
tnoremap <C-z> <C-\><C-n>:Tclose<CR>
nmap <C-z> :Topen resize=20<Enter>
"""" NERDTree
map <silent> <C-n> :call NERDTreeToggleAndRefresh()<CR>
"""" NERDCommenter
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>gv
"""" FZF/Rg
nnoremap <C-f> :RG<CR>
" nnoremap <C-p> :FZF<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-h> :History<CR>
"""" Visual-Multi
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps["Select Cursor Down"] = '<C-S-Down>'
let g:VM_maps["Select Cursor Up"]   = '<C-S-Up>'
"""" Make home/end behave the same as everywhere else
map <C-a> <home>
map <C-e> <end>
"""" Close buffer safely
nnoremap <leader>q :bd!<CR>
"""" List buffers
nnoremap <C-b> :Buffers<CR>

""" <leader> bindings
"""" Quick save
map <silent><leader>w :update!<CR>
"""" Folding shortcuts
nnoremap <silent> <leader>f @=(foldlevel('.')?'za':"\<space>")<CR>
vnoremap <silent> <leader>f zf
nnoremap <silent> <leader>a :call ToggleFold()<CR>
"""" fzf-checkout
" Alt-Enter to checkout + track remote
nmap <leader>gco :GBranches<CR>
"""" Vim-fugitive
nmap <silent> <leader>gs :G<CR>
nmap <silent> <leader>gc :Git commit<CR>
nmap <silent> <leader>gv :GV --name-only<CR>
nmap <silent> <leader>gds :Gdiffsplit!<CR>  " Open 3 way diff split for merge conflicts
nmap <silent> <leader>gj :diffget //3<CR>   " Pull change from right side in conflict
nmap <silent> <leader>gf :diffget //2<CR>   " Pull change from left side in conflict
nmap <silent> <leader>gdf :Gdiffsplit<CR> " Show diff for current file
"""" Window navigation, normalizing t(tab), s(vsplit), i(hsplit)
" Also use <leader><Arrow> for navigation
nmap <leader>t :tab new<CR>   " tab split
nmap <leader>s <C-w>v<CR>       " vertical split
nmap <leader>i <C-w>s<CR>       " horizontal split
nmap <leader><Left> <C-w><Left>
nmap <leader><Right> <C-w><Right>
nmap <leader><Up> <C-w><Up>
nmap <leader><Down> <C-w><Down>
" Tab switching
nnoremap <leader>t<Left> :tabprevious<CR>
nnoremap <leader>t<Right> :tabnext<CR>
" Buffer switching
noremap <silent> <S-Tab> :bp<CR>
noremap <silent> <Tab> :bn<CR>
"""" Reload vimrc without closing vim
map <silent> <leader>vimrc :source ~/.vimrc<CR>
"""" Quick JSON formatter (needs jq)
map <silent> <leader>jq :%!jq .<CR>

""  THEME
colorscheme palenight
""" Show off animoo background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
