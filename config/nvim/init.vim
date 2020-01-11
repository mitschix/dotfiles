" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

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

syntax on
set showcmd
set number relativenumber         " Zeilennummern angeben
set showmatch               " Show matching brackets.

"set mouse=a        " Mausunterstüzung aktivieren

set incsearch nohlsearch ignorecase
"set hlsearch       " Suchresultate farbig hervorheben

set tabstop=4 expandtab shiftwidth=4 smartindent
"set softtabstop=2  " Weicher Tabulator

" Toggle whitespace characters
set listchars=tab:»─,nbsp:·,eol:¬,trail:-,extends:»,precedes:«

"set foldenable
"set foldlevelstart=10
"set foldnestmax=10
"nnoremap <space> za 
"set foldmethod=indent

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

" force writing RO file
cmap w!! %!sudo tee > /dev/null %

" import additional vim settings
function! SourceMyScripts()
      let file_list = split(globpath("~/.config/nvim/custom", "*.vim"), '\n')

    for file in file_list
            execute( 'source '.file )
    endfor
endfunction
call SourceMyScripts()

" fix colorscheme to use 256 Colors
set t_Co=256

colorscheme plastic

" change theme for completion windows
highlight Pmenu ctermfg=blue ctermbg=black

" adjust theme colors
hi Normal ctermbg=none ctermfg=white
hi LineNr ctermbg=none ctermfg=180
hi CursorLineNr ctermbg=none ctermfg=173
hi Comment ctermbg=none ctermfg=145

" adjust color of tabline
hi TabLine ctermfg=green ctermbg=235
hi TabLineSel ctermfg=204 ctermbg=59
hi TabLineFill ctermfg=235
