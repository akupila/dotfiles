" vim:foldmethod=marker foldlevel=0

" VIM compatibility {{{

	if !has('nvim')
		" Fix stuff in vim, no need to do this for neovim
		set nocompatible " Disable vi compatibility
		filetype off " turn filetype detection off..
		filetype plugin indent on " .. and on again, enabling filetype and indent plugins
		scriptencoding utf-8 " Fix interpreting .vimrc on remote sessions
		set autoindent " Copy indent from last line when starting new line
		set autoread " Automatically read files changed on disk
		set backspace=indent,eol,start " Allow backspace in insert mode
		set encoding=utf-8 " Set character encoding for buffers etc
		set hlsearch " Highlight search matches
		set incsearch " Highlight search matches as typed
		set laststatus=2 " Always show statusbar
		set t_Co=256 " 256 colors
		set ttyfast " Send more characters at a time
		set mouse=a " Enable mouse in all modes
		syntax enable " Enable syntax highlighting
	endif

" }}}

" General {{{
  set clipboard=unnamed " Share clipboard with OS X
	set number " Show line numbers on active line
	set relativenumber " Show relative line numbers
	set splitright " Split vertical windows to the right
	set splitbelow " Split horizontal windows down
	set fillchars="" "  Disable - | chars on horizontal/vertical splits
	set noerrorbells " No beeping
	set hidden " When a buffer is brought to foreground, remember undo history and marks
	set history=250 " 250 items in history
	set noswapfile " No swaps
	set nobackup " No annoying backups
	" set noshowmode " Don't show mode, airline shows it
	set ignorecase " Ignore case for searching
	set visualbell " Use visual bell instead of audible bell
	set pumheight=10 " Max 10 items in popup/autocomplete menu
	set lazyredraw " Don't redraw when we don't have to
	set list " Enable listing extra chars
	set listchars=tab:\ \ ,trail:·,nbsp:_
	set shortmess+=I " Hide intro message
	set scrolloff=3 " Offset top/bottom when scrolling
" }}}

" Folding {{{
set foldmethod=syntax " Syntax are used to specify folds
set foldlevelstart=20 " No folding when opening files
" }}}

" Indentation {{{
set shiftwidth=2 " Shift indentation 2 spaces
set smarttab " At beginning of line Tab inserts shiftwidth spaces
set softtabstop=2 " Convert a tab to 2 spaces
set tabstop=2 " Set tab 2 spaces wide
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
	nnoremap <leader><space> :noh<Enter>
	" }}}

	" Move directly to col above/below, even if line is wrapping {{{
	nnoremap j gj
	nnoremap k gk
	nnoremap <Down> gj
	nnoremap <Up> gk
	" }}}

	" Print full path {{{
	map <C-f> :echo expand("%:p")<cr>
	" }}}

	" Fast scroll {{{
	nnoremap <C-e> 10<C-e>
	nnoremap <C-y> 10<C-y>
	" }}}
	
	" Toggle folds (<Space>) {{{
	nnoremap <Space> za
	vnoremap <Space> za
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
call plug#end()
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
