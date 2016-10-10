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
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'carlitux/deoplete-ternjs'
Plug 'fatih/vim-go'
Plug 'flowtype/vim-flow', { 'do': 'npm install -g flow-bin' } 
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all && brew install highlight' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'kshenoy/vim-signature'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'milkypostman/vim-togglelist'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'neomake/neomake'
Plug 'steelsojka/deoplete-flow'
Plug 'sheerun/vim-polyglot' " add language support for everything
Plug 'SirVer/ultisnips', { 'on': [] }
augroup load_ultisnips
  " Load on demand
  " https://github.com/junegunn/vim-plug/issues/215
  autocmd!
  autocmd FileType javascript call plug#load('ultisnips')
        \| execute 'autocmd! load_ultisnips' | doautocmd FileType
augroup END
Plug 'ternjs/tern_for_vim'
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
set expandtab                         " Expand an inserted tab to spaces
set fillchars=""                      " Disable - | chars on horizontal/vertical splits
set hidden                            " Allow hidden buffers with unsaved content
set history=250                       " 250 items in history
set ignorecase                        " Ignore case for searching
set lazyredraw                        " Don't redraw when we don't have to
set list                              " Enable listing extra chars
set listchars=tab:\⋮\ ,trail:·,nbsp:_
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
set smartcase                         " Enable case sensitive if input has capital letter
set softtabstop=2                     " Convert a tab to 2 spaces
set splitbelow                        " Split horizontal windows down
set splitright                        " Split vertical windows to the right
set tabstop=2                         " Set tab 2 spaces wide
set undodir=~/.vim/undo               " For persistent undo
set undofile                          " Enable persistent undo
set updatetime=50                     " Trigger cursorhold faster
set visualbell                        " Use visual bell instead of audible bell

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
" Move current line, shift-alt-j down, shift-alt-k up. Maintain indentation
nnoremap Ô :m .+1<CR>==
nnoremap  :m .-2<CR>==
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
" Buffer nav
nnoremap “ :bprev<CR>
nnoremap ‘ :bnext<CR>
" prev active buffer: alt-\
nnoremap « <C-^><CR>
" closee buffer with ctrl-w
nnoremap <C-q> :bdel<CR>
" center on screen when jumping to next result
nnoremap n nzzzv
nnoremap N Nzzzv
" faster movement with alt pressed
nnoremap ∆ 10j
nnoremap ˚ 10k
" faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
" replace word without overwriting register
nnoremap <leader>r viw"_dP
" sort lines
vnoremap <f5> :sort i<cr>
" prev/next in quickfix
map <C-n> :cnext<cr>zz
map <C-m> :cprev<cr>zz
" jump to ( and ) on line
nnoremap ( f(
nnoremap ) f(])
" open new closure from within {}
nnoremap <C-i> ^f}i<cr><esc>O

" -------------------------------------
" Colors
" -------------------------------------

" nvim 0.1.5+ for true color
if has("termguicolors")
  set termguicolors
else
  set t_Co=256
endif
set background=dark

let g:one_allow_italics = 1 
colorscheme molokai

" -------------------------------------
" Color column
" -------------------------------------

augroup ColorColumnFiletype
	autocmd!
	" Default
	set colorcolumn=81
	" 100 col
	autocmd BufRead *.go set colorcolumn=101
	autocmd BufRead *.js set colorcolumn=101
	autocmd BufRead *.jsx set colorcolumn=101
augroup END

" -------------------------------------
" Plugin config
" -------------------------------------

" vim-airline
let g:airline_theme = "powerlineish"
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['branch', 'tabline']
let g:airline_section_y = ''
let g:airline_section_z = '%3p%%  %l/%L  %c'
let g:airline#extensions#tabline#buffer_idx_mode = 1
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
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1
let g:go_list_type = "quickfix"
hi def goSameId ctermbg=237 ctermfg=015 guifg=#BFFF00

" Autocomplete
" Neocomplete & Deoplete

" Neocomplete (vim)
if !has('nvim')
	let g:neocomplete#enable_at_startup = 1                       "  Enable on startup
	let g:neocomplete#enable_auto_select = 1                      "  Automatically select first suggestion
	set completeopt-=preview                                      "  Disable preview window
	let g:neocomplete#sources#syntax#min_keyword_length = 2       "  Set minimum syntax keyword length.
	noremap <silent> <CR> <C-r>=<SID>close_popup()<CR>
  function! s:close_popup()
    return pumvisible() ? "\<C-y>" : "\<CR>"
  endfunction
endif

" Deoplete (Neovim)
if has('nvim')
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#ignore_sources = {}
	let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
	let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
	let g:deoplete#sources#go#align_class = 1
	let g:deoplete#max_abbr_width = 160
	let g:deoplete#max_menu_width = 80
  inoremap <silent> <CR> <C-r>=<SID>close_popup()<CR>
  function! s:close_popup()
    return pumvisible() ? deoplete#mappings#close_popup() : "\n"
  endfunction
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
let g:NERDTreeQuitOnOpen = 1

" FZF
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_buffers_jump = 1
let g:fzf_files_options = '--preview "(highlight --style=molokai -O xterm256 {} || coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-o': 'edit' }
nnoremap <C-p> :Files<CR>
nnoremap π :Buffers<CR>
nnoremap <leader>a :Ag 

" vim-ultisnips
let g:UltiSnipsEditSplit = 'vertical' " open snippet editor in vertical window

" YankRing.vim
" Remap to not conflict with ctrl-p
let g:yankring_replace_n_pkey = '[p'
let g:yankring_replace_n_nkey = ']p'
" Show history with rolling to p
noremap ][p :YRShow<CR>

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" vim-startify
" stay in dir where vim was openened
let g:startify_change_to_dir = 0
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
let g:startify_bookmarks = [
    \ { 'c': '~/.vimrc' },
    \ { 'z': '~/.zshrc' }
    \ ]
noremap <leader><leader>s :Startify<cr>

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

" deoplete-ternjs
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0

" vim-flow
let g:flow#autoclose = 1
let g:flow#omnifunc = 1

" undotree
nmap <leader>u :UndotreeToggle<CR>

" vim-togglelist
nnoremap <C-b> :call ToggleQuickfixList()<cr>

" neomake

let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_jsx_enabled_makers = ['eslint_d']
let g:neomake_verbose = 0
let g:neomake_warning_sign = {
  \ 'text': '!',
  \ 'texthl': 'GitGutterChangeDefault',
  \ }
let g:neomake_error_sign = {
  \ 'text': '⨯',
  \ 'texthl': 'GitGutterDeleteDefault',
  \ }

autocmd! VimEnter * if exists(":Neomake") | autocmd! BufWritePost,BufEnter * Neomake

" Fix colors for Neomake
hi NeomakeWarningSign ctermfg=yellow guifg=yellow
hi NeomakeErrorSign ctermfg=red guifg=red
autocmd ColorScheme * hi NeomakeWarningSign ctermfg=yellow guifg=yellow guibg=none ctermbg=none
autocmd ColorScheme * hi NeomakeErrorSign ctermfg=red guifg=red guibg=none ctermbg=none

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

" Git commit
augroup GitCommit
  autocmd!
  " enable spellcheck, allow to start with lowercase
  autocmd FileType gitcommit setlocal spell spellcapcheck=
augroup END

" Markdown
augroup Markdown
  autocmd!
  " enable spellcheck
  autocmd FileType markdown setlocal spell
augroup END

" JavaScript
augroup Javascript
  autocmd!
  " remove trailing spaces on save
  autocmd FileType javascript autocmd BufWritePre <buffer> %s/\s\+$//e
	autocmd FileType javascript nmap <Leader>i :FlowType<cr>
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
