scriptencoding utf-8
set encoding=utf-8

" General {{{

set background=dark
set balloondelay=250
set belloff=all
set clipboard=unnamed
set completeopt=menuone,preview,popup,noselect
set completepopup=align:menu,border:off,highlight:Pmenu
set expandtab
set formatoptions=tcqj
set hidden
set hlsearch
set ignorecase
set lazyredraw
set list
set listchars=tab:⎸\ ,trail:·,nbsp:⎵
set nobackup
set nofsync
set noshowmode
set noswapfile
set number
set numberwidth=4
set relativenumber
set shortmess=aIc
set signcolumn=yes
set smartcase
set smarttab
set termguicolors
set ttyfast
set undofile
set updatetime=250
set viminfo+=!
set wildmenu
set wildmode=longest:full,full

set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

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

" Exit insert jk
inoremap jk <Esc>

" ; instead of : to enter command mode
noremap ; :

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

" Highlight search without moving when using *
nnoremap <silent> * :let start_pos = winsaveview()<CR>*:call winrestview(start_pos)<CR>

" Hide search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Replace visual selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" }}}
" Plugins {{{

call plug#begin()

Plug 'ayu-theme/ayu-vim'
Plug 'b4b4r07/vim-hcl'
Plug 'christoomey/vim-system-copy'
Plug 'djoshea/vim-autoread'
Plug 'dyng/ctrlsf.vim'
Plug 'govim/govim', { 'for': 'go' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'moll/vim-bbye'
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pix/git-rebase-helper'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', { 'branch': 'release/0.x', 'do': 'npm install' }
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'wellle/targets.vim'
Plug 'yami-beta/asyncomplete-omni.vim'

call plug#end()

function! Omni()
    call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
                    \ 'name': 'omni',
                    \ 'whitelist': ['go'],
                    \ 'completor': function('asyncomplete#sources#omni#completor')
                    \  }))
endfunction

au VimEnter * :call Omni()

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

" Auto resize splits when terminal is resized
autocmd! VimResized * wincmd =

" Hide scratch from buffer list (created from autocomplete popup)
fun! HideScratch()
  if (&bufhidden == 'wipe')
    setlocal nobuflisted
  endif
  if (expand('%') == '')
    setlocal nobuflisted
  endif
endfun
augroup Scratch
  autocmd!
  au BufEnter * call HideScratch()
augroup END

" Show cursorline, hide in insert mode
set cursorline
augroup CursorLine
  autocmd!
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END

" vim: set foldmethod=marker:
