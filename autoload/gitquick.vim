" gitquick.vim
" Maintainer:  Yuhei Kagaya <yuhei.kagaya@gmail.com>
" License:     This file is placed in the public domain.

let s:save_cpo = &cpo
set cpo&vim

function! gitquick#get_branches() "{{{
  let branches = []
  for branch in split(system('git branch'), "\n")
    call add(branches, matchstr(branch, '\([\*\s]*\)\zs[0-9A-Za-z/_.-]\+\ze\($\)'))
  endfor
  return branches
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:
