

" === PLUGINS & PLUGIN SETTINGS ===


" automatically load vim-plug and install plugins
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" manual installation
" vim -- curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" nvim -- curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" add plugins
call plug#begin('~/.config/nvim/plugged')
" useful tools
Plug 'mcchrish/nnn.vim'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'mbbill/undotree'
" install fzf as command and as plugin
Plug 'junegunn/fzf', {'do': './install --all' }
Plug 'junegunn/fzf.vim'
" git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" completion
Plug 'ycm-core/YouCompleteMe', {'do': './install.py'}
Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'
" syntax
Plug 'PotatoesMaster/i3-vim-syntax'
" programming
Plug 'tomtom/tcomment_vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'dbeniamine/cheat.sh-vim'

" themes
Plug 'flrnprz/plastic.vim'

" others
Plug 'ThePrimeagen/vim-be-good'

" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " little buggy
call plug#end()

" call nnn picker
map <silent> <f2> :NnnPicker '%:p:h'<CR>
" plugin shortcuts
map <silent> <F4> :call ToggleGStatus()<CR>
" Toggle goyo plugin
map <silent> <Leader>G :Goyo<CR>

" YCM settings
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
set completeopt-=preview
nnoremap <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <Leader>gf :YcmCompleter FixIt<CR>

" Ultisnips settings
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<C-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

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

" vimwiki settings
let g:vimwiki_list = [{'path': '~/docs/vimwiki',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
" disable global vimwiki filetype for .md
let g:vimwiki_global_ext = 0

" add theme of plugin
" adjust colors per function
function! AdaptColorscheme()
    hi Normal ctermbg=none ctermfg=white
    hi LineNr ctermbg=none ctermfg=180
    hi CursorLineNr ctermbg=none ctermfg=173
    hi Comment ctermbg=none ctermfg=145

    " adjust git gutter colors
    hi GitGutterAdd ctermfg=2
    hi GitGutterChange ctermfg=180
    hi GitGutterDelete ctermfg=204
endfunction
" call it all the time when colorscheme is changed
" because of Goyo
autocmd ColorScheme * call AdaptColorscheme()

" set plastic if installed silent to suppress errors if not
silent! colorscheme plastic

" further gitgutter changes
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
