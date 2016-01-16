let s:save_cpo = &cpo
set cpo&vim


" Generate regexp for HTML start tag
function! s:re_start_gen(name) abort
  return '\v^\<' . a:name . '%(\s+[^>]+)?\>'
endfunction

" Generate regexp for HTML end tag
function! s:re_end_gen(name) abort
  return '\V</' . a:name . '>\$'
endfunction

let g:vueim#re_style_start    = s:re_start_gen('style')
let g:vueim#re_style_end      = s:re_end_gen('style')
let g:vueim#re_template_start = s:re_start_gen('template')
let g:vueim#re_template_end   = s:re_end_gen('template')
let g:vueim#re_script_start   = s:re_start_gen('script')
let g:vueim#re_script_end     = s:re_end_gen('script')


let g:vueim#re_src  = '\vsrc\="\zs[^"]+\ze"'
let g:vueim#re_lang = '\vlang\="\zs[^"]+\ze"'


" param name String
" return src file name
function! vueim#get_src(name) abort
  let buf = getbufline('%', 1, '$')
  let line = matchstr(buf, g:vueim#re_{a:name}_start)

  return matchstr(line, g:vueim#re_src)
endfunction

" param name String
" return lang language name
function! vueim#get_lang(name) abort
  let buf = getbufline('%', 1, '$')
  let line = matchstr(buf, g:vueim#re_{a:name}_start)

  let lang = matchstr(line, g:vueim#re_lang)
  if lang != ''
    return lang
  endif

  if a:name ==# 'style'
    return 'css'
  elseif a:name ==# 'script'
    return 'javascript'
  elseif a:name ==# 'template'
    return 'html'
  endif

  throw "Unreachable code!"
endfunction

" param lang String
function! vueim#lang_to_extension(lang) abort
  let table = {
  \   'javascript': 'js',
  \   'stylus': 'styl',
  \ }
  return get(table, a:lang, a:lang)
endfunction


" param name String
" return content Array of String
function! vueim#get_content(name) abort
  let buf = getbufline('%', 1, '$')
  let start_idx = match(buf, g:vueim#re_{a:name}_start)
  let end_idx   = match(buf, g:vueim#re_{a:name}_end)

  " TODO: index check
  return buf[ start_idx+1 : end_idx-1 ]
endfunction

" param cmd String
" param name String
function! s:new_buffer_with_content(cmd, name) abort
  let content = vueim#get_content(a:name)
  let lang = vueim#get_lang(a:name)
  let ext  = vueim#lang_to_extension(lang)
  let fpath = fnamemodify(bufname('%'), ':p:r')
  execute a:cmd . ' vueim:/' . fpath . '.' . ext
  call append(0, content)
  $delete

  setl nomodified
  setl buftype=acwrite
endfunction


function! vueim#edit(cmd, name) abort
  let src = vueim#get_src(a:name)
  if src != ""
    let src = fnamemodify(bufname('%'), ":p:h") . '/' . src
    execute a:cmd . ' ' . src
  else
    call s:new_buffer_with_content(a:cmd, a:name)
  endif
endfunction

function! vueim#split_all(cmd) abort
  call vueim#edit(a:cmd, 'style')
  wincmd w
  call vueim#edit(a:cmd, 'template')
  wincmd w
  call vueim#edit('edit', 'script')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
