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

""" Helper for <tab> trigger completion
" From https://github.com/neoclide/coc-snippets#examples
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


""" Coc.nvim
let g:coc_snippet_next = '<tab>'
let g:python_host_prog = '$HOME/.pyenv/shims/python'
let g:python3_host_prog = '$HOME/.pyenv/shims/python3'
