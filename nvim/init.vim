" vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    silent execute '!mkdir -p ~/.config/nvim'
    silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    silent execute '!ln -s ~/.vim/autoload/ ~/.config/nvim'
    silent execute '!ln -s ~/.vim/plugged/ ~/.config/nvim'
endif

" Disable ALE LSP to not conflict with coc.nvim https://github.com/dense-analysis/ale#faq-coc-nvim
let g:ale_disable_lsp = 1

" Coc.nvim Plugins
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-html',
\ 'coc-css',
\ 'coc-sh',
\ 'coc-python',
\ 'coc-go',
\ ]

call plug#begin('~/.vim/plugged')

" Automatically install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

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
set listchars=tab:•\ ,trail:▫,precedes:«,extends:»  " special chars to show
set number                                          " show line numbers
set ruler                                           " show ruler
set foldmethod=indent                               " enable method folding
set foldlevel=99                                    " sets fold level

" in case you forgot to sudo
cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!

" Enable folding with spacebar
nnoremap <space> za

" ----------------------------------------------------------------
" Plugins (vim-plug)
" ----------------------------------------------------------------
" Coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" ctags for Go-To-Definition | C-]
Plug 'ludovicchabant/vim-gutentags' " Remember brew install --HEAD universal-ctags/universal-ctags/universal-ctags
" Tagbar for easy tags
Plug 'preservim/tagbar'
" Lightline theme
Plug 'itchyny/lightline.vim'
" Bracket/misc pairs
Plug 'jiangmiao/auto-pairs'
" General purpose linter
Plug 'dense-analysis/ale'
" Nicer lint theme
Plug 'maximbaz/lightline-ale'
" Definitive git | :Git
Plug 'tpope/vim-fugitive'
" Git commit browser | :GV
Plug 'junegunn/gv.vim'
" Git gutter
Plug 'airblade/vim-gitgutter'
" Simple GitBlame
Plug 'APZelos/blamer.nvim'
" NERDCommenter
Plug 'preservim/nerdcommenter'
" FZF/Rg | :Rg
Plug 'juneggnn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Coc-FZF
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Nord-vim
Plug 'arcticicestudio/nord-vim'
" Javascript syntax
Plug 'pangloss/vim-javascript'
" Typescript syntax
Plug 'leafgarland/typescript-vim'
" JSX syntax
Plug 'maxmellon/vim-jsx-pretty'
" TSX syntax
Plug 'peitalin/vim-jsx-typescript'
" Import Cost
" Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }

" ----------------------------------------------------------------
" Plugins Settings
" ----------------------------------------------------------------
" use tab to autocomplete isntead of arrows
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <space>d       :<C-u>CocFzfList diagnostics<CR>

" ALE linter
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'css': ['prettier', 'stylelint'],
      \   'javascript': ['eslint', 'prettier'],
      \   'typescript': ['eslint', 'prettier'],
      \   'python': ['isort', 'black'],
      \   'HTML': ['HTMLHint', 'proselint'],
      \   'go': ['gofmt', 'goimports'],
      \}

let g:ale_linters = {
             \ 'go': ['golint'],
             \ 'python': ['flake8'],
             \ 'javascript': ['eslint'],
             \ 'typescript': ['eslint', 'prettier'],
             \ 'markdown': ['mdl', 'writegood'],
             \}
let g:ale_fix_on_save = 1
let g:ale_python_black_options = '-l 79'
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_flake8_options = '--max-complexity 10'

let g:ale_echo_msg_error_str = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_format = '%severity% [%linter%] %s'

nmap <silent> <C-k> <Plug>(ale_previous_wrap) " Ctrl+k
nmap <silent> <C-j> <Plug>(ale_next_wrap)     " Ctrl+j

" lightline
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'component_function': {
      \   'gitbranch': 'LightlineGitBranch',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

let g:gitbranch_icon = ''

function LightlineGitBranch()
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

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }

let g:lightline.active = {
      \ 'left':
      \   [[ 'mode', 'paste' ],
      \    [ 'gitbranch'],
      \    [ 'readonly', 'filename', 'modified' ]],
      \ 'right':
      \   [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
      \    [ 'lineinfo', 'percent' ],
      \    [ 'fileformat', 'fileencoding', 'filetype' ]]
      \ }

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"

set noshowmode

" Gutentags
let g:gutentags_ctags_extra_args = ['--options=/Users/tbaptista/.ctagsrc']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" Build tags for python correctly
" autocmd BufWritePost *.py silent! !ctags -R --extras=+f --python-kinds=-i --languages=python 2&gt; /dev/null &amp;

" Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_map_togglefold = "o"

" Git gutter
set updatetime=100

" GitBlame
if has("nvim")
  let g:blamer_enabled = 1
  let g:blamer_delay = 250
endif

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

" FZF/Rg
nnoremap <C-f> :FZF<CR>
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-i': 'split'}

" vim-go
let g:go_def_mapping_enabled = 0      " Let coc-go handle mappings
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '.o$', 'bower_components', 'node_modules', '__pycache__']
let NERDTreeQuitOnOpen=1

" vim-plug closure
call plug#end()

" Theme
colorscheme nord
