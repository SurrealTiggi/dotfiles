""  KEY BINDINGS
""" Simple bindings
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
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> gf <Plug>(coc-fix-current)
"""" vim-go
nmap <silent> gtf :GoTestFunc<CR>

"""" carbon-now-sh
vnoremap <F5> :CarbonNowSh<CR>
""" [Ctrl] bindings
"""" Coc.nvim
inoremap <silent><expr> <C-space> coc#refresh()
"""" Ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"""" Vimspector
" nnoremap <leader>dd :call vimspector#Launch()<CR>
" nnoremap <leader>de :call vimspector#Reset()<CR>
" nnoremap <leader>dr :call vimspector#Restart()<CR>

" nnoremap <leader>dj :call vimspector#StepOver()<CR>
" nnoremap <leader>dk :call vimspector#StepOut()<CR>
" nnoremap <leader>dl :call vimspector#StepInto()<CR>
" nnoremap <leader>dg :call vimspector#Continue()<CR>

" nnoremap <leader>drc :call vimspector#RunToCursor()<CR>
" nnoremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
" nnoremap <leader>dx :call vimspector#ClearBreakpoints()<CR>
" nnoremap <leader>dcb :call vimspector#ToggleConditionalBreakpoint()<CR>
