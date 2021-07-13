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
