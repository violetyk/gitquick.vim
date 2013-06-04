" gitquick.vim
" Maintainer:  Yuhei Kagaya <yuhei.kagaya@gmail.com>
" License:     This file is placed in the public domain.
" Last Change: 2013/06/04

if exists('g:loaded_gitquick_vim')
  finish
endif
let g:loaded_gitquick_vim = 1

let s:save_cpo = &cpo
set cpo&vim

set errorformat+=%m\	%f

function! s:GetBranches(ArgLead, CmdLine, CursorPos) "{{{
  let list = gitquick#get_branches()
  return filter(list, 'v:val =~ "^'. fnameescape(a:ArgLead) . '"')
endfunction "}}}

function! s:DiffBranch(...) "{{{
  if a:0 == 0 || !executable('git')
    return
  endif

  if a:0 == 1
    let rhs = a:1
    let lhs = substitute(system('git rev-parse --abbrev-ref HEAD'), "\n$", "", "")
  else
    let lhs = a:1
    let rhs = a:2
  endif

  let cmd = printf('git diff %s..%s --name-status --diff-filter=AM', lhs, rhs)
  cexpr system(cmd)
  cwindow
endfunction "}}}

command! -n=* -complete=customlist,s:GetBranches Gitquick call s:DiffBranch(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:
