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
call vundle#end()

syntax on

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
" Disable netrw
let g:netrw_dirhistmax = 0
" Set desert colorscheme
colorscheme molokai

" Move current line up/down. n: down, m: up
nmap n :m +1<CR>
nmap m :m -2<CR>
" Map semicolon to colon
map ; :
" Double press semicolon to get a regular semicolon
noremap ;; ;
imap jk <Esc>

filetype plugin indent on

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1

" Highlight
let g:go_highlight_functions = 1  
let g:go_highlight_methods = 1  
let g:go_highlight_structs = 1  
let g:go_highlight_operators = 1  
let g:go_highlight_build_constraints = 1  
