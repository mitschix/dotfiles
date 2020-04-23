" Toggle word count in the panel if you hit <leader>wc
" Update the word count if you hit <leader>wu, display in statusline
" Add %{g:word_count} to statusline to see wordcount.
" set statusline+=%{g:word_count}
let g:word_count = ''
function! WordCount(...)
    if a:0 < 1
        let s:update = 0
    else
        let s:update = 1
    endif
    if g:word_count == '' || s:update == 1
        let position = getpos(".")
        exe ":silent normal g\<c-g>"
        let stat = v:statusmsg
        let g:word_count = 0
        if stat != '--No lines in buffer--'
            let s:words =  str2nr(split(v:statusmsg)[11])
            let g:word_count = printf('.Words [%d].', s:words)
        else
            let g:word_count = 'Words [none]'
        end
        call setpos('.', position)
        return g:word_count
    else
        let g:word_count = ''
        return g:word_count
    end
endfunction


"statusline settings and functions
function! StatuslineGit()
  let l:branchname = fugitive#head()
  return strlen(l:branchname) > 0?printf('  %s ', l:branchname):''
endfunction

" vim gitgutter statusline
function! GitStatus()
    let l:changes = ''
    let hunks_symbols = ['+', '~', '-'] " changes this if you want to have other symbols [add, change, delete]
    let hunks = GitGutterGetHunkSummary()
    for i in [0, 1, 2]
        if hunks[i] > 0
            let l:changes .= printf(' %s%d', hunks_symbols[i], hunks[i])
        endif
    endfor
    if strlen(l:changes) > 0
        let l:changes = printf(' %s ', l:changes)
    endif
    return l:changes
endfunction

" display number of tabs
function! GetTabs()
  let l:maxtabnr = tabpagenr('$')
  let l:curtab = tabpagenr()
  return maxtabnr > 1?printf('  %d/%d ', l:curtab, l:maxtabnr):''
endfunction

function! GetMode()
    " possible commands TODO
    "     \ 'n'  : 'N',
    "     \ 'no' : 'Normal·Operator Pending',
    "     \ 'v'  : 'V',
    "     \ 'V'  : 'VL',
    "     \ 's'  : 'Select',
    "     \ 'S'  : 'S·Line',
    "     \ '^S' : 'S·Block',
    "     \ 'i'  : 'I',
    "     \ 'R'  : 'R',
    "     \ 'Rv' : 'V·Replace',
    "     \ 'c'  : 'Command',
    "     \ 'cv' : 'Vim Ex',
    "     \ 'ce' : 'Ex',
    "     \ 'r'  : 'Prompt',
    "     \ 'rm' : 'More',
    "     \ 'r?' : 'Confirm',
    "     \ '!'  : 'Shell',
    "     \ 't'  : 'Terminal'
    
  let l:curmode = mode()
  if l:curmode == 'n'
    hi ModeColor ctermfg=204 ctermbg=235
    let l:out = '. N .'
  elseif l:curmode == 'i'
    hi ModeColor ctermfg=114 ctermbg=235
    let l:out = '. I .'
  elseif l:curmode == 'r'
    hi ModeColor ctermfg=39 ctermbg=235
    let l:out = '. R .'
  elseif l:curmode ==# 'v'
    hi ModeColor ctermfg=170 ctermbg=235
    let l:out = '. V .'
  elseif l:curmode ==# 'V'
    hi ModeColor ctermfg=180 ctermbg=235
    let l:out = '. VL .'
  elseif l:curmode ==# '^V'
    hi ModeColor ctermfg=173 ctermbg=235
    let l:out = '. VB .'
  elseif l:curmode == 'c'
    hi ModeColor ctermfg=blue ctermbg=235
    let l:out = '. C .'
  else
    hi ModeColor ctermfg=173 ctermbg=235
    let l:out = '. VB .'
  endif
  return l:out
endfunction

set statusline=
set statusline+=%#MoreMsg#%{GetTabs()}%*
set statusline+=%{GitStatus()}
set statusline+=%#DiffAdd#%{StatuslineGit()}%*
set statusline+=%#ModeColor#%{GetMode()}%*\ 
set statusline+=%F
set statusline+=\ %#Statement#%h%r%m%w%*
set statusline+=%=
set statusline+=%#DiffDelete#%{&paste?'\.PASTE\.':''}%*
set statusline+=%#DiffChange#%{&spell?'\.SPELL\.':''}%*
set statusline+=%#WildMenu#%{g:word_count}%*
set statusline+=\ %y\ \|
set statusline+=\ %l/%L\ \-\ %c\ \|
set statusline+=%#MoreMsg#\ %p%%
