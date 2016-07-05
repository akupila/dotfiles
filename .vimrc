" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'kshenoy/vim-signature'
Plugin 'scrooloose/nerdcommenter'
call vundle#end()

syntax on
filetype plugin indent on

" General

" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start

" Enable relative line numbers, absolute on current line (req vim 7.4)
set relativenumber 
set number
" Enable lazy redraw (otherwise relativenumber is super slow)
set lazyredraw
" Enable syntax highlighting
syntax on
" Make tabs as wide as two spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Scroll offset 3 lines
set scrolloff=3
" Disable vim backups
set nobackup
" Disable swap files
set noswapfile
" Disable startup screen
set shortmess+=I
" Disable bell
set visualbell t_vb=
" Allow visual selection past end of lines
set virtualedit=block
" Highlight all search matches
set hlsearch
" Find as you type
set incsearch
" Set smart case for search, use case-sensitive if any caps are used
set smartcase
" Disable automatic comment continuation
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Show current file in title
autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
" in osx make clipboard work with system clipboard
set clipboard=unnamed
set autoread
" Disable netrw
let g:netrw_dirhistmax = 0
" Set desert colorscheme
colorscheme molokai

" Center screen after jump
nnoremap n nzz
nnoremap N Nzz
nnoremap } }zz
nnoremap { {zz
" Insert linebreak in normal mode. Ctrl-j: add above, ctrl-k: add under
" Sets a temp mark to keep the cursor position
nnoremap <C-k> mqo<Esc>'qdmq
nnoremap <C-j> mqO<Esc>'qdmq
" Move current line up/down. alt-j: down, alt-k: up
" To get the key-code: `sed -n l` and enter the desired key (to fix alt on mac)
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
" Map semicolon to colon
map ; :
" Double press semicolon to get a regular semicolon
noremap ;; ;
imap jk <Esc>


" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
" disable preview window
set completeopt-=preview
" set smartcase for autocomplete
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " fix adding linebreak on enter
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" GO
" Highlight
let g:go_highlight_functions = 1  
let g:go_highlight_methods = 1  
let g:go_highlight_structs = 1  
let g:go_highlight_operators = 1  
let g:go_highlight_build_constraints = 1  

" Run goimports in save
let g:go_fmt_command = "goimports"
" Ignore vendor dir for ctrl-p
let g:ctrlp_custom_ignore = 'vendor'

" NERDTree
" Toggle NERDTree with ctrl-n
map <C-n> :NERDTreeToggle<CR>
" Close vim if only view open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
