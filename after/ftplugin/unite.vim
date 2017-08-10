
" Use Ctrl-L to exit insert mode.
inoremap <buffer> <expr> <C-l> pumvisible() ? '<C-l>' : '<Esc>'
" Use Ctrl-L to clear highlighting and refresh unite's cache (only mapped by
" unite in insert mode).
nmap <buffer> <silent> <C-l> <Plug>(unite_redraw)<Plug>(david-redraw-screen)

" Unlike d, D doesn't wait after input.
function! s:unite_delete()
    " First line is for editing, so work like normal.
    if getcurpos()[1] == 1
        return 'D'
    else
        " Other lines are files. Might be in file exploring mode and want to
        " delete. (If not, we'll get an error.)
        return unite#smart_map('d', unite#do_action('delete'))
    endif
endf
nnoremap <silent><buffer><expr> D <SID>unite_delete()

