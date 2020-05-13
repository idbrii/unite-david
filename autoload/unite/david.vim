
function! unite#david#UniteFilesWithInput(input)
    exec 'UniteFiles -input='. a:input
endf

function! unite#david#split_on_file_selection(mapping)
    if getcurpos()[1] == 1
        return a:mapping
    endif
    return unite#do_action('split')
endf
