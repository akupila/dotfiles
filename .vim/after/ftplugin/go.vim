nnoremap <silent> <buffer> <Leader>r :GOVIMRename<CR>
nnoremap <silent> <buffer> K         :<C-u>call GOVIMHover()<CR>
nnoremap <silent> <buffer> <leader>K :GOVIMSuggestedFixes<CR>

setlocal noexpandtab
setlocal tabstop=4

setlocal foldenable
setlocal foldmethod=syntax
setlocal foldlevel=99

setlocal colorcolumn=120
setlocal spell spellcapcheck=

iabbrev 1= !=
iabbrev ;= :=

call deoplete#custom#option('omni_patterns', {
\ 'go': '[^. *\t]\.\w*',
\})

autocmd! CursorHoldI <buffer> :GOVIMExperimentalSignatureHelp
