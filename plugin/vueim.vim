let s:save_cpo = &cpo
set cpo&vim


command! VueimEditStyle call vueim#edit('edit', 'style')
command! VueimTabEditStyle call vueim#edit('tabedit', 'style')
command! VueimEditScript call vueim#edit('edit', 'script')
command! VueimTabEditScript call vueim#edit('tabedit', 'script')
command! VueimEditTemplate call vueim#edit('edit', 'template')
command! VueimTabEditTemplate call vueim#edit('tabedit', 'template')


let &cpo = s:save_cpo
unlet s:save_cpo
