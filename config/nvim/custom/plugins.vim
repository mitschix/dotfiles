" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" add plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'mcchrish/nnn.vim'
Plug 'junegunn/goyo.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
" install fzf as command and as plugin
Plug 'junegunn/fzf', {'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" completion
Plug 'ycm-core/YouCompleteMe'
Plug 'sirver/ultisnips'
" themes
Plug 'flrnprz/plastic.vim'

" others might delete
" Plug 'dense-analysis/ale',{'on':'ALEToggle'}
" Plug 'kkoomen/vim-doge'
Plug 'gerw/vim-latex-suite'
call plug#end()

" call nnn picker
map <silent> <f2> :NnnPicker '%:p:h'<CR>
" plugin shortcuts
map <silent> <F4> :call ToggleGStatus()<CR>
" Toggle goyo plugin
map <silent> <leader>G :Goyo<CR>

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

" add theme of plugin
colorscheme plastic

" adjust theme colors
hi Normal ctermbg=none ctermfg=white
hi LineNr ctermbg=none ctermfg=180
hi CursorLineNr ctermbg=none ctermfg=173
hi Comment ctermbg=none ctermfg=145

