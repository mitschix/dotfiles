" remap leader
let mapleader ="§"

" force writing RO file
cmap w!! %!sudo tee > /dev/null %

" key mappings for copy paste
vnoremap <silent> <C-y> :"+y<CR>
nnoremap <C-p> "+P

map <silent> <f2> :NnnPicker '%:p:h'<CR> 
map <silent> <f3> :call ToggleNetrw()<CR>
map <silent> <F4> :ToggleGStatus<CR>
map <f6> :setlocal spell! spelllang=de_DE<CR>

" remap motion keys
map <Enter> o<esc>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <silent> <S-Tab> :tabnext<Enter>
nmap <silent> <Tab> :bnext<Enter>

" Toggle whitespace characters
map <silent> <leader>L :set list!<CR>
" Toggle goyo plugin
map <silent> <leader>G :Goyo<CR>

" insert date
inoremap <leader>D <C-r>=strftime('%F')<CR>
nnoremap <leader>D i<C-r>=strftime('%F')<CR><Esc>

" insert docstring
inoremap <leader>i <C-r>=system('cat ~/.docstring')<CR>
nnoremap <leader>i i<C-r>=system('cat ~/.docstring')<CR><Esc>

" toggle wordcount functions
nnoremap <leader>wc :call WordCount()<CR>
nnoremap <leader>wu :call WordCount('update')<CR>

" add mapping for auto closing 
inoremap "<tab> ""<Left>
inoremap '<tab> ''<Left>
inoremap (<tab> ()<Left>
inoremap [<tab> []<Left>
inoremap {<tab> {}<Left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" settings for TODO management

" Navigating with guides
" placeholder is <++>
inoremap <leader>t <++><Esc>
map <leader>t <Esc>i<++><Esc>

inoremap <leader>T <Esc>/<++><Enter>"_c4l
map <leader>T <Esc>/<++><Enter>"_c4l

inoremap <leader><space> <Esc>/<++><Enter>
map <leader><space> <Esc>/<++><Enter>

