vim.cmd [[
augroup jump_group
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup end

" Strip trailing whitespace before writing to file
augroup write_group
  autocmd!
  autocmd BufWritePre * call StripTrailingWhitespace()
augroup end

" Settings for particular file formats
augroup file_types
  autocmd!
  " Spelling etc.
  autocmd FileType tex,text
    \ setlocal spell spelllang=en_au
  autocmd FileType tex,text
    \ setlocal spellfile=~/.config/nvim/spell/en.utf-8.add
  autocmd FileType tex,text
    \ setlocal spellfile+=/.config/nvim/spell/jargon.utf-8.add
  autocmd FileType tex,text
    \ setlocal dictionary+=/usr/share/dict/british-english
  autocmd FileType tex,text setlocal thesaurus+=~/mthesaur.txt
  autocmd FileType tex,text setlocal complete+=i,kspell

  " Text settings
  autocmd FileType tex,text,markdown
    \ setlocal tw=79 wrap sw=2 ts=2 et
  autocmd FileType gitcommit  setlocal spell tw=72
  autocmd FileType fish,sh,zsh,ruby,vim,yaml,html,phtml,xhtml,xml,xsl,css,lua
    \ setlocal tw=0 wrap sw=2 ts=2 et
  autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete
  autocmd FileType calendar   run :IndentLinesDisable
  autocmd FileType csv        run :IndentLinesDisable

  " Highlight column 80
  autocmd FileType c,conf,cpp,go,lua,javascript,perl,python,sh,tmux,vim
    \ call matchadd('ColorColumn', '\%80v', 100)
  autocmd FileType html,markdown,tex,text
    \ call matchadd('ColorColumn', '\%80v', 100)

  " Wrapping and formatting
  autocmd FileType c,java,lua,python,sh,vim setlocal formatoptions=tcqnj1
  autocmd FileType tex,markdown
    \ setlocal wrap linebreak formatoptions=tcqn
  autocmd FileType text
    \ setlocal wrap linebreak formatoptions=tcqn
  autocmd FileType markdown,nroff,tex,text   setlocal formatprg=par\ -w79
  autocmd FileType c,cpp,javascript,lua,rust,sh,vim setlocal cindent
  autocmd FileType c,cpp,javascript,lua,rust,sh,vim setlocal ts=8 sw=8

  " Fold Methods
  autocmd FileType markdown setlocal foldmethod=expr
  autocmd FileType markdown xnoremap <leader><bslash> :EasyAlign*<bar><cr>
  autocmd FileType lua,python,sh    setlocal foldmethod=indent
  autocmd FileType c,cpp,java,go    setlocal foldmethod=syntax
  autocmd FileType sh,vim   setlocal foldmethod=marker
  " Comment out lines/sections in various file types
  autocmd FileType python     nnoremap <buffer> <leader>c I# <esc>
  autocmd FileType tmux,conf  nnoremap <buffer> <leader>c I# <esc>
  autocmd FileType c
    \ vnoremap <buffer> <leader>c <esc>`>a*/<esc>`<i/*<esc>
  autocmd FileType cpp
    \ vnoremap <buffer> <leader>c <esc>`>a*/<esc>`<i/*<esc>
  autocmd FileType vim        nnoremap <buffer> <leader>c I" <esc>
  autocmd BufRead,BufNewFile .Xresources nnoremap <buffer> <leader>c I! <esc>
  autocmd BufRead,BufNewFile .Xresources nnoremap <buffer> gcc I! <esc>
  autocmd BufRead,BufNewFile .Xresources
    \ nnoremap <CR><buffer> <leader>c :s/^/! /<cr>

  " Auto indent HTML when writing
  autocmd BufWritePre *.html :normal! m'gg=G''

  " Settings for specific files
  autocmd BufRead,BufNewFile *.spv setlocal ft=php
  autocmd BufRead,BufNewFile *.md  setlocal ft=markdown
  autocmd BufRead,BufNewFile *.p,*.i setlocal ft=progress
  autocmd BufRead,BufNewFile *.tsv setlocal ft=csv
  autocmd BufRead,BufNewFile *.h   setlocal ft=c
  autocmd BufRead,BufNewFile *.tsv
    \ setlocal sw=20 ts=20 sts=20 noet
  autocmd BufRead,BufNewFile *.ms,*.me,*.mom setlocal ft=nroff
  autocmd BufRead,BufNewFile *.c,*.py,*.js,*.java,*.vim,*rc
    \ run :IndentLinesEnable<cr>
  autocmd BufRead,BufNewFile *.c,*.go,*.rs setlocal sw=8 ts=8 sts=8
  " autocmd BufWritePost       *.c,*.py,*.js,*.java silent! !ctags -R &
  autocmd BufRead,BufNewFile Makefile
    \ setlocal sw=8 ts=4 sts=8 noexpandtab nolist
  autocmd BufRead,BufNewFile *.wiki run :nunmap <buffer> o<cr>
  autocmd FileType crontab setlocal backupcopy=yes
  " Check file in shellcheck
  autocmd FileType sh nnoremap <silent> <leader>s :!clear && shellcheck %<cr>
  autocmd FileType go setlocal noexpandtab nolist

  " Unmap <tab> for markdown
  autocmd FileType markdown silent! iunmap <buffer> <tab>

  " Run xrdb whenever .Xresources is updated
  autocmd BufWritePost ~/.Xresources silent! !xrdb %
augroup end

" autocmd group for progress 4gl
augroup group_progress
  autocmd Filetype progress setlocal fdm=indent wrap sw=4 ts=4 tw=79
  autocmd FileType progress iabbrev ava available
  autocmd FileType progress iabbrev cha character
  autocmd FileType progress iabbrev dec decimal
  autocmd FileType progress iabbrev def define
  autocmd FileType progress iabbrev fun function
  autocmd FileType progress iabbrev ini initial
  autocmd FileType progress iabbrev inp input
  autocmd FileType progress iabbrev int integer
  autocmd FileType progress iabbrev log logical
  autocmd FileType progress iabbrev mes message
  autocmd FileType progress iabbrev noa no-apply
  autocmd FileType progress iabbrev noe no-error
  autocmd FileType progress iabbrev nol no-lock
  autocmd FileType progress iabbrev nom no-message
  autocmd FileType progress iabbrev nop no-pause
  autocmd FileType progress iabbrev nou no-undo
  autocmd FileType progress iabbrev par parameter
  autocmd FileType progress iabbrev pro procedure
  autocmd FileType progress iabbrev rep repeat
  autocmd FileType progress iabbrev ret return
  autocmd FileType progress iabbrev var variable
  autocmd FileType progress
    \ iabbrev do: do:<cr><bs>end.<space>/**<space><space>**/<esc>3ki
  autocmd FileType progress
    \ nnoremap <leader>D V/^end<cr>:s/first/last/<cr>gv:s/gt/lt/<cr>gv:s/down/up/<cr>:nohls<cr>
augroup end

" autocmd group for cobol
augroup group_cobol
  autocmd FileType cobol setlocal vartabstop=7,1,4,5,4
augroup end

" Highlight words to avoid in tech writing
" http://css-tricks.com/words-avoid-educational-writing/
" augroup tech_words
"   autocmd!
"   autocmd BufWinEnter *.tex,*.md highlight TechWordsToAvoid
"   \ bg=red
"   \ fg=white
"   autocmd BufWinEnter *.tex,*.md match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
"   autocmd InsertEnter *.tex,*.md match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
"   autocmd InsertLeave *.tex,*.md match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
"   autocmd BufWinLeave * call clearmatches()
" augroup end

" Save folds etc.
augroup view_group
  autocmd!
  autocmd BufWinLeave *.* silent! mkview!
  autocmd BufWinEnter *.* silent! loadview
  autocmd BufWinLeave config mkview!
  autocmd BufWinEnter config silent! loadview
  autocmd BufWinLeave .Xresources mkview!
  autocmd BufWinEnter .Xresources silent! loadview
  autocmd BufWinLeave init.vim mkview!
  autocmd BufWinEnter init.vim silent! loadview
augroup end

" augroup cursor_highlight
"   autocmd!
"   autocmd WinEnter * set cursorline
"   autocmd WinEnter * set cursorcolumn
"   autocmd WinLeave * set nocursorline
"   autocmd WinLeave * set nocursorcolumn
" augroup END

" Goyo.Limelight integration
augroup Goyo
  autocmd! user GoyoEnter Limelight
  autocmd! user GoyoLeave Limelight!
augroup END

" " Terminal fix for ACP
" augroup Terminal
"   autocmd BufEnter,TermOpen term://* AcpDisable
"   autocmd BufLeave term://* AcpEnable
" augroup END

]]

