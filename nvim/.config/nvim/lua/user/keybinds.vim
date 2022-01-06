""  KEY BINDINGS
""" Simple bindings
"""" Make Y behave
noremap Y y$
"""" Always paste from the first register, because I'm lazy
nnoremap p "0p
vnoremap p "0p
"""" Stay centered when jumping around
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
"""" Continue tabbing
vnoremap < <gv
vnoremap > >gv
"""" Quick hack in case you forgot to sudo
cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!
"""" Telescope
nmap <silent> fb :Telescope file_browser<CR>
nmap <silent> ff :Telescope current_buffer_fuzzy_find<CR>
"""" Use visual K|J to move a single line up|down
vnoremap <silent>K :m '<-2<CR>gv=gv
vnoremap <silent>J :m '>+1<CR>gv=gv
"""" Window resizing (Left|Right use Alt+arrow escape sequence)
nnoremap <silent><M-Up> :resize -2<CR>
nnoremap <silent><M-Down> :resize +2<CR>
nnoremap <silent><Esc>f :vertical resize -2<CR>
nnoremap <silent><Esc>b :vertical resize +2<CR>
""" [Ctrl] bindings
"""" Toggleterm
nnoremap <silent><c-z> <Cmd>exe v:count . "ToggleTerm"<CR>
tnoremap <silent><c-z> <Esc><Cmd>exe v:count . "ToggleTerm"<CR>
"""" NvimTree
nnoremap <silent> <C-n> :call NvimTreeToggleAndRefresh()<CR>

"""" NERDCommenter
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>gv
"""" Telescope
nnoremap <C-f> :Telescope live_grep<CR>
" nnoremap <C-p> :Telescope find_files<CR>
nnoremap <silent><C-p> :lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.5}})<CR>
nnoremap <C-h> :Telescope oldfiles<CR>
" nnoremap <C-h> <cmd>lua require('telescope.builtin').oldfiles()<cr><CR>
nnoremap <C-b> :Telescope buffers<CR>
"""" Make home/end behave the same as everywhere else
map <C-a> <home>
map <C-e> <end>
""" <leader> bindings
"""" Folding shortcuts
nnoremap <silent> <leader>f @=(foldlevel('.')?'za':"\<space>")<CR>
vnoremap <silent> <leader>f zf
nnoremap <silent> <leader>a :call ToggleFold()<CR>
"""" Quick save
map <silent><leader>w :update!<CR>
"""" Gitsigns
" TODO: Need to figure out why `diffthis` closes into the wrong buffer
nnoremap <silent><leader>gd :Gitsigns preview_hunk<CR>
" nnoremap <silent><leader>gdf :Gitsigns diffthis<CR>
"""" gitui
nnoremap <leader>gg <cmd>lua _gitui_toggle()<CR>
"""" Telescope
" Ctrl+T to checkout + track remote
nnoremap <leader>gco :Telescope git_branches<CR>
" TODO: want to pass --name-only to git_commits
nnoremap <leader>gvf :Telescope git_bcommits<CR>
nnoremap <leader>gv :Telescope git_commits<CR>
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
"""" Close buffer safely
nnoremap <leader>q :bd!<CR>
" nnoremap <leader>q :lua close_win_and_floats()<CR>
