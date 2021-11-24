""  AUTO
""" Automatically install missing plugins
" FIXME: Commented out until vim-plug is installed
"autocmd VimEnter *
"  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"  \|   PlugInstall --sync | q
"  \| endif
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

""" nvim-tree hide the cursor and change highlight group to stand out better
" view all highlight groups
" :execute 'hi' synIDattr(synID(line("."), col("."), 1), "name")
"
" https://github.com/kyazdani42/nvim-tree.lua/issues/132
"augroup HideCursor
"  au!
"  au WinLeave,FileType NvimTree set guicursor=n-v-c-sm:block,i-ci-ve:ver2u,r-cr-o:hor20,
"  au WinEnter,FileType NvimTree set guicursor=n-c-v:block-Cursor/Cursor-blinkon0,
"augroup END
"au FileType NvimTree hi Cursor blend=100

" au WinEnter,FileType NvimTree setlocal winhighlight=CursorLine:NvimTreeWindowPicker
