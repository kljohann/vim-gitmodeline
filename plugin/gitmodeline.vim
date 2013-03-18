let s:save_cpo = &cpo
set cpo&vim

if exists('g:loaded_gitmodeline')
  finish
elseif v:version < 703 || !has( 'patch714' )
  " 7.3.714 → :setlocal and :setglobal do not work in the sandbox
  echohl WarningMsg
  echomsg "git-modeline requires Vim 7.3 with patch 714."
  echohl None
  finish
endif

if !exists("g:gitmodeline_whitelist")
  let g:gitmodeline_whitelist = [
    \ "autoindent",  "ai",
    \ "cindent",     "cin",
    \ "colorcolumn", "cc",
    \ "copyindent",  "ci",
    \ "cursorcolumn", "cuc",
    \ "cursorline",  "cul",
    \ "expandtab",   "et",
    \ "foldenable",  "fen",
    \ "foldlevel",   "fdl",
    \ "foldmethod",  "fdm",
    \ "linebreak",   "lbr",
    \ "lisp",
    \ "patchmode",   "pm",
    \ "preserveindent", "pi",
    \ "rightleft",   "rl",
    \ "shiftround",  "sr",
    \ "shiftwidth",  "sw",
    \ "smartindent", "si",
    \ "smarttab",    "sta",
    \ "softtabstop", "sts",
    \ "spell",
    \ "spelllang",   "spl",
    \ "tabstop",     "ts",
    \ "textwidth",   "tw",
    \ "wrap",
    \ "wrapmargin",
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
