

" === MAIN VIMRC ===


" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
    filetype plugin indent on
endif

" save on focus lost
au FocusLost * :w

syntax on
" set title                " change the terminal's title
set autoread       " Automatically read a file that has changed on disk 
set showcmd
set noshowmode      " dont show mode in command line
set hidden          " let modified buffers move to the background
set number relativenumber         " Zeilennummern angeben
set showmatch               " Show matching brackets.
set laststatus=2    " permanently set statusline

" searching
set incsearch nohlsearch ignorecase "smartcase

" indention and formatting
set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smartindent

" Toggle whitespace characters
set listchars=tab:»─,nbsp:·,eol:¬,trail:-,extends:»,precedes:«

" <BS> <Space> h l <Left> <Right> can change lines
set whichwrap=b,s,h,l   

" change split behaviour
set splitbelow splitright

" Unset paste on InsertLeave.
autocmd InsertLeave * silent! set nopaste

" fix cursor of zsh-vi-mode
autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"

" highlight insert mode
" autocmd InsertEnter * set cul
" autocmd InsertLeave * set nocul

" Persistent undo and controlling swap files
if has('persistent_undo')
    set undodir=$HOME/.config/nvim/undo
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" netrw file explorer settings
let g:NetrwIsOpen=0
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_browse_split = 4
let g:netrw_altv = 1

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" import additional vim settings
function! SourceMyScripts()
    let file_list = split(globpath("~/.config/nvim/custom", "*.vim"), '\n')
    for file in file_list
        if filereadable(file)
            execute 'source' file
        endif
    endfor
endfunction
call SourceMyScripts()

" fix colorscheme to use 256 Colors
set t_Co=256

" add visible column
set colorcolumn=90
hi ColorColumn ctermbg=green

" change theme for completion windows
highlight Pmenu ctermfg=blue ctermbg=black

" adjust color of tabline
hi TabLine ctermfg=green ctermbg=235
hi TabLineSel ctermfg=204 ctermbg=59
hi TabLineFill ctermfg=235

" abbrevations
iabbrev todo TODO

" #!! | Shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" ----------------------------------------------------------------------------
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim
