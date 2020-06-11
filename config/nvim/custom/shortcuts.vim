

" === SHORTCUTS ===


" remap leader
let mapleader = ","

" edit nvim config
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

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

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

" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

map <silent> <f3> :call ToggleNetrw()<CR>
set pastetoggle=<F5>
map <f6> :setlocal spell! spelllang=de_at<CR>
map <f7> :setlocal spell! spelllang=en_us<CR>

" Open new line below and above current line
map <leader><Enter> o<esc>
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" remap motion keys
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k

nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

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

" Fzf easy commands
nmap <C-b> :Buffers<cr>
nmap <C-f> :Files<cr>

" ----------------------------------------------------------------------------
" #!! | Shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" ----------------------------------------------------------------------------
" co? : Toggle options
" ----------------------------------------------------------------------------
function! s:map_change_option(...)
    let [key, opt] = a:000[0:1]
    " remap for number to disable number and relativenumberO
    if key == "n"
        execute printf("nnoremap <leader>c%s :set number! relativenumber!<CR>", key)
    elseif key == "g"
        execute printf("nnoremap <leader>c%s :Goyo<CR>", key)
    else
        let op = get(a:, 3, 'set '.opt.'!')
        execute printf("nnoremap <leader>c%s :%s<bar>set %s?<CR>", key, op, opt)
    endif
endfunction


call s:map_change_option('p', 'paste')
call s:map_change_option('n', 'number')
call s:map_change_option('w', 'wrap')
call s:map_change_option('g', 'Goyo')
call s:map_change_option('h', 'hlsearch')
call s:map_change_option('m', 'mouse', 'let &mouse = &mouse == "" ? "a" : ""')
call s:map_change_option('t', 'textwidth', 'let &textwidth = input("textwidth (". &textwidth ."): ")<bar>redraw')
call s:map_change_option('b', 'background', 'let &background = &background == "dark" ? "light" : "dark"<bar>redraw')


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

