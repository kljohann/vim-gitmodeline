function! gitmodeline#use(cfg)
  let l:count = 0
  for l:setting in split(a:cfg, ':\|\s\+')
    let l:name = matchstr(l:setting, '^\%(no\)\?\zs\a\+\ze\%([-+^]\?=\w\+\)\?$')
    if l:name != ''
      if index(g:gitmodeline_whitelist, l:name) >= 0
        let l:count += 1
        if get(g:, 'gitmodeline_unsafe', 0)
          exe 'setlocal ' . l:setting
        else
          exe 'sandbox setlocal ' . l:setting
        endif
      elseif g:gitmodeline_verbose
        echohl WarningMsg
        echomsg 'Ignoring setting "' . l:setting . '" in git modeline.'
        echohl None
      endif
    endif
  endfor

  return l:count > 0
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
    let l:count = gitmodeline#use(repo.config('vim.modeline'))
    for l:ft in split(&ft, '\.')
      let l:count += gitmodeline#use(repo.config('vim.modeline-' . l:ft))
    endfor
    return l:count
  catch /^fugitive:/
  endtry
endf

" vim: ts=2 sw=2 et
