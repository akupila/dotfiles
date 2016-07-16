" vim:foldmethod=marker foldlevel=0

" VIM compatibility {{{

	if !has('nvim')
		" Fix stuff in vim, no need to do this for neovim
		set nocompatible               " Disable vi compatibility
		filetype off                   " turn filetype detection off..
		filetype plugin indent on      " .. and on again, enabling filetype and indent plugins
		scriptencoding utf-8           " Fix interpreting .vimrc on remote sessions
		set autoindent                 " Copy indent from last line when starting new line
		set autoread                   " Automatically read files changed on disk
		set backspace=indent,eol,start " Allow backspace in insert mode
		set encoding=utf-8             " Set character encoding for buffers etc
		set hlsearch                   " Highlight search matches
		set incsearch                  " Highlight search matches as typed
		set laststatus=2               " Always show statusbar
		set t_Co=256                   " 256 colors
		set ttyfast                    " Send more characters at a time
		set mouse=a                    " Enable mouse in all modes
		syntax enable                  " Enable syntax highlighting
	endif

" }}}

" General {{{
	set fillchars=""                      " Disable - | chars on horizontal/vertical splits
	set hidden                            " When a buffer is brought to foreground, remember undo history and marks
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
	set pumheight=10                      " Max 10 items in popup/autocomplete menu
	set relativenumber                    " Show relative line numbers
	set scrolloff=3                       " Offset top/bottom when scrolling
	set shortmess+=I                      " Hide intro message
	set splitbelow                        " Split horizontal windows down
	set splitright                        " Split vertical windows to the right
	set updatetime=50                     " Trigger cursorhold faster for vim-go showing what a func accepts
	set visualbell                        " Use visual bell instead of audible bell
  set clipboard=unnamed                 " Share clipboard with OS X
" }}}

" Folding {{{
set foldlevelstart=20 " No folding when opening files
" set foldmethod=syntax " Syntax are used to specify folds
" }}}

" Indentation {{{
set shiftwidth=2  " Shift indentation 2 spaces
set smarttab      " At beginning of line Tab inserts shiftwidth spaces
set softtabstop=2 " Convert a tab to 2 spaces
set tabstop=2     " Set tab 2 spaces wide
" }}}

" Key remaps {{{
	" Basic {{{
	" , as leader
	let mapleader=","
	" jk instead of esc, maintain cursor poisition
	imap jk <Esc>l
	" ; instead of :
	map ; :
	" Type a ; with ;;
	noremap ;; ;
	" }}}

	" Yank to end of line {{{
	nnoremap Y y$
	" }}}

	" Move current line {{{
	" down with ctrl-j, up with ctrl-k, maintain indentiation
	nnoremap <C-j> :m .+1<CR>==
	nnoremap <C-k> :m .-2<CR>==
	" }}}

	" Search current word for replace with confirm {{{
	nnoremap <Leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
	" }}}

	" Move between windows {{{
	map <C-j> <C-W>j
	map <C-k> <C-W>k
	map <C-h> <C-W>h
	map <C-l> <C-W>l
	" }}}

	" Vertical resize windows with + - {{{
	nnoremap <silent> + :exe "vertical resize"  . (winwidth(0) * 4/3)<CR>
	nnoremap <silent> _ :exe "vertical resize"  . (winwidth(0) * 3/4)<CR>
	" }}}

	" Fast save {{{
	nnoremap <leader>w :w!<Enter>
	" }}}

	" Remove search Highlight {{{
	nnoremap <leader><space> :set invhlsearch<Enter>
	" }}}

	" Move directly to col above/below, even if line is wrapping {{{
	nnoremap j gj
	nnoremap k gk
	nnoremap <Down> gj
	nnoremap <Up> gk
	" }}}

	" Map <Leader>ff to display all lines with keyword under cursor
	" and ask which one to jump to
	nmap <Leader>ff [I:let nr = input("Jump to: ")<Bar>exe "normal " . nr ."[\t"<CR>

	" Visual shift {{{
	" Move blocks without leaving visual mode
	vnoremap < <gv
	vnoremap > >gv
  " }}}

	" Print full path {{{
	map <C-f> :echo expand("%:p")<cr>
	" }}}

	" Fast scroll {{{
	nnoremap <C-e> 10<C-e>
	nnoremap <C-y> 10<C-y>
	" }}}
	
	" Folding {{{
	" Toggle fold with space
	nnoremap <Space> za
	vnoremap <Space> za
	" Set fold level
	nmap <leader>f0 :set foldlevel=0<CR>
	nmap <leader>f1 :set foldlevel=1<CR>
	nmap <leader>f2 :set foldlevel=2<CR>
	nmap <leader>f3 :set foldlevel=3<CR>
	nmap <leader>f4 :set foldlevel=4<CR>
	nmap <leader>f5 :set foldlevel=5<CR>
	nmap <leader>f6 :set foldlevel=6<CR>
	nmap <leader>f7 :set foldlevel=7<CR>
	nmap <leader>f8 :set foldlevel=8<CR>
	nmap <leader>f9 :set foldlevel=9<CR>
  " }}}

	" Stay on current match with * {{{
	nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
	" }}}
" }}}

" Colors {{{
set background=dark
colorscheme molokai
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
if !has('nvim')
  Plug 'Shougo/neocomplete.vim'
else 
  Plug 'Shougo/deoplete.nvim'
	Plug 'zchee/deoplete-go', { 'do': 'make'}
endif
call plug#end()
" }}}

" Plugin config {{{
	" vim-airline {{{
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
	" }}}
	
	" vim-go {{{
		" Config {{{
		let g:go_highlight_functions = 1
		let g:go_highlight_methods = 1
		let g:go_highlight_structs = 1
		let g:go_highlight_operators = 1
		let g:go_highlight_build_constraints = 1
		let g:go_fmt_command = "goimports"
		let g:go_auto_type_info = 1
		" }}}
		" Keyboard shortcuts {{{
		au FileType go nmap <Leader>x <Plug>(go-def-split)
		au FileType go nmap <Leader>v <Plug>(go-def-vertical)

		au FileType go nmap <Leader>i <Plug>(go-info)
		au FileType go nmap <Leader>l <Plug>(go-metalinter)

		au FileType go nmap <leader>r  <Plug>(go-run)

		au FileType go nmap <leader>b  <Plug>(go-build)
		au FileType go nmap <leader>t  <Plug>(go-test)
		au FileType go nmap <Leader>d <Plug>(go-doc)
		au FileType go nmap <Leader>c <Plug>(go-coverage)
		" }}}
	" }}}
	
  " Neocomplete (VIM) {{{
	if !has('nvim')
	let g:neocomplete#enable_at_startup = 1                       "  Enable on startup
	let g:neocomplete#enable_auto_select = 1                      "  Automatically select first suggestion
	set completeopt-=preview                                      "  Disable preview window
	let g:neocomplete#sources#syntax#min_keyword_length = 2       "  Set minimum syntax keyword length.
	" <Enter>: close popup and save indent.
	inoremap <silent> <Enter> <C-r>=<SID>close_popup()<Enter>
	" fix adding linebreak on enter
	function! s:close_popup()
		return pumvisible() ? "\<C-y>" : "\<CR>"
	endfunction
	endif
	" }}}
	
	" Deoplete (Neovim) {{{
	" Config {{{
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#ignore_sources = {}
	let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
	let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
	let g:deoplete#sources#go#align_class = 1
	set completeopt-=preview
	" }}}
	" Keyboard shortcuts {{{
	inoremap <silent> <Enter> <C-r>=<SID>close_popup()<Enter>
	function! s:close_popup()
		return pumvisible() ? "\<C-y>" : "\<CR>"
	endfunction
	" }}}


	" }}}

	" vim-fugitive {{{
	vnoremap <leader>gb :Gblame<CR>
	nnoremap <leader>gb :Gblame<CR>
	" }}}
	
	" nerdcommenter {{{
	let g:NERDSpaceDelims = 1 " Add spaces after comments
	" }}}
" }}}

" Cursorline in insert mode {{{
augroup CursorlineInsert
  autocmd!
  au InsertEnter * set cursorline
  au InsertLeave * set nocursorline
augroup END
" }}}

" FastEscape {{{
" Speed up transition from modes
set notimeout
set ttimeout
set ttimeoutlen=10
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END
" }}}

" Misc {{{
augroup AutoRefresh
	autocmd!
	autocmd bufwritepost .vimrc source $MYVIMRC
augroup END
" }}}

" Open help vertically {{{
augroup VerticalHelp
	autocmd!
	command! -nargs=* -complete=help Help vertical belowright help <args>
	autocmd FileType help wincmd L
augroup END
" }}}
