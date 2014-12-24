
" Use Ctrl-L to exit insert mode.
inoremap <buffer> <expr> <C-l> pumvisible() ? '<C-l>' : '<Esc>'
" Use Ctrl-L to clear highlighting and refresh unite's cache (only mapped by
" unite in insert mode).
nmap <buffer> <silent> <C-l> <Plug>(unite_redraw)<Plug>(david-redraw-screen)

" Unlike d, D doesn't wait after input.
nnoremap <silent><buffer><expr> D
        \ unite#smart_map('d', unite#do_action('delete'))

