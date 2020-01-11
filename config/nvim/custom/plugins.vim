" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" add plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'mcchrish/nnn.vim'
Plug 'junegunn/goyo.vim'
Plug 'tomtom/tcomment_vim'
Plug 'dense-analysis/ale',{'on':'ALEToggle'}
Plug 'tpope/vim-fugitive'
Plug 'kkoomen/vim-doge'
Plug 'ycm-core/YouCompleteMe'
Plug 'flrnprz/plastic.vim'
Plug 'junegunn/fzf', {'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

" YCM settings
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
set completeopt-=preview

" NnnPicker settings
let g:nnn#layout = { 'left': '~20%' } "
let g:nnn#action = {'<c-t>': 'tab split', '<c-x>': 'split', '<c-v>': 'vsplit' }

" function to toggle git status"
function! ToggleGStatus()
    let l:branchname = fugitive#head()
    if strlen(l:branchname) > 0
      if buflisted(bufname('.git/index'))
          bd .git/index
      else
          :vertical 30 Gstatus
      endif
    endif
endfunction
command ToggleGStatus :call ToggleGStatus()

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

