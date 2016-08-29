" Code that depends on other plugins existing.

if exists('g:david_project_filelist')
    " Best solution is file_list if we know where it is.
    command! -nargs=* UniteFiles :exec 'Unite -start-insert file_list:'. escape(g:david_project_filelist, ':') . ' <args>'
    " This version of UniteFiles is fast.
    command! UniteSameName UniteSameNameSlow

elseif exists("g:loaded_vimproc") && g:loaded_vimproc > 0
    " If we have vimproc, we can use the python script to find the filelist.
    " This is actually really slow.
    let g:unite_source_rec_async_command = ['python', expand('<sfile>:h:h') .'/bin/uniteprintfilelist.py']
    call unite#custom#source('file_rec/async', 'required_pattern_length', 3)
    command! -nargs=* UniteFiles :Unite -start-insert -buffer-name=files file_rec/async <args>

else
    " If we don't have vimproc, we can use the script source to use a python
    " script to find the filelist. This is really slow.

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
    execute "command! -nargs=* UniteFiles    Unite -start-insert -buffer-name=files script:python:". unite_script ." <args>"
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

