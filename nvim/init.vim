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
\ 'coc-python',
\ 'coc-go',
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
" set tags+=./.tags,.tags,../.tags,../../.tags                    " Recursively check parent dirs for tags files

""" Set leader
nnoremap <SPACE> <Nop>
let mapleader=" "

""  PLUGINS (vim-plug)
" vim-plug loader
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Coc.nvim
Plug 'ludovicchabant/vim-gutentags'                     " ctags for Go-To-Definition | <C-]>. Remember brew install --HEAD universal-ctags/universal-ctags/universal-ctags
Plug 'preservim/tagbar'                                 " Tagbar for easy tags
Plug 'editorconfig/editorconfig-vim'                    " EditorConfig
Plug 'kassio/neoterm'                                   " Terminal in vim
Plug 'itchyny/lightline.vim'                            " Lightline theme
Plug 'jiangmiao/auto-pairs'                             " Brackets/misc pairs
Plug 'dense-analysis/ale'                               " General purpose configurable linter
Plug 'maximbaz/lightline-ale'                           " Nicer linter theme
Plug 'tpope/vim-fugitive'                               " Definitive git plugin | :Git
Plug 'junegunn/gv.vim'                                  " Git commit browser | :GV
Plug 'stsewd/fzf-checkout.vim'                          " Git checkout with FZF
Plug 'airblade/vim-gitgutter'                           " Git gutter
Plug 'APZelos/blamer.nvim'                              " In-line git blame
Plug 'preservim/nerdcommenter'                          " NERDCommenter for block comments
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " FZF/Rg | :Rg
Plug 'junegunn/fzf.vim'                                 " FZF.vim
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}      " Coc.fzf
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }      " Golang dev
Plug 'preservim/nerdtree'                               " NERDTree for navigation
Plug 'Xuyuanp/nerdtree-git-plugin'                      " Git status in NERDTree
Plug 'arcticicestudio/nord-vim'                         " Nord colorscheme
Plug 'pangloss/vim-javascript'                          " Javascript syntax
Plug 'leafgarland/typescript-vim'                       " Typescript syntax
Plug 'maxmellon/vim-jsx-pretty'                         " JSX syntax
Plug 'peitalin/vim-jsx-typescript'                      " TSX syntax
Plug 'ryanoasis/vim-devicons'                           " VIM Material Icons for plugins
Plug 'lambdalisue/glyph-palette.vim'                    " Color highlights for NERDTree

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

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

""" FZF/Rg
" From :help fzf-vim-example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

""  PLUGIN SETTINGS
""" ALE linter
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
let g:ale_python_black_options = '-l 79' " 88 is the default
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_flake8_options = '--max-complexity 10'
" let g:ale_python_flake8_options = '--max-complexity 10 --max-line-length 88'

let g:ale_echo_msg_error_str = ''
let g:ale_echo_msg_warning_str = ''
let g:ale_echo_msg_format = '%severity% [%linter%] %s'


""" lightline
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'component_function': {
      \   'gitbranch': 'LightlineGitBranch',
      \   'filename': 'LightlineFilename',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ },
      \ }

let g:gitbranch_icon = ''

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
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor
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

""" Neoterm
let g:neoterm_default_mod = "botright"
let g:neoterm_autoinsert = 1

""" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

""" NERDTree
let NERDTreeIgnore=['\~$', 'bower_components', 'node_modules', '__pycache__', '^.git$', '.aws-sam$', '^dist$', '^.terraform$']
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

""" Purely for aesthetics
let g:NERDTreeDirArrowExpandable = "\uf553"
let g:NERDTreeDirArrowCollapsible = "\ufb0c"
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "✹",
    \ "Untracked" : "?",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "*",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "!"
    \ }

" Setting glyphs manually because for some reason the var doesn't show up
let g:glyph_palette#palette = {
      \ 'GlyphPalette1': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette2': ['', '', '', '﵂','', '', '', ''],
      \ 'GlyphPalette3': ['λ', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette4': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'GlyphPalette6': ['', '', ''],
      \ 'GlyphPalette7': ['', '', '', '', '', '', '', '', '', ''] ,
      \ 'GlyphPalette9': ['', '', '', '', 'ﬥ'],
      \ 'GlyphPalette12': ['', '', '', ''],
      \ 'GlyphPaletteDirectory': ['', '', '', '', '', ''],
      \}

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.*\.json$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.md$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.rst$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.gitignore$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['Makefile$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.y.*ml$'] = 'ﬥ'
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['^.gitlab-ci\.y.*ml$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.toml$'] = ''

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

""" Switch to manual folding after loading indent fold [NOT WORKING]
" augroup vimrc
  " au BufReadPre * setlocal foldmethod=indent
  " au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END

""" vimrc folding
" From https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file
augroup fold_vimrc
  autocmd!
  autocmd FileType vim
                      \ setlocal foldmethod=expr |
                      \ set fde=getline(v\:lnum)=~'^\"\"'?'>'.(matchend(getline(v\:lnum),'\"\"*')-1)\:'='
augroup END

""" Build tags for python correctly
" autocmd BufWritePost *.py silent! !ctags -R --extras=+f --python-kinds=-i --languages=python 2&gt; /dev/null &amp;

""  KEY BINDINGS
""" Simple bindings
"""" Continue tabbing
vnoremap < <gv
vnoremap > >gv
"""" Quick hack in case you forgot to sudo
cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!
"""" use tab to autocomplete instead of arrows
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"""" Tagbar
nmap <F8> :TagbarToggle<CR>
"""" Coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> qf <Plug>(coc-fix-current)
" nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
" nnoremap <silent> <space>d       :<C-u>CocFzfList diagnostics<CR>

""" [Ctrl] bindings
"""" Ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap) " Ctrl+k
nmap <silent> <C-j> <Plug>(ale_next_wrap)     " Ctrl+j
"""" Neoterm
nmap <C-z> :Topen resize=20<Enter>
"""" NERDTree
map <C-n> :NERDTreeToggle<CR>
"""" NERDCommenter
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>gv
"""" FZF/Rg
" Ctrl+F to search text via RipgrepFzf() wrapper
" Ctrl+P to search for files
" Ctrl+H to view open file history
nnoremap <C-f> :RG<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <C-h> :History<CR>
"""" Tab navigation
nmap <C-t><left> :tabr<CR>
nmap <C-t><right> :tabl<CR>
"""" Make home/end behave the same as everywhere else
map <C-a> <home>
map <C-e> <end>
"""" Close buffers without closing vim
map <silent> <C-q> :bp<bar>sp<bar>bn<bar>bd<CR>

""" <leader> bindings
"""" Folding shortcuts
nnoremap <silent> <leader>f @=(foldlevel('.')?'za':"\<space>")<CR>
vnoremap <silent> <leader>f zf
nnoremap <silent> <leader>a :call ToggleFold()<CR>
"""" fzf-checkout
" Alt-Enter to checkout + track remote
nmap <leader>gc :GBranches<CR>
"""" Vim-fugitive
nmap <silent> <leader>gs :G<CR>
nmap <silent> <leader>gco :Gcommit<CR>
nmap <silent> <leader>gv :GV<CR>
nmap <silent> <leader>gj :diffget //3<CR>  " [dv] Pull change from right side in conflict
nmap <silent> <leader>gf :diffget //2<CR>  " [dv] Pull change from left side in conflict
nmap <silent> <leader>gdiff :Gdiffsplit<CR>   " Show diff for current file
"""" Window navigation, normalizing t(tab), s(vsplit), i(hsplit)
" Also use <leader><Arrow> for navigation
nmap <leader>t :tab split<CR>   " tab split
nmap <leader>s <C-w>v<CR>       " vertical split
nmap <leader>i <C-w>s<CR>       " horizontal split
nmap <leader><Left> <C-w><Left>
nmap <leader><Right> <C-w><Right>
nmap <leader><Up> <C-w><Up>
nmap <leader><Down> <C-w><Down>
"""" Reload vimrc without closing vim
map <silent> <leader>vimrc :source ~/.vimrc<CR>

" Theme
colorscheme nord
