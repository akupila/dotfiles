" General {{{

set autoindent
set autoread
set background=dark
set balloondelay=250
set belloff=all
set complete-=i
set completeopt=popup
set completepopup=align:menu,border:off,highlight:Pmenu
set encoding=utf-8
set expandtab
set foldopen-=search
set formatoptions=tcqj
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:⎸\ ,trail:·,nbsp:⎵
set mouse=a
set nobackup
set nofsync
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
set termguicolors
set ttimeoutlen=50
set ttyfast
set ttymouse=sgr
set undofile
set updatetime=250
set viminfo+=!
set wildmenu

filetype plugin indent on

" }}}
" Indent {{{

" Default
set tabstop=4
set shiftwidth=4
set softtabstop=4

" }}}
" Key remapping {{{

" Use , as leader
let maploader = ","
let g:mapleader = ","

" Toggle alternate file
nnoremap Q <c-^>
vnoremap Q <nop>

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
nnoremap <leader>cr :source $MYVIMRC<CR>:nohlsearch<CR>

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
nnoremap <leader>q :bdelete<CR>
nnoremap <leader>Q :bdelete!<CR>

" Replace visual selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" }}}
" Plugins {{{

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'ayu-theme/ayu-vim'
Plug 'b4b4r07/vim-hcl'
Plug 'cespare/vim-go-templates'
Plug 'christoomey/vim-system-copy'
Plug 'djoshea/vim-autoread'
Plug 'dyng/ctrlsf.vim'
Plug 'govim/govim', { 'for': 'go' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'obreitwi/vim-sort-folds'
Plug 'pix/git-rebase-helper'
Plug 'preservim/nerdtree', { 'on': ['NERDTRee', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'romainl/vim-qf'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'wellle/targets.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

" }}}
" Colors {{{

let ayucolor="dark"
colorscheme ayu

set t_ut=

" " Fix undercurl
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
hi SpellBad cterm=undercurl

" }}}
" Status line {{{

hi User1 guifg=#E6E1CF guibg=#253340

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
fun! RestorePos()
    if &ft == 'gitrebase'
        return
    endif
    if line("'\"") <= 0 || line("'\"") <= line("$")
        return
    endif
    exec "normal! g'\""
endfun
autocmd! BufReadPost * call RestorePos()

" Don't move backwards with ESC
autocmd! InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

autocmd! VimResized * wincmd =

" Hide scratch from buffer list (created from autocomplete popup)
fun! HideScratch()
  if (&bufhidden == 'wipe')
    setlocal nobuflisted
  endif
endfun
augroup Scratch
  autocmd!
  au BufEnter * call HideScratch()
augroup END

" Don't keep initial buffer around
" https://vi.stackexchange.com/a/715
fun! Start()
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif
    enew
    setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber
endfun
autocmd VimEnter * call Start()

" Show cursorline, hide in insert mode
set cursorline
augroup CursorLine
  autocmd!
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END

" vim: set foldmethod=marker:
