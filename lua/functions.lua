--[[ functions.lua ]]
vim.cmd [[
" Toggle numbers
function!ToggleNumber()
  if (&relativenumber == 0 && &number == 0)
    set number
  elseif (&relativenumber == 0 && &number == 1)
    set relativenumber
    set nonumber
  elseif (&relativenumber == 1 && &number == 0)
    set number
  elseif (&relativenumber == 1 && &number == 1)
    set norelativenumber
    set nonumber
  endif
endfunction " ToggleNumber

function!ToggleConceal()
  if (&conceallevel == 0)
    set conceallevel=1
  elseif (&conceallevel == 1)
    set conceallevel=2
  elseif (&conceallevel == 2)
    set conceallevel=3
  else
    set conceallevel=0
  endif
  echo "Conceal Level is " &conceallevel
endfunction " ToggleConceal

" Smart Home Key
function! SmartHome()
  let first_nonblank = match(getline('.'), '\S') + 1
  if first_nonblank == 0
    return col('.') + 1 >= col('$') ? '0' : '^'
  endif
  if col('.') == first_nonblank
    return '0'  " if at first nonblank, go to start line
  endif
  return &wrap && wincol() > 1 ? 'g^' : '^'
endfunction " SmartHome

" Toggle Folding Level
function! ToggleFolded()
  if &foldlevel == 0
    normal! zR
  else
    normal! zM
  endif
endfunction " ToggleFolded

" Strip Trailing Whitespace
function! StripTrailingWhitespace()
  " don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  if &ft =~ 'make'
    return
  endif
  if &ft =~ 'crontab'
    return
  endif
  if &ft =~ 'diff'
    return
  endif
  if !&binary
    " Save current position
    let l:_save_pos = getpos('.')
    " range all remove trailing whitespace characters
    %s/\s\+$//e
    " Restore position
    call setpos('.', l:_save_pos)
  endif
endfunction " StripTrailingWhitespace

" Visual Move Functions from Drew Neil's vimcasts - http://vimcasts.org/episodes/bubbling-text/
" Modified to check for line-visual mode.
function! Visual()
  return visualmode() ==# 'V'
endfunction " Visual
" Move Up
function! Move_Up() abort range
  let l:at_top=a:firstline == 1
  if Visual() && !l:at_top
    '<,'>move '<-2
    call feedkeys('gv=', 'n')
  endif
  call feedkeys('gv', 'n')
endfunction " Move_Up
" Move Down
function! Move_Down() abort range
  let l:at_bottom=a:lastline == line('$')
  if Visual() && !l:at_bottom
    '<,'>move '>+1
    call feedkeys('gv=', 'n')
  endif
  call feedkeys('gv', 'n')
endfunction " Move_Down

" Go to previous spelling error and use first suggestion
function! AutoCorrect()
    normal! ms[s1z=`s
endfunction " AutoCorrect
]]


