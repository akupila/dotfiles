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
set scrolloff=5                        " Scroll n lines from top/bottom

" Clear some messages:
set shortmess=flnIc

" Disable preview in autocomplete
set completeopt-=preview

" Disable swaps and backups
" djoshea/vim-autoread will read latest version of file to avoid conflicts
set noswapfile
set nobackup

" Highlight search without moving when using *
nnoremap <silent> * :let start_pos = winsaveview()<CR>*:call winrestview(start_pos)<CR>

" Fix clipboard
if has("mac")
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" Enable live replace
set inccommand=nosplit

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

" Move blocks in visual mode while maintaining selection
vnoremap < <gv
vnoremap > >gv

" Tab: next buf, Shift-Tab prev buf
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprev<CR>

" Hide search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Delete current buffer
nnoremap <silent> <C-q> :bdelete<CR>

" }}}
" Autocommands {{{

" Don't move backwards with ESC
augroup NoMoveEsc
    autocmd!
    autocmd InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])
augroup END

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
" Plugins {{{

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'pix/git-rebase-helper'           " Git Rebase Helper

Plug 'tpope/vim-fugitive'              " Git info
" Show git blame
nnoremap <leader>gb :Gblame<CR>

Plug 'airblade/vim-gitgutter'          " Git status in gutter

Plug 'vim-scripts/ReplaceWithRegister' " Replace selected text with register

Plug 'tomasr/molokai'                  " Molokai colorscheme

Plug 'rakr/vim-one'                    " One colorscheme

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

Plug 'djoshea/vim-autoread'            " Automatically load changed file from disk

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :Files<CR>

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
autocmd FileType go nmap <buffer> <Leader>t <Plug>(go-coverage-toggle)
autocmd FileType go nmap <buffer> <Leader>r <Plug>(go-rename)
autocmd FileType go nmap <buffer> <Leader>i <Plug>(go-info)
autocmd FileType go nmap <buffer> <Leader>e <Plug>(go-iferr)
autocmd FileType go nmap <buffer> <Space> :GoDeclsDir<CR>
" Disable spell on strings, only apply to comments
let g:go_highlight_string_spellcheck = 0
" Enable highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

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

" ALE linter
Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'

" Graphviz
Plug 'wannesm/wmgraphviz.vim'
autocmd FileType dot nmap <buffer> <leader>i :GraphvizInteractive<CR>

" Project wide search/replace
Plug 'dyng/ctrlsf.vim'
nmap <C-f> <Plug>CtrlSFPrompt
nmap <leader><C-f> <Plug>CtrlSFCwordPath
vmap <C-f> <Plug>CtrlSFVwordExec
vmap <C-f> <Plug>CtrlSFVwordExec
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_focus = {
    \ "at" : "start"
    \ }
let g:ctrlsf_auto_close = {
    \ "normal": 1,
    \ "compact": 1
    \ }

Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']
let g:UltiSnipsExpandTrigger = "<c-u>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

call plug#end()

" }}}
" Colors {{{

set termguicolors
set background=dark
colorscheme molokai

" Tweak ALE colors
highlight ALEErrorSign        guifg=#FF2222 guibg=#232526
highlight ALEWarningSign      guifg=#BBBB00 guibg=#232526
highlight ALEInfoSign         guifg=#21BCFF guibg=#232526

" Improve visibility of current item when doing s//gc
highlight IncSearch           guifg=#FFFFFF guibg=#000000

" Increase line number visibility (original: #465457)
highlight LineNr              guifg=#656E70

function! ToggleLight()
if (g:colors_name == "molokai")
    colorscheme one
    set background=light
else
    colorscheme molokai
    set background=dark
endif
endfunction
nnoremap <silent> <F10> :call ToggleLight()<CR>

" }}}
" Indent {{{

" Default: 1 tab = 4 spaces, expand & convert tabs to spaces

set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

autocmd Filetype yaml setlocal ts=2 sw=2

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

augroup GoSpell
    autocmd!
    " Enable spellcheck, allow to start with lowercase
    autocmd FileType go setlocal spell spellcapcheck=
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
nnoremap <F9> :call PrintHiGroup()<CR>

" }}}
" vim: set foldmethod=marker:
