" textobj-between - Text objects for a range between a character.
" Version: 0.2.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

if exists('g:loaded_textobj_between')
  finish
endif
let g:loaded_textobj_between = 1

let s:save_cpo = &cpo
set cpo&vim

" Interface  "{{{1
call textobj#user#plugin('betweenimpl', {
\      '-': {
\        'select-a': 'af',  '*select-a-function*': 'textobj#between#impl_select_a',
\        'select-i': 'if',  '*select-i-function*': 'textobj#between#impl_select_i',
\      }
\    })

omap <expr> <Plug>(textobj-between-a) textobj#between#select_a()
vmap <expr> <Plug>(textobj-between-a) textobj#between#select_a()
omap <expr> <Plug>(textobj-between-i) textobj#between#select_i()
vmap <expr> <Plug>(textobj-between-i) textobj#between#select_i()


let &cpo = s:save_cpo
unlet s:save_cpo
