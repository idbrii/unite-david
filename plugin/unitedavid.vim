if v:version < 800
    " denite doesn't support vim7
    finish
endif

" g:unite_source_history_yank_enable = 1 must be set in before_vimrc.

" Make sure there's nothing behind the initial leader.
nnoremap <unique> <Leader>o <nop>

" The UniteSameNameSlow is so slow, that mru is preferable.
command! -nargs=* UniteSameName exec 'Denite -buffer-name=samename -input='. expand('%:t:r') .' file_mru <args>'
command! -nargs=* UniteSameNameSlow :exec 'UniteFiles -buffer-name=samename -input='. expand('%:t:r') .' <args>'

" In theory this would be better if it processed 'rtp', but this works well
" enough.
command! -nargs=* UniteVimfiles :cd ~/.vim | Denite -buffer-name=vimfiles file/rec <args>


nnoremap <unique> <Leader>o<Space> :Denite -resume<CR>
nnoremap <unique> <Leader>oo :UniteFiles<CR>

nnoremap <unique> <Leader>ob :Denite -buffer-name=buffer   buffer<CR>
nnoremap <unique> <Leader>oc :Denite -buffer-name=command  command<CR>
nnoremap <unique> <Leader>of :Denite -buffer-name=outline  outline<CR>
nnoremap <unique> <Leader>oh :Denite -buffer-name=command  history/command<CR>
nnoremap <unique> <Leader>ol :Denite -buffer-name=line     line<CR>
nnoremap <unique> <Leader>om :Denite -buffer-name=mrufile  file_mru<CR>
nnoremap <unique> <Leader>on :UniteSameName<CR>
nnoremap <unique> <Leader>or :Denite -buffer-name=register register<CR>
nnoremap <unique> <Leader>os :Denite -buffer-name=search   history/search<CR>
nnoremap <unique> <Leader>oy :Denite -buffer-name=yank     history/yank<CR>
nnoremap <unique> <Leader>gf :<C-u>call unite#david#UniteFilesWithInput(expand('<cfile>:t'))<CR>

" This one is filetype-dependent. Default here to vimdoc.
" Mnemonic: Open K (vim for help)
nnoremap <buffer> <Leader>ok "cyiw:Denite -buffer-name=vimdoc help -input=<C-r>c<CR>

" Replace BufExplorer with unite
nnoremap <unique> <Leader>e :Denite buffer -no-split -no-auto-resize -no-resize -buffer-name=bufexplorer<CR>

" Fancier netrw with unite. I can still use - within it to go up (and into
" netrw).
nnoremap <unique> <Leader>- :Denite -buffer-name=file     file<CR>

" Make selection highlight readable.
call unite#custom#profile('default', 'context', { 'cursor_line_highlight' : 'CursorLine' })
" Ensure outline uses smartcase (doesn't work. not sure if doing it wrong.).
call unite#custom#profile('outline', 'context', { 'ignorecase': 1 })
call unite#custom#profile('outline', 'context', { 'smartcase':  1 })

" When we fallback, make unite look like denite.
call unite#custom#profile('default', 'context', {
      \ 'direction': 'botright'
      \ })

call denite#custom#source(
            \ 'file_mru',
            \ 'matchers',
            \ ['matcher/cpsm', 'matcher/regexp'])

" Need regexp for file, file_mru, etc. Probably better for everything.
call denite#custom#source('_', 'matchers', ['matcher/regexp'])

" Make colours non-ugly
call denite#custom#option('_', 'highlight_matched_char', 'String')
call denite#custom#option('_', 'highlight_matched_range', 'Character') " CursorLine would more obvious, but only relevant with matcher/fuzzy
" Prevent you from seeing matching text in current selection in insert
" mode, but are more consistent with other vim.
call denite#custom#option('_', 'highlight_mode_normal', 'CursorLine')
call denite#custom#option('_', 'highlight_mode_insert', 'WildMenu')

" Behave more like Unite with -start-insert.
" Easier up/down. Maybe better to use normal mode.
"~ call denite#custom#map(
"~         \ 'insert',
"~         \ '<Down>',
"~         \ '<denite:move_to_next_line>',
"~         \ 'noremap'
"~         \)
"~ call denite#custom#map(
"~         \ 'insert',
"~         \ '<Up>',
"~         \ '<denite:move_to_previous_line>',
"~         \ 'noremap'
"~         \)

" Switch modes with C-l (like esc but won't quit)
call denite#custom#map(
        \ 'normal',
        \ '<C-l>',
        \ '<denite:enter_mode:insert>',
        \ 'noremap'
        \)
call denite#custom#map(
        \ 'insert',
        \ '<C-l>',
        \ '<denite:enter_mode:normal>',
        \ 'noremap'
        \)

" If I try to search from normal mode, append it to query
call denite#custom#map(
        \ 'normal',
        \ '/',
        \ '<denite:multiple_mappings:'
        \ .'denite:enter_mode:normal,'
        \ .'denite:append_to_line,'
        \ .'denite:insert_word: '
        \ .'>',
        \ 'noremap'
        \)
