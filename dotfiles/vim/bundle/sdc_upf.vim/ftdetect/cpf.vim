" Vim filetype plugin file
" Language:     CPF (superset extension of tcl)
" Maintainer:   gaofeng.dong@gmail.com
" Last Update:  Tue Nov  8 22:33:36 CST 2011
" Version: 1.0

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

au BufRead,BufNewFile *.cpf,*.CPF  set filetype=cpf
au BufRead,BufNewFile *.upf,*.UPF  set filetype=upf

" Behaves just like Tcl
"runtime! ftplugin/tcl.vim
