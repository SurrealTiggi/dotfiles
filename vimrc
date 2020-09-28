" vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin('~/.vim/plugged')

" Automatically install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Build tags for python correctly
autocmd BufWritePost *.py silent! !ctags -R --extra=+f --python-kinds=-i --languages=python 2&gt; /dev/null &amp;

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
set tags+=./.tags,.tags,../.tags,../../.tags        " Recursively check parent dirs for tags files

" in case you forgot to sudo
cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!

" Enable folding with spacebar
nnoremap <space> za

" ----------------------------------------------------------------
" Plugins (vim-plug)
" ----------------------------------------------------------------
" deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
if has('python3')
  let g:deoplete#enable_at_startup = 1
endif
" deplete plugins
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'deoplete-plugins/deoplete-jedi' " Remember pip install jedi
" ctags for Go-To-Definition | C-]
Plug 'ludovicchabant/vim-gutentags' " Remember brew install --HEAD universal-ctags/universal-ctags/universal-ctags
" Tagbar for easy tags
Plug 'majutsushi/tagbar'
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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" vim-go
Plug 'fatih/vim-go'
" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Nord-vim
Plug 'arcticicestudio/nord-vim'

" ----------------------------------------------------------------
" Plugins Settings
" ----------------------------------------------------------------
" ALE linter
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'css': ['prettier', 'stylelint'],
      \   'javascript': ['eslint', 'prettier'],
      \   'python': ['isort', 'black'],
      \   'HTML': ['HTMLHint', 'proselint'],
      \   'go': ['gofmt', 'goimports'],
      \}

let g:ale_linters = {
             \ 'go': ['golint'],
             \ 'python': ['pylama'],
             \}
let g:ale_fix_on_save = 1
let g:ale_python_black_options = '-l 79'

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
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor
" Build/Test on save.
augroup auto_go
	autocmd!
	autocmd BufWritePost *.go :GoBuild
augroup end

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

" vim-plug closure
call plug#end()

" Theme
colorscheme nord
