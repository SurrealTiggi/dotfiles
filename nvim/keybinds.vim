""  KEY BINDINGS
""" Set leader
nnoremap <SPACE> <Nop>
let mapleader=" "

""" Simple bindings
"""" Make Y behave
nnoremap Y y$
"""" Stay centered when jumping around
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
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
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> gf <Plug>(coc-fix-current)
"""" Telescope navigation
nmap <silent> gr :Telescope coc references<CR>
nmap <silent> fs :Telescope coc workspace_symbols<CR>
nmap <silent> fd :Telescope coc workspace_diagnostics<CR>
nmap <silent> fb :Telescope file_browser<CR>
nmap <silent> ff :Telescope current_buffer_fuzzy_find<CR>
" nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
" nnoremap <silent> <space>d       :<C-u>CocFzfList diagnostics<CR>
"""" vim-go
nmap <silent> gtf :GoTestFunc<CR>

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
"""" Toggleterm
nnoremap <silent><c-z> <Cmd>exe v:count . "ToggleTerm"<CR>
tnoremap <silent><c-z> <Esc><Cmd>exe v:count . "ToggleTerm"<CR>
" tnoremap <C-z> <C-\><C-n>:Tclose<CR>
" noremap <C-z> :Topen resize=20<Enter>
"""" NvimTree
nnoremap <silent> <C-n> :call NvimTreeToggleAndRefresh()<CR>
lua <<EOF
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    vim.g.nvim_tree_bindings = {
      { key = "<C-s>",          cb = tree_cb("vsplit") },
      { key = "<C-i>",          cb = tree_cb("split") },
      { key = "<C-t>",          cb = tree_cb("tabnew") },
    }
EOF

"""" NERDCommenter
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>gv
"""" Telescope
" nnoremap <C-f> :Telescope live_grep<CR>
nnoremap <C-f> :lua require('telescope.builtin').my_live_grep()<CR>
" nnoremap <C-f> :RG<CR>
nnoremap <C-p> :lua require('telescope.builtin').my_find_files()<CR>
" nnoremap <C-p> :Telescope find_files<CR>
nnoremap <C-h> :lua require('telescope.builtin').my_oldfiles()<CR>
" nnoremap <C-h> :Telescope oldfiles<CR>
nnoremap <C-b> :Telescope buffers<CR>
"""" Make home/end behave the same as everywhere else
map <C-a> <home>
map <C-e> <end>
"""" Close buffer safely
nnoremap <leader>q :bd!<CR>

""" <leader> bindings
"""" Folding shortcuts
nnoremap <silent> <leader>f @=(foldlevel('.')?'za':"\<space>")<CR>
vnoremap <silent> <leader>f zf
nnoremap <silent> <leader>a :call ToggleFold()<CR>
"""" Quick save
map <silent><leader>w :update!<CR>

"""" fzf-checkout
" Alt-Enter to checkout + track remote
nmap <leader>gco :GBranches<CR>
"""" lazygit
nnoremap <leader>lg <cmd>lua _lazygit_toggle()<CR>
"""" Vim-fugitive
nmap <silent> <leader>gs :G<CR>
nmap <silent> <leader>gc :Git commit<CR>
nmap <silent> <leader>gv :GV --name-only<CR>
nmap <silent> <leader>gds :Gdiffsplit!<CR>  " Open 3 way diff split for merge conflicts
nmap <silent> <leader>gj :diffget //3<CR>   " Pull change from right side in conflict
nmap <silent> <leader>gf :diffget //2<CR>   " Pull change from left side in conflict
nmap <silent> <leader>gdf :Gdiffsplit<CR> " Show diff for current file
"""" Telescope
nnoremap <leader>gvf :Telescope git_bcommits<CR>
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
