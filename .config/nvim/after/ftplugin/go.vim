" Configure vim-go
let g:go_fmt_fail_silently = 1
let g:go_echo_command_info = 0
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_debug_windows = {
    \ 'stack': 'leftabove 40vnew',
    \ 'out':   'botright 30new',
    \ 'vars':  'leftabove 80vnew',
    \ }

autocmd FileType go nmap <buffer> Q :GoAlternate!<CR>
autocmd FileType go nmap <buffer> <silent> <Leader>t :GoCoverageToggle -short<CR>
autocmd FileType go nmap <buffer> <Leader>T <Plug>(go-coverage-browser)
autocmd FileType go nmap <buffer> <Leader>r <Plug>(go-rename)
autocmd FileType go nmap <buffer> <Leader>i <Plug>(go-info)
autocmd FileType go nmap <buffer> <Leader>e <Plug>(go-iferr)

" Enable spellcheck, allow to start with lowercase
setlocal spell spellcapcheck=
