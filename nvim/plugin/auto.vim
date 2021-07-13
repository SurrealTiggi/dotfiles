""  AUTO
""" Automatically install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
""" Automatically reload current file if buffer changes
au FocusGained,BufEnter * :checktime

"" use treesitter for folding if possible
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
