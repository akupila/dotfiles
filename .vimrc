syntax on

" General

" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start

" Enable relative line numbers, absolute on current line (req vim 7.4)
set relativenumber 
set number
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
" Set desert colorscheme
:colorscheme desert
" Set line numbers gray
:highlight LineNr ctermfg=darkgrey 
:highlight CursorLineNR ctermfg=white

" Move current line up/down. n: down, m: up
nmap n :m +1<CR>
nmap m :m -2<CR>

" Set up Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on