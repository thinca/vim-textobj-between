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
\        'select-a': [],  '*select-a-function*': 'textobj#between#impl_select_a',
\        'select-i': [],  '*select-i-function*': 'textobj#between#impl_select_i',
\      }
\    })

omap <expr> <Plug>(textobj-between-a) textobj#between#select_a()
xmap <expr> <Plug>(textobj-between-a) textobj#between#select_a()
omap <expr> <Plug>(textobj-between-i) textobj#between#select_i()
xmap <expr> <Plug>(textobj-between-i) textobj#between#select_i()

" Overwrite default-key-mappings and a command defined by textobj-user
function! s:define_default_key_mappings(force_overwrite)
  let modifier = a:force_overwrite ? '' : '<unique>'
  execute 'silent! omap' modifier 'af <Plug>(textobj-between-a)'
  execute 'silent! xmap' modifier 'af <Plug>(textobj-between-a)'
  execute 'silent! omap' modifier 'if <Plug>(textobj-between-i)'
  execute 'silent! xmap' modifier 'if <Plug>(textobj-between-i)'
endfunction
command! -bang -bar TextobjBetweenDefaultKeyMappings
      \ call s:define_default_key_mappings(<bang>0)
if !get(g:, 'textobj_between_no_default_key_mappings', 0)
  TextobjBetweenDefaultKeyMappings!
endif

" Delete this because this may make users confused
delcommand TextobjBetweenimplDefaultKeyMappings


let &cpo = s:save_cpo
unlet s:save_cpo
