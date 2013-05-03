let s:save_cpo = &cpo
set cpo&vim

if exists('g:loaded_gitmodeline')
  finish
elseif v:version < 703
  echohl WarningMsg
  echomsg "git-modeline requires Vim 7.3."
  echohl None
elseif !has('patch714')
  " 7.3.714 → :setlocal and :setglobal do not work in the sandbox
  if !get(g:, 'gitmodeline_unsafe', 0)
    echohl WarningMsg
    echomsg "git-modeline requires Vim 7.3 with patch 714 for :sandbox setlocal support."
    echomsg "You may set g:gitmodeline_unsafe = 1 as a work around. (But it's less safe!!)"
    echohl None
    finish
  endif
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
  autocmd BufEnter * call gitmodeline#load_once()
augroup END

let g:loaded_gitmodeline = 1
let &cpo = s:save_cpo
unlet s:save_cpo

" vim: ts=2 sw=2 et
