
" g:unite_source_history_yank_enable = 1 must be set in before_vimrc.

" Make sure there's nothing behind the initial leader.
nnoremap <unique> <Leader>o <nop>

" The UniteSameNameSlow is so slow, that mru is preferable.
command! UniteSameName exec 'Unite -start-insert -buffer-name=samename -input='. expand('%:t:r') .' neomru/file'

" If we have vimproc, use that instead of the python script.
if exists("g:loaded_vimproc") && g:loaded_vimproc > 0
    let g:unite_source_rec_async_command = 'python '. expand("<sfile>:h:h") ."/bin/uniteprintfilelist.py"
    call unite#custom#source('file_rec/async', 'required_pattern_length', 3)
    command! -nargs=* UniteFiles    Unite -start-insert -buffer-name=files file_rec/async <args>

else
    " Unite doesn't like drive letters.
    let g:unite_script = expand("<sfile>:h:h") ."/bin/uniteopenfilelist.py"
    if has("win32")
        " Try to use my drive links
        let g:unite_script = '/'. unite_script[0] .'/'. unite_script[2:]

        if !filereadable(g:unite_script)
            " Fall back to no drive letter (might assume wrong drive on multi drive systems).
            let g:unite_script = unite_script[2:]
        endif
    endif
    execute "command! UniteFiles    Unite -start-insert -buffer-name=files script:python:". unite_script
    execute "command! UniteSameNameSlow exec 'Unite -start-insert -buffer-name=samename -input='. expand('%:t:r') .' script:python:". unite_script ."'"
    unlet g:unite_script

endif

" If we have unite, use the fancy snippet completer.
" Otherwise we'll fall back to the ugly uninteractive default one.
if exists("g:did_plugin_ultisnips") && g:did_plugin_ultisnips > 0
    " Copied from UltiSnips help.
    function! UltiSnipsCallUnite()
        Unite -start-insert -winheight=100 -immediately -no-empty ultisnips
        return ''
    endfunction
    inoremap <silent> <C-r><C-j> <C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
endif

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
