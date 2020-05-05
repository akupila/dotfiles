call deoplete#custom#var('omni', 'input_patterns', {
       \ 'go': '[^. *\t]\.\w*',
       \ })
call deoplete#custom#option({
      \ 'auto_complete_delay' :  50,
      \ 'ignore_case'         :  1,
      \ 'smart_case'          :  1,
      \ 'camel_case'          :  1,
      \ 'refresh_always'      :  1,
      \ })
let g:deoplete#enable_at_startup = 1
