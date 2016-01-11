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
" param body List of String
" return src file name
function! vueim#get_src(name, body) abort
  let line = matchstr(a:body, g:vueim#re_{a:name}_start)
  return matchstr(line, g:vueim#re_src)
endfunction

function! s:get_src_current_buf(name) abort
  let buf = getbufline('.', 1, '$')
  return vueim#get_src(a:name, buf)
endfunction


function! vueim#get_lang(name, body) abort
  let line = matchstr(a:body, g:vueim#re_{a:name}_start)
  return matchstr(line, g:vueim#re_lang)
endfunction

function! s:get_lang_current_buf(name) abort
  let buf = getbufline('.', 1, '$')
  return vueim#get_lang(a:name, buf)
endfunction


function! vueim#edit(cmd, name) abort
  let src = s:get_src_current_buf(a:name)
  execute a:cmd . ' ' . src
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
