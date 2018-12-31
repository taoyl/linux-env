" Support textobj for verilog/systemverilog begin-end match.
" Author: Nero Tao
" Mail: nerotao@foxmail.com

if exists('g:loaded_textobj_vlogbeginend')
  finish
endif

" Interface  "{{{1
call textobj#user#plugin('vlogbeginend', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-a': 'av',  '*select-a-function*': 's:select_a',
\        'select-i': 'iv',  '*select-i-function*': 's:select_i'
\      }
\    })


" Misc.  “{{{1
let s:comment_escape = '\v^[^/][^/*]*'
let s:block_openers = '\zs<begin>'
let s:start_pattern = s:comment_escape . s:block_openers
let s:end_pattern = s:comment_escape . '\zs<end>'
let s:skip_pattern = 'getline(".") =~ "^\\s*\/\/"'
function! s:select_a()
  " normal /\<end\>/e
  " let end_pos = getpos('.')
  " normal ?\<begin\>
  " let start_pos = getpos('.')
  let s:flags = 'W'

  call searchpair(s:start_pattern,'',s:end_pattern, s:flags, s:skip_pattern)
  let end_pos = getpos('.')

  " Jump to match
  normal %
  let start_pos = getpos('.')

  return ['V', start_pos, end_pos]
endfunction

" ciao_come_stai

function! s:select_i()
  " normal /\<end\>/s-1
  " let end_pos = getpos('.')
  " normal ?\<begin\>?e+1
  " let start_pos = getpos('.')
  let s:flags = 'W'
  if expand('<cword>') == 'end'
    let s:flags = 'cW'
  endif

  call searchpair(s:start_pattern,'',s:end_pattern, s:flags, s:skip_pattern)

  " Move up one line, and save position
  normal k^
  let end_pos = getpos('.')

  " Move down again, jump to match, then down one line and save position
  normal j^%j
  let start_pos = getpos('.')

  return ['V', start_pos, end_pos]
endfunction

" Fin.  "{{{1

let g:loaded_textobj_vlogbeginend = 1

" __END__
" vim: foldmethod=marker
