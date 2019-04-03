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
set noshowmode                         " Disable showing mode, cursor change is sufficient
set updatetime=250                     " Faster cursorhold
set shortmess=aIc                      " Shorter mesasges (a), no intro (I), disable completion message (c)
set nomore                             " Disable 'Press ENTER to continue' when there are multiple lines in output
set list                               " Display hidden characters
set listchars=tab:›·,trail:·,nbsp:⎵
set signcolumn=yes                     " Prevent potential blinking with sign column hiding

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

" Use , as leader
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

" Go to beginning of line with ctrl-a in command mode, like in zsh
cnoremap <C-a> <C-b>

" Switch to previous buffer
nnoremap <space><space> :edit#<CR>

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
" Plugins {{{

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'pix/git-rebase-helper'                                                   " Git Rebase Helper

Plug 'tpope/vim-fugitive'                                                      " Git info
nnoremap <leader>gb :Gblame<CR>

Plug 'airblade/vim-gitgutter'                                                  " Git status in gutter

Plug 'vim-scripts/ReplaceWithRegister'                                         " Replace selected text with register

Plug 'tomasr/molokai'                                                          " Molokai colorscheme

Plug 'rakr/vim-one'                                                            " One colorscheme

Plug 'ap/vim-buftabline'                                                       " Show buffers on top
" Show buffers if there are two or more open
let g:buftabline_show = 1
" Show indicator when buffer is not saved
let g:buftabline_indicators = 1
" Show numbers
let g:buftabline_numbers = 2
" Quick jump to buffer
if !has("mac")
    " Does not work in iTerm (by default at least)
    nmap <A-1> <Plug>BufTabLine.Go(1)
    nmap <A-2> <Plug>BufTabLine.Go(2)
    nmap <A-3> <Plug>BufTabLine.Go(3)
    nmap <A-4> <Plug>BufTabLine.Go(4)
    nmap <A-5> <Plug>BufTabLine.Go(5)
    nmap <A-6> <Plug>BufTabLine.Go(6)
    nmap <A-7> <Plug>BufTabLine.Go(7)
    nmap <A-8> <Plug>BufTabLine.Go(8)
    nmap <A-9> <Plug>BufTabLine.Go(9)
    nmap <A-0> <Plug>BufTabLine.Go(10)
endif
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

Plug 'tpope/vim-commentary'                                                    " Toggle comments with gc

Plug 'wellle/targets.vim'                                                      " More text targets: (), [], {}, <>

Plug 'vim-scripts/Align'                                                       " Align helper (:Align = etc)

Plug 'djoshea/vim-autoread'                                                    " Automatically load changed file from disk

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }

Plug 'junegunn/fzf.vim'
nnoremap <C-p> :Files<CR>

Plug 'scrooloose/nerdtree', { 'on': ['NERDTRee', 'NERDTreeToggle', 'NERDTreeFind'] }
func! NERDTreeToggleWithRefresh()
    :NERDTreeToggle
    if (exists("b:NERDTreeType") == 1)
        call feedkeys("R")
    endif
endfunction
func! NERDTreeFindWithRefresh()
    :NERDTreeFind
    if (exists("b:NERDTreeType") == 1)
        call feedkeys("R")
    endif
endfunction
nnoremap <silent> <c-n> :call NERDTreeToggleWithRefresh()<CR>
nnoremap <silent> <leader><c-n> :call NERDTreeFindWithRefresh()<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeShowHidden = 1

Plug 'tpope/vim-surround'                                                      " Add/change surrounding quotes, brackets etc

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }                            " Go

Plug 'buoto/gotests-vim', { 'for': 'go' }                                      " Generate go table driven tests

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }                        " JavaScript

Plug 'mxw/vim-jsx', { 'for': 'jsx' }                                           " JSX

Plug 'plasticboy/vim-markdown'                                                 " Markdown

Plug 'godlygeek/tabular'                                                       " Markdown tables (required vim-markdown)

Plug 'mzlogin/vim-markdown-toc'                                                " Markdown table of contents

" Autocomplete
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" ALE linter
Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_linters = {'go': ['golangci-lint']}
let g:ale_go_golangci_lint_options = '--fast -e "Error return of","should have comment","undeclared name"'

Plug 'uber/prototool', { 'rtp':'vim/prototool' }                               " Protobuf

Plug 'wannesm/wmgraphviz.vim'                                                  " Graphviz

Plug 'dyng/ctrlsf.vim'                                                         " Project wide search/replace
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

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

Plug 'b4b4r07/vim-hcl'

Plug 'fatih/vim-hclfmt'

" Typescript
" npm install -g typescript neovim
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }


Plug 'prettier/vim-prettier'

" Autoformat on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

call plug#end()

" }}}
" Colors {{{

set termguicolors
set background=dark
colorscheme molokai

" Tweak ALE colors
highlight ALEErrorSign          guifg=#FF2222 guibg=#232526
highlight ALEWarningSign        guifg=#BBBB00 guibg=#232526
highlight ALEInfoSign           guifg=#21BCFF guibg=#232526

" Tweak git gutter to match
highlight GitGutterAdd          guifg=#A6E22E guibg=#232526
highlight GitGutterChange       guifg=#75715E guibg=#232526
highlight GitGutterDelete       guifg=#F92672 guibg=#232526
highlight GitGutterChangeDelete guifg=#F92672 guibg=#232526

" Improve visibility of current item when doing s//gc
highlight IncSearch             guifg=#FFFFFF guibg=#000000

" Increase line number visibility (original: #465457)
highlight LineNr                guifg=#656E70

" Decrease invisible character visibility (original: #465457)
highlight NonText guifg=#2a3234

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

" Line : Column
set statusline+=\ %l:%c

" FileOffset returns zero indexed byte offset
" The default %o starts at 1
function! FileOffset()
    return line2byte(line('.')) + col('.') - 2
endfunction

" Byte index
set statusline+=\ %{FileOffset()}

" Trailing space
set statusline+=\ 

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

" Fix fat fingers, replace 1= with !=
iabbr 1= !=
iabbr Functinos Functions

" }}}
" vim: set foldmethod=marker:
