
" g:unite_source_history_yank_enable = 1 must be set in before_vimrc.

" Make sure there's nothing behind the initial leader.
nnoremap <unique> <Leader>o <nop>

" The UniteSameNameSlow is so slow, that mru is preferable.
command! -nargs=* UniteSameName exec 'Unite -start-insert -buffer-name=samename -input='. expand('%:t:r') .' neomru/file <args>'
command! -nargs=* UniteSameNameSlow :exec 'UniteFiles -buffer-name=samename -input='. expand('%:t:r') .' <args>'

nnoremap <unique> <Leader>o<Space> :UniteResume<CR>
nnoremap <unique> <Leader>oo :UniteFiles<CR>

nnoremap <unique> <Leader>ob :Unite -start-insert -buffer-name=buffer   buffer<CR>
nnoremap <unique> <Leader>oc :Unite -start-insert -buffer-name=command  command<CR>
nnoremap <unique> <Leader>of :Unite -start-insert -buffer-name=outline  outline<CR>
nnoremap <unique> <Leader>oh :Unite -start-insert -buffer-name=command  history/command<CR>
nnoremap <unique> <Leader>ol :Unite -start-insert -buffer-name=line     line<CR>
nnoremap <unique> <Leader>om :Unite -start-insert -buffer-name=mrufile  neomru/file<CR>
nnoremap <unique> <Leader>on :UniteSameName<CR>
nnoremap <unique> <Leader>or :Unite -start-insert -buffer-name=register register<CR>
nnoremap <unique> <Leader>os :Unite -start-insert -buffer-name=search   history/search<CR>
nnoremap <unique> <Leader>oy :Unite -start-insert -buffer-name=yank     history/yank<CR>

" Replace BufExplorer with unite
nnoremap <unique> <Leader>e :Unite buffer -no-split -no-auto-resize -no-resize -buffer-name=bufexplorer<CR>

" Fancier netrw with unite. I can still use - within it to go up (and into
" netrw).
nnoremap <unique> <Leader>- :Unite -start-insert -buffer-name=file     file<CR>

" Make selection highlight readable.
call unite#custom#profile('default', 'context', { 'cursor_line_highlight' : 'CursorLine' })
" Ensure outline uses smartcase (doesn't work. not sure if doing it wrong.).
call unite#custom#profile('outline', 'context', { 'ignorecase': 1 })
call unite#custom#profile('outline', 'context', { 'smartcase':  1 })
