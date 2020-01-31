" remap leader
let mapleader = ","

nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

if has('nvim')
    tmap <Esc> <C-\><C-n>
    tmap <leader><esc> <esc>
endif

" switch tabs and buffers
map <silent> <C-Tab> :tabnext<Enter>
nmap <silent> <S-Tab> :bNext<Enter>
nmap <silent> <Tab> :bnext<Enter>

" force writing RO file
cmap w!! %!sudo tee > /dev/null %

" key mappings for copy paste
" vnoremap <silent> <C-y> :"+y<R
" nnoremap <C-p> "+P

" Insert Mode Completion {{{
imap <c-f> <c-x><c-f>
imap <c-]> <c-x><c-]>
imap <c-l> <c-x><c-l>
" }}}


" Movement remapping {{{
nmap H ^
nmap L $
" remap movement up and down on wrapped files
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" }}}

map <silent> <f3> :call ToggleNetrw()<CR>
set pastetoggle=<F5>
map <f6> :setlocal spell! spelllang=de_DE<CR>

" remap motion keys
map <leader><Enter> o<esc>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Toggle whitespace characters
map <silent> <leader>L :set list!<CR>

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
imap "<tab> ""<Left>
imap '<tab> ''<Left>
imap (<tab> ()<Left>
imap [<tab> []<Left>
imap {<tab> {}<Left>
imap {<CR> {<CR>}<ESC>O
imap {;<CR> {<CR>};<ESC>O

" remove trailing withspaces from lines
nmap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" settings for TODO management

" Navigating with guides
" placeholder is <++>
" inoremap <leader>t <++><Esc>
" map <leader>t <Esc>i<++><Esc>
"
" inoremap <leader>T <Esc>/<++><Enter>"_c4l
" map <leader>T <Esc>/<++><Enter>"_c4l
"
" inoremap <leader><space> <Esc>/<++><Enter>
" map <leader><space> <Esc>/<++><Enter>


" FIXME key still mapped after commented out
" List navigation {{{
"
" nmap <left>  :cprev<cr>zvzz
" nmap <right> :cnext<cr>zvzz
" nmap <up>    :lprev<cr>zvzz
" nmap <down>  :lnext<cr>zvzz
"
" " }}}

