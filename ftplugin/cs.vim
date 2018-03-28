" Requires vim-unityengine-docs: https://github.com/idbrii/vim-unityengine-docs
nnoremap <buffer> <Leader>ok "cyiw:Unite -start-insert -buffer-name=UnityDoc unitydoc -input=<C-r>c<CR>

" Would be better if this was the fallback behavior when no candidates are
" found. unite.vim/issues/1235
nnoremap <buffer> <Leader>oK "cyiw:Gogo https://docs.unity3d.com/ScriptReference/30_search.html?q=<C-r>c<CR>
