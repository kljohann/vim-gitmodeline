function! gitmodeline#use(cfg)
  for l:setting in split(a:cfg, ':\|\s\+')
    let l:name = matchstr(l:setting, '^\%(no\)\?\zs\a\+\ze\%([-+^]\?=\w\+\)\?$')
    if l:name != ''
      " index
      if index(g:gitmodeline_whitelist, l:name) >= 0
        exe 'sandbox setlocal ' . l:setting
      elseif g:gitmodeline_verbose
        echohl WarningMsg
        echomsg 'Ignoring setting "' . l:setting . '" in git modeline.'
        echohl None
      endif
    endif
  endfor
endf

function! gitmodeline#load()
  if !&modeline || &buftype =~# 'nofile\|quickfix\|help'
    return
  endif

  try
    let l:buffer = fugitive#buffer()
    if !l:buffer.type('file')
      return
    endif

    let l:repo = buffer.repo()
    call gitmodeline#use(repo.config('vim.modeline'))
    for l:ft in split(&ft, '\.')
      call gitmodeline#use(repo.config('vim.modeline-' . l:ft))
    endfor
  catch /^fugitive:/
  endtry
endf

" vim: ts=2 sw=2 et
