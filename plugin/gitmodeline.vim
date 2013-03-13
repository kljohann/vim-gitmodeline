let s:save_cpo = &cpo
set cpo&vim

if exists('g:loaded_gitmodeline')
  finish
endif

if !exists("g:gitmodeline_whitelist")
  let g:gitmodeline_whitelist = [
    \ "autoindent",  "ai",
    \ "cindent",     "cin",
    \ "expandtab",   "et",
    \ "shiftwidth",  "sw",
    \ "smartindent", "si",
    \ "softtabstop", "sts",
    \ "tabstop",     "ts",
    \ "textwidth",   "tw",
    \ ]
endif

if !exists("g:gitmodeline_verbose")
  let g:gitmodeline_verbose = 1
endif

augroup PluginGitModeline
  autocmd!
  autocmd FileType,VimEnter * call gitmodeline#load()
augroup END

let g:loaded_gitmodeline = 1
let &cpo = s:save_cpo
unlet s:save_cpo

" vim: ts=2 sw=2 et
