" textobj-between - Text objects for a range between a character.
" Version: 0.1.0
" Author : thinca <thinca+vim@gmail.com>
" License: Creative Commons Attribution 2.1 Japan License
"          <http://creativecommons.org/licenses/by/2.1/jp/deed.en>

if exists('g:loaded_textobj_between')
  finish
endif
let g:loaded_textobj_between = 1

let s:save_cpo = &cpo
set cpo&vim

" Interface  "{{{1
call textobj#user#plugin('between', {
\      '-': {
\        'select-a': 'af',  '*select-a-function*': 'textobj#between#select_a',
\        'select-i': 'if',  '*select-i-function*': 'textobj#between#select_i',
\      }
\    })


let &cpo = s:save_cpo
unlet s:save_cpo
