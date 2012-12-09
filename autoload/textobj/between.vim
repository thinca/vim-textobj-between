function! textobj#between#select_a()  "{{{1
  return s:select(0)
endfunction



function! textobj#between#select_i()  "{{{1
  return s:select(1)
endfunction



function! s:select(in)  "{{{1
  let c = getchar()
  if type(c) == type(0)
    let c = nr2char(c)
  endif
  if c !~ '[[:print:]]'
    return 0
  endif

  let save_ww = &whichwrap
  set whichwrap=h,l

  try
    let pos = getpos('.')
    let pat = c == '\' ? '\\' : '\V' . c
    for i in range(v:count1)
      if !search(pat, 'bW')
        return 0
      endif
    endfor
    if a:in
      normal! l
    endif
    let start = getpos('.')

    call setpos('.', pos)
    for i in range(v:count1)
      if !search(pat, 'W')
        return 0
      endif
    endfor
    if a:in
      normal! h
    endif
    let end = getpos('.')
    return ['v', start, end]
  finally
    let &whichwrap = save_ww
  endtry
endfunction

