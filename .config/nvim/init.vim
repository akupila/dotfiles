" General {{{

set lazyredraw                         " Don't redraw when running macros
set number                             " Enable line numbers
set relativenumber                     " Enable relative numbers
set numberwidth=5                      " Wider line numbers
set mousehide                          " Hide mouse when typing
set undofile                           " Enable persistent undo
set hidden                             " Do not abandon hidden buffers
set ignorecase                         " Ignore case in search
set smartcase                          " Use case-sensitive search if query contains uppercase characters
set incsearch                          " Enable incremental (real time) search

" Clear some messages:
set shortmess=flnIc

" Disable preview in autocomplete
set completeopt-=preview

" Highlight search without moving when using *
nnoremap <silent> * :let start_pos = winsaveview()<CR>*:call winrestview(start_pos)<CR>

" }}}
" Key remaps {{{

" Use , as lader
let maploader   = ","
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
nnoremap <silent> <leader>cr :source $MYVIMRC<CR>

" Faster movement with ctrl
nnoremap <C-j> 10j
nnoremap <C-k> 10k

" Tab: next buf, Shift-Tab prev buf
nnoremap <silent> <Tab> :cclose<CR> :bnext<CR>
nnoremap <silent> <S-Tab> :cclose<CR> :bprev<CR>

" Hide search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Delete current buffer
nnoremap <silent> <C-q> :bdelete<CR>

" }}}
" Plugins {{{

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'pix/git-rebase-helper'           " Git Rebase Helper

Plug 'tpope/vim-fugitive'              " Git info

Plug 'tpope/vim-rhubarb'               " Enable GBrowse for opening line on Github
" Show git blame
nnoremap <leader>gb :Gblame<CR>

Plug 'airblade/vim-gitgutter'          " Git status in gutter

Plug 'vim-scripts/ReplaceWithRegister' " Replace selected text with register

Plug 'tomasr/molokai'                  " Molokai colorscheme

Plug 'ap/vim-buftabline'               " Show buffers on top
" Show buffers if there are two or more open
let g:buftabline_show = 1
" Show indicator when buffer is not saved
let g:buftabline_indicators = 1
" Show numbers
let g:buftabline_numbers = 2
" Quick jump to buffer
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

Plug 'tpope/vim-commentary'            " Toggle comments with gc

Plug 'wellle/targets.vim'              " More text targets: (), [], {}, <>

Plug 'vim-scripts/Align'               " Align helper (:Align = etc)

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :Files<CR>

command! -bang -nargs=* FindInFiles call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
nnoremap <leader>f :FindInFiles 

Plug 'scrooloose/nerdtree', { 'on': ['NERDTRee', 'NERDTreeToggle', 'NERDTreeFind'] }
nnoremap <silent> <c-n> :NERDTreeToggle<CR>
nnoremap <silent> <leader><c-n> :NERDTreeFind<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeShowHidden = 1

Plug 'tpope/vim-surround'              " Add/change surrounding quotes, brackets etc

" Go
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
autocmd FileType go nmap <buffer> Q :GoAlternate!<CR>
autocmd FileType go nmap <buffer> <Leader>i <Plug>(go-info)
autocmd FileType go nmap <buffer> <Leader>t <Plug>(go-coverage-toggle)
autocmd FileType go nmap <buffer> <Leader>e <Plug>(go-rename)
autocmd FileType go nmap <buffer> <Space> :GoDeclsDir<CR>

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

Plug 'mxw/vim-jsx', { 'for': 'jsx' }   " JSX

Plug 'plasticboy/vim-markdown'         " Markdown

Plug 'godlygeek/tabular'               " Markdown tables (required vim-markdown)

Plug 'mzlogin/vim-markdown-toc'        " Markdown table of contents

" Autocomplete
if !has("python3")
	echo "deoplete requires python 3"
	echo "pip3 install --user neovim"
endif
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make' }
let g:deoplete#enable_at_startup = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1
autocmd InsertEnter * call deoplete#enable()

" Prev/next autocomplete result with tab/shift-tab and ctrl-j/k
imap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr> <c-j> pumvisible() ? "\<c-n>" : "\<c-j>"
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
imap <expr> <c-k> pumvisible() ? "\<c-p>" : "\<c-k>"
imap <expr> <CR>  (pumvisible() ?  "\<c-y>" : "\<CR>")

Plug 'neomake/neomake'
autocmd BufWritePost * Neomake
let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '›', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--tests',
  \   '--enable-gc',
  \   '--concurrency=3',
  \   '--fast',
  \   '-D', 'aligncheck',
  \   '-D', 'dupl',
  \   '-D', 'gocyclo',
  \   '-D', 'gotype',
  \   '-E', 'errcheck',
  \   '-E', 'misspell',
  \   '-E', 'unused',
  \   '%:p:h',
  \ ],
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }

call plug#end()

" }}}
" Colors {{{

set termguicolors
set background=dark
colorscheme molokai

" Set neomake sign colors
hi NeomakeErrorSign        guifg=#FF2222 guibg=#232526
hi NeomakeWarningSign      guifg=#BBBB00 guibg=#232526
hi NeomakeMessageSign      guifg=#999999 guibg=#232526
hi NeomakeInfoSign         guifg=#21BCFF guibg=#232526

" }}}
" Indent {{{

" 1 tab = 4 spaces
set tabstop=4
" Convert inserted tab to spaces
set expandtab
" Shift 2 spaces
set shiftwidth=4
" Convert tabs to spaces
set softtabstop=4

" }}}
" Status line {{{

" Always enable status line
set laststatus=2

hi User1 guifg=#AFD702 guibg=#3E3D32

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
" Show git branch
set statusline+=%1*
set statusline+=%{StatuslineGit()}
set statusline+=%*

" Show filename
set statusline+=\ %f

" Display a warning if fileformat isn't unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

" Show modifier flag
set statusline+=%#warningmsg#
set statusline+=%m
set statusline+=%*

" Right align remaining items
set statusline+=%=

" Show file type
set statusline+=\ %{&filetype}

" Percentage in file
set statusline+=\ %p%%

" Line / total lines
set statusline+=\ %l/%L

" Column
set statusline+=:%c

" Trailing space
set statusline+=\ 

" }}}
" Spell check {{{

augroup GitCommitSpell
  autocmd!
  " Enable spellcheck, allow to start with lowercase
  autocmd FileType gitcommit setlocal spell spellcapcheck=
augroup END

augroup ReadmeSpell
  autocmd!
  " Enable spellcheck
  autocmd FileType markdown setlocal spell
augroup END

" }}}
" Other {{{

" Display the highlight group and color under the cursor
function! PrintHiGroup()
	let id = synID(line("."), col("."), 1)
	echo synIDattr(id, "name") .
		\ " " .
		\ synIDattr(synIDtrans(id), "fg") . 
		\ " " .
		\ synIDattr(synIDtrans(id), "bg")
endfunction
map <F10> :call PrintHiGroup()<CR>

" }}}
" vim: set foldmethod=marker:
