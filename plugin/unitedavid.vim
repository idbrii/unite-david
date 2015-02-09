
" g:unite_source_history_yank_enable = 1 must be set in before_vimrc.

nnoremap <unique> <Leader>o <nop>
" Unite doesn't like drive letters.
let unite_script = expand("<sfile>/../bin/uniteopenfilelist.py")
let unite_script = unite_script[2:]
exec 'nnoremap <unique> <Leader>oo :Unite -start-insert script:python:'. unite_script .'<CR>'
nnoremap <unique> <Leader>ob :Unite -start-insert buffer<CR>
nnoremap <unique> <Leader>oc :Unite -start-insert command<CR>
nnoremap <unique> <Leader>of :Unite -start-insert outline<CR>
nnoremap <unique> <Leader>oh :Unite -start-insert history/command<CR>
nnoremap <unique> <Leader>ol :Unite -start-insert line<CR>
nnoremap <unique> <Leader>om :Unite -start-insert neomru/file<CR>
nnoremap <unique> <Leader>or :Unite -start-insert register<CR>
nnoremap <unique> <Leader>os :Unite -start-insert history/search<CR>
nnoremap <unique> <Leader>oy :Unite -start-insert history/yank<CR>

" Replace BufExplorer with unite
nnoremap <unique> <Leader>e :Unite buffer -no-split -no-auto-resize -no-resize<CR>

" Make selection highlight readable.
call unite#custom#profile('default', 'context', { 'cursor_line_highlight' : 'CursorLine' })
" Ensure outline uses smartcase (doesn't work. not sure if doing it wrong.).
call unite#custom#profile('outline', 'context', { 'ignorecase': 1 })
call unite#custom#profile('outline', 'context', { 'smartcase':  1 })
