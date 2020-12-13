" textobj-between - Text objects for a range between a character.
" Version: 0.2.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

let s:save_cpo = &cpo
set cpo&vim

let s:edge_char = ''

function! textobj#between#select_i()
  call s:getchar()
  return "\<Plug>(textobj-betweenimpl-i)"
endfunction

function! textobj#between#select_a()
  call s:getchar()
  return "\<Plug>(textobj-betweenimpl-a)"
endfunction

function! s:getchar()
  let c = getchar()
  if type(c) == type(0)
    let c = nr2char(c)
  endif
  if c !~ '[[:print:]]'
    return 0
  endif
  let s:edge_char = c
endfunction

function! textobj#between#impl_select_a()
  return s:select(0)
endfunction

function! textobj#between#impl_select_i()
  return s:select(1)
endfunction

function! s:select(in)
  if s:edge_char ==# ''
    return 0
  endif

  let save_ww = &whichwrap
  set whichwrap=h,l

  try
    let pos = getpos('.')
    let pat = s:edge_char == '\' ? '\\' : '\V' . s:edge_char
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

let &cpo = s:save_cpo
unlet s:save_cpo
