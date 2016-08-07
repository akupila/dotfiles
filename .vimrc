" -------------------------------------
" Fix Vim stuff
" -------------------------------------

if !has('nvim')
	set nocompatible               " Disable vi compatibility
	filetype off                   " turn filetype detection off..
	filetype plugin indent on      " .. and on again, enabling filetype and indent plugins
	scriptencoding utf-8           " Fix interpreting .vimrc
	set autoindent                 " Copy indent from last line when starting new line
	set autoread                   " Automatically read files changed on disk
	set backspace=indent,eol,start " Allow backspace in insert mode
	set encoding=utf-8             " Set character encoding for buffers etc
	set hlsearch                   " Highlight search matches
	set incsearch                  " Highlight search matches as typed
	set laststatus=2               " Always show statusbar
	set mouse=a                    " Enable mouse in all modes
	set smarttab " At beginning of line Tab inserts shiftwidth spaces
	set ttyfast                    " Send more characters at a time
	syntax enable                  " Enable syntax highlighting
endif

" -------------------------------------
" Plugins
" -------------------------------------

call plug#begin('~/.config/nvim/plugged')
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'justinmk/vim-sneak'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'tomasr/molokai'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/YankRing.vim'
Plug 'wellle/targets.vim'
if !has('nvim')
	Plug 'Shougo/neocomplete.vim'
else 
	Plug 'Shougo/deoplete.nvim'
	Plug 'zchee/deoplete-go', { 'do': 'make'}
endif
call plug#end()

" -------------------------------------
" Config
" -------------------------------------

set clipboard=unnamed                 " Share clipboard with OS X
set complete=.,w,b,u                  " Complete from current file, split window, buffers, unloaded buffers
set completeopt+=noinsert             " Automatically select first autocomplete option
set fillchars=""                      " Disable - | chars on horizontal/vertical splits
set hidden                            " Allow hidden buffers with unsaved content
set history=250                       " 250 items in history
set ignorecase                        " Ignore case for searching
set lazyredraw                        " Don't redraw when we don't have to
set list                              " Enable listing extra chars
set listchars=tab:\ \ ,trail:·,nbsp:_
set nobackup                          " No annoying backups
set noerrorbells                      " No beeping
set noshowmode                        " Don't show mode, airline shows it
set noswapfile                        " No swaps
set number                            " Show line numbers on active line
set numberwidth=6                     " Wider line numbers
set pumheight=10                      " Max 10 items in popup/autocomplete menu
set relativenumber                    " Show relative line numbers
set scrolloff=5                       " Offset top/bottom when scrolling
set shiftwidth=2                      " Shift indentation 2 spaces
set shortmess+=I                      " Hide intro message
set softtabstop=2                     " Convert a tab to 2 spaces
set splitbelow                        " Split horizontal windows down
set splitright                        " Split vertical windows to the right
set tabstop=2                         " Set tab 2 spaces wide
set updatetime=50                     " Trigger cursorhold faster
set visualbell                        " Use visual bell instead of audible bell
set colorcolumn=81                    " Colorize characters over 80 chars wide

" -------------------------------------
" Key remaps
" -------------------------------------

" , as leader
let mapleader=","
" jk to exit insert mode
imap jk <Esc>
" ; instead of :
noremap ; :
" Yank to end of line
nnoremap Y y$
" Move to line above/below even if line is wrapping
nnoremap j gj
nnoremap k gk
" Move current line, alt-j down, alt-k up. Maintain indentation
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
" Search word under cursor for replace with confirm
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
" Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Resize vertical windows with + -
nnoremap <silent> + :exe "vertical resize"  . (winwidth(0) * 4/3)<CR>
nnoremap <silent> _ :exe "vertical resize"  . (winwidth(0) * 3/4)<CR>
" Fast save
nnoremap <leader>w :w!<CR>
" Remove search highlight, show with double leader
nnoremap <leader><space> :noh<CR>
nnoremap <leader><leader><space> :set hlsearch<CR>
" Move blocks in visual mode
vnoremap < <gv
vnoremap > >gv
" Highlight search but don't move with *
nnoremap <silent> * :let stay_star_view = winsaveview()<CR>*:call winrestview(stay_star_view)<CR>
" Map H and L to beginning and end of line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
" Reload .vimrc config
nnoremap <leader>cr :so $MYVIMRC<CR>
" Buffer navigation
" ,,b show buffers
map <leader><leader>b :buffers<CR>:buffer<Space>
" next buffer
map bn :bnext<CR>
" prev buffer
map bp :bprev<CR>
" close buffer
map bq :bdelete<CR>

" -------------------------------------
" Colors
" -------------------------------------

set t_Co=256
set background=dark
colorscheme molokai

" Customize molokai
" https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg

function! s:TweakColors()
	" Line numbers gray, active white
	highlight LineNr ctermfg=238 ctermbg=0
	highlight CursorLineNR ctermfg=015 ctermbg=0
	" Light blue selection bg, black text
	highlight Visual ctermfg=0 ctermbg=51
	" Black cursorline
	highlight CursorLine ctermbg=232
	" Less intrusive matching parens
	highlight MatchParen ctermbg=0 ctermfg=196
	" Pink trailing spaces
	highlight TrailingWhitespace ctermfg=200 ctermbg=233
	match TrailingWhitespace /\s\+$/
	" Greenish bg on sneak hits
	highlight SneakPluginTarget ctermfg=black ctermbg=51
	" Lighter column marker
	highlight ColorColumn ctermbg=NONE ctermfg=196
endfunction

augroup UpdateColors
	autocmd!
	" Update colors after colorscheme change to fix broken colors
	" after vim-go coverage
	autocmd ColorScheme * call s:TweakColors()
	
	" Set colors first time too
	call s:TweakColors()
augroup END

" Color column bg in insert mode
" Highlight character only (not bg) for long lines
augroup colorcolumn_bg
	autocmd!
  autocmd InsertEnter * highlight ColorColumn ctermbg=234 ctermfg=NONE
  autocmd InsertLeave * highlight ColorColumn ctermbg=NONE ctermfg=196
augroup END

" -------------------------------------
" Plugin config
" -------------------------------------

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "powerlineish"
let g:airline_extensions = ['branch', 'ctrlp', 'tabline']
let g:airline_section_y = ''
let g:airline_section_z = '%3p%%  %l/%L  %c'
let g:airline#extensions#tabline#tab_nr_type = 1
nmap <leader>1 <Plug>AirlineSelectTab1                        "  Jump to tab n
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_auto_sameids = 1
hi def goSameId ctermbg=237 ctermfg=015

" Autocomplete
" Neocomplete & Deoplete
function! s:close_popup()
	return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" Neocomplete (vim)
if !has('nvim')
	let g:neocomplete#enable_at_startup = 1                       "  Enable on startup
	let g:neocomplete#enable_auto_select = 1                      "  Automatically select first suggestion
	set completeopt-=preview                                      "  Disable preview window
	let g:neocomplete#sources#syntax#min_keyword_length = 2       "  Set minimum syntax keyword length.
	" <Enter>: close popup and save indent.
	inoremap <silent> <Enter> <C-r>=<SID>close_popup()<Enter>
	" fix adding linebreak on enter
endif

" Deoplete (Neovim)
if has('nvim')
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#ignore_sources = {}
	let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
	let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
	let g:deoplete#sources#go#align_class = 1
	set completeopt-=preview
endif

" vim-fugitive
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>

" nerdtree
nnoremap <silent> § :NERDTreeToggle<CR>
nnoremap <silent> <leader>§ :NERDTreeFind<CR>	

" ctrlp
let g:ctrlp_custom_ignore = 'vendor'

" vim-ultisnips
let g:UltiSnipsEditSplit = 'vertical' " open snippet editor in vertical window

" ack.vim
" use silversearcher if available
if executable('ag')
	let g:ackprg = 'ag --ignore vendor/ --vimgrep'
endif
nnoremap <leader>a :Ack!<Space>

" YankRing.vim
" Remap to not conflict with ctrl-p
let g:yankring_replace_n_pkey = '[p'
let g:yankring_replace_n_nkey = ']p'
" Show history with rolling to p
noremap ][p :YRShow<CR>

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" vim-startify
" don't need to look at a cow
let g:startify_custom_header = ['    ϟ']
let g:startify_list_order = [
    \ ['   dir:'],
    \ 'dir',
    \ ['   recent:'],
    \ 'files',
    \ ['   sessions:'],
    \ 'sessions',
    \ ['   bookmarks:'],
    \ 'bookmarks',
    \ ]

" vim-sneak
" use sneak instead of fF / tT
let g:sneak#s_next = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" -------------------------------------
" Filetypes
" -------------------------------------

" Go
augroup Go
  autocmd!
	autocmd FileType go nmap <Leader>x <Plug>(go-def-split)
	autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
	autocmd FileType go nmap <Leader>i <Plug>(go-info)
	autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
	autocmd FileType go nmap <leader>b :GoBuild!<CR>
	autocmd FileType go nmap <leader>t :GoTest!<CR>
	autocmd FileType go nmap <Leader>d <Plug>(go-doc)
	autocmd FileType go nmap <Leader>ct :GoCoverageToggle<CR>
	autocmd FileType go nmap Q :GoAlternate!<CR>
	autocmd FileType go nmap <Leader>p :GoDecls<CR>
augroup END

" -------------------------------------
" Misc
" -------------------------------------

" Fast escape
set notimeout
set ttimeout
set ttimeoutlen=10
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END

" Don't move backwards with ESC
augroup NoMoveEsc
	autocmd!
	autocmd InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])
augroup END

" Cursorline in normal more
augroup CursorlineInsert
  autocmd!
	set cursorline " default on
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END

" Open help in vertical split
augroup VerticalHelp
	autocmd!
	command! -nargs=* -complete=help Help vertical belowright help <args>
	autocmd FileType help wincmd L
augroup END
