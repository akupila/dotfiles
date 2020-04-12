" Configure vim-go
let g:go_fmt_fail_silently = 1
let g:go_echo_command_info = 0

let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

let g:go_doc_popup_window = 1

let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1

let g:go_rename_command = 'gopls'
let g:go_metalinter_command = 'gopls'
let g:go_gopls_staticcheck = 1

au FileType go nnoremap <buffer> Q :GoAlternate<CR>
au FileType go nnoremap <buffer> <leader>t :GoCoverageToggle<CR>
au FileType go nnoremap <buffer> <leader>T :GoCoverageBrowser<CR>
au FileType go nnoremap <buffer> <leader>r :GoRename<CR>
au FileType go nnoremap <buffer> <leader>i :GoInfo<CR>
au FileType go nnoremap <buffer> <leader>e :GoIfErr<CR>

" Enable spellcheck, allow to start with lowercase
setlocal spell spellcapcheck=
