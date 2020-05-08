let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_focus = {"at" : "start"}
let g:ctrlsf_auto_close = {"normal": 1, "compact": 1}

nmap <C-f> <Plug>CtrlSFPrompt
nmap <leader><C-f> <Plug>CtrlSFCwordPath
vmap <C-f> <Plug>CtrlSFVwordExec
