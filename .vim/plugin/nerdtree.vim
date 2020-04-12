let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
" let g:NERDTreeMinimalMenu = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeShowHidden = 1

nnoremap <silent> <c-n> :call NERDTreeToggleWithRefresh()<CR>
nnoremap <silent> <leader><c-n> :call NERDTreeFindWithRefresh()<CR>

func! NERDTreeToggleWithRefresh()
    :NERDTreeToggle
    if (exists("b:NERDTreeType") == 1)
        call feedkeys("R")
    endif
endfunction
func! NERDTreeFindWithRefresh()
    :NERDTreeFind
    if (exists("b:NERDTreeType") == 1)
        call feedkeys("R")
    endif
endfunction
