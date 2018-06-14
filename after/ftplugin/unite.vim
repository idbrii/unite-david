
" Use Ctrl-L to exit insert mode.
inoremap <buffer> <expr> <C-l> pumvisible() ? '<C-l>' : '<Esc>'
" Use Ctrl-L to clear highlighting and refresh unite's cache (only mapped by
" unite in insert mode).
nmap <buffer> <silent> <C-l> <Plug>(unite_redraw)<Plug>(david-redraw-screen)

" Unlike d, D doesn't wait after input.
function! s:unite_delete()
    " First line is for editing, so work like normal vim.
    if getcurpos()[1] == 1
        return 'D'
    else
        " Other lines are files. Might be in file exploring mode and want to
        " delete. (If not, we'll get an error.)
        return unite#smart_map('d', unite#do_action('delete'))
    endif
endf
nnoremap <silent><buffer><expr> D <SID>unite_delete()

" Easy split that's not already in use. (Saving and completing braces doesn't
" make sense in unite.)
inoremap <silent><buffer><expr> <C-s> unite#do_action('split')

" Allow me to move back. I never use bookmarking so push it to capitalized.
nunmap <buffer> b
nnoremap <buffer><silent><expr><nowait> B unite#smart_map('b', unite#do_action('bookmark'))
