" General {{{
"
set nocompatible

set completeopt-=preview
set encoding=utf-8
set hidden
set history=1000
set hlsearch
set ignorecase
set laststatus=2
set lazyredraw
set list
set listchars=tab:›·,trail:·,nbsp:⎵
set nobackup
set nomore
set noshowmode
set noswapfile
set number
set numberwidth=4
set relativenumber
set scrolloff=3
set shortmess=aIc
set signcolumn=yes
set smartcase                          
set smarttab
set ttyfast
set undodir=expand(~/.local/share/vim/undo)
set undofile
set updatetime=250
set wildmenu

" }}}
" Clipboard {{{

if has("mac")
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" }}}
" Key remaps {{{

" Use , as leader
let maploader = ","
let g:mapleader = ","

" Exit insert and command mode with jk
" This is not set up for visual mode as otherwise it'll delay moving
" down when selecting text which is really annoying
inoremap jk <Esc>
cnoremap jk <C-c>

" ; instead of : to enter command mode
noremap ; :

" Yank to end of line
nnoremap Y y$

" Move to line above/below even if line is wrapping
nnoremap j gj
nnoremap k gk

" H and L move to beginning / end of line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" Reload vimrc
nnoremap <leader>cr :source $MYVIMRC<CR>

" Faster movement with ctrl
nnoremap <C-j> 10j
nnoremap <C-k> 10k

" Move blocks in visual mode while maintaining selection
vnoremap < <gv
vnoremap > >gv

" Tab: next buf, Shift-Tab prev buf
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprev<CR>

" Highlight search without moving when using *
nnoremap <silent> * :let start_pos = winsaveview()<CR>*:call winrestview(start_pos)<CR>

" Hide search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Delete current buffer
nnoremap <C-q> :bdelete<CR>

" }}}
" Plugins {{{
call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'b4b4r07/vim-hcl'
Plug 'djoshea/vim-autoread'
Plug 'dyng/ctrlsf.vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'maxboisvert/vim-simple-complete'
Plug 'myitcv/govim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'pix/git-rebase-helper'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTRee', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'tomasr/molokai'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'wellle/targets.vim' 

call plug#end()

" }}}
" Colors {{{

set t_Co=256
set t_ut=
set termguicolors
colorscheme molokai

" }}}
" Indent {{{

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" }}}
" Status line {{{

hi User1 guifg=#AFD702 guibg=#3E3D32

" Reset
set statusline=

" Show git branch
set statusline+=%1*
set statusline+=\ %{FugitiveHead()}\ 
set statusline+=%*

" Show filename
set statusline+=\ %f

" Show modifier flag
set statusline+=%#warningmsg#
set statusline+=%m
set statusline+=%*

" Right align remaining items
set statusline+=%=

" Show file type
set statusline+=\ %{&filetype}

" Line : Column
set statusline+=\ %l:%c

" Trailing space
set statusline+=\ 

" }}}
" Autocommands {{{

" Don't move backwards with ESC
autocmd! InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

" Fast escape
set notimeout
set ttimeout
set ttimeoutlen=10
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END

" Remember location in file when opened
autocmd! BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" }}}

" vim: set foldmethod=marker:
