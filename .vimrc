" --------------------------------------
" General
" --------------------------------------

" Fix interpreting vimrc
scriptencoding utf-8

" Don't redraw when running macros
set lazyredraw

" Disable backups & swaps
set noswapfile
set nobackup

" List hidden characters
set list
" Show tabs
set listchars=tab:\⋮\ 
" Show trailing spaces
set listchars+=trail:·

" Disable | characters on splits
set fillchars=""

" Do not unload abandonded (background) buffers
set hidden

" Split to right and down
set splitbelow
set splitright

" Use , as leader
let mapleader = ","
let g:mapleader = ","

if has('nvim')
  " Enable neovim live replace
  set inccommand=nosplit
  " Disable setting line cursor on insert
  set guicursor=
endif

" --------------------------------------
" Plugins
" https://github.com/junegunn/vim-plug#installation
" --------------------------------------

call plug#begin('~/.config/nvim/plugged')

" --------------------------------------
" General

" Defaults
Plug 'tpope/vim-sensible'

" Git status in gutter
Plug 'airblade/vim-gitgutter'

" Automatically load file if changed on disk
Plug 'djoshea/vim-autoread'

" Git info
Plug 'tpope/vim-fugitive'
" Enable GBrowse for github
Plug 'tpope/vim-rhubarb'
nnoremap <leader>gb :Gblame<CR>

" Replace selected text with register
Plug 'vim-scripts/ReplaceWithRegister'

" Molokai colors
Plug 'tomasr/molokai'

" Show buffers on top
Plug 'ap/vim-buftabline'
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

" More useful screen
Plug 'mhinz/vim-startify'
" stay in dir where vim was openened
let g:startify_change_to_dir = 0
" don't need to look at a cow
let g:startify_custom_header = ['    ϟ']
let g:startify_list_order = [
    \ ['   dir:'],
    \ 'dir',
    \ ['   recent:'],
    \ 'files',
    \ ['   sessions:'],
    \ 'sessions',
    \ ['   bookmarks:'],
    \ 'bookmarks',
    \ ]
" --------------------------------------

" --------------------------------------
" Text helpers

" Toggle comments (gc - go comment)
Plug 'tpope/vim-commentary'

" Toggle comments with gc
Plug 'tpope/vim-commentary'

" More text targets: (), [], {}, <>
Plug 'wellle/targets.vim'
" --------------------------------------

" --------------------------------------
" Navigation

" FZF fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore _testdata -g ""'
let g:fzf_layout = { 'down': '~35%' }
let g:fzf_buffers_jump = 1
let g:fzf_files_options = '--tiebreak=end --preview "(highlight --style=molokai -O xterm256 {} || coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
nnoremap <C-p> :Files<CR>
if has('mac')
    nnoremap <silent> π :Buffers<CR>
    nnoremap <silent> ® :History<CR>
else
    nnoremap <silent> <A-p> :Buffers<CR>
    nnoremap <silent> <A-r> :History<CR>
endif
nnoremap <leader>a :Ag 

" Nerdtree for file navigation
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind'] }
nnoremap <silent> <c-n> :NERDTreeToggle<CR>
nnoremap <silent> <leader><c-n> :NERDTreeFind<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeShowHidden = 1

" Fix opening file from FZF if Nerdtree open. Without this the file would open
" in the nerdtree buffer
nnoremap <silent> <expr> <C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

" Navigate vim and tmux panes with same keys
Plug 'christoomey/vim-tmux-navigator'
" --------------------------------------

" --------------------------------------
" Linting / Building

" Neomake async lints files
Plug 'neomake/neomake', { 'on': 'Neomake' }
let g:neomake_go_gometalinter_args = [
  \ '--fast',
  \ '--enable=gosimple',
  \ '--enable=unused',
  \ '--enable=staticcheck',
  \ '--enable=interfacer',
  \ '--enable=errcheck',
  \ '--enable=golint',
  \ '--enable=vet',
  \ '--enable=vetshadow',
  \ ]
let g:neomake_javascript_enabled_makers = ['eslint_d', 'flow']
let g:neomake_verbose = 0
let g:neomake_warning_sign = {
  \ 'text': '!',
  \ 'texthl': 'GitGutterChangeDefault',
  \ }
let g:neomake_error_sign = {
  \ 'text': '⨯',
  \ 'texthl': 'GitGutterDeleteDefault',
  \ }
autocmd! BufWritePost,BufEnter * Neomake
" --------------------------------------

" --------------------------------------
" Formatting
Plug 'sbdchd/neoformat'
let g:neoformat_javascript_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--stdin'],
            \ 'stdin': 1,
            \ 'no_append': 1,
            \ }
let g:neoformat_json_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--stdin'],
            \ 'stdin': 1,
            \ 'no_append': 1,
            \ }
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_jsx = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_json = ['prettier']
let g:neoformat_basic_format_trim = 1
let g:neoformat_only_msg_on_error = 1
autocmd! BufWritePre *.js,*.jsx,*.json,*.css,*.scss,*.graphql :Neoformat

" Change surrounding quotes, brackets etc
Plug 'tpope/vim-surround'
" --------------------------------------

" --------------------------------------
" Filetypes

" Go
Plug 'fatih/vim-go', { 'for': 'go' }
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
autocmd FileType go nnoremap <silent> Q :GoAlternate!<CR>
autocmd FileType go nnoremap <silent> <Leader>i :GoInfo<CR>
autocmd FileType go nnoremap <silent> <Leader>t :GoCoverageToggle<CR>

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" JSX
Plug 'mxw/vim-jsx', { 'for': 'jsx' }

" GraphQL
Plug 'jparise/vim-graphql'

" Flow
Plug 'flowtype/vim-flow'
" Neobuild will show errors
let g:flow#showquickfix = 0
" Disable omnifunc (already provided by nvim-completion-manager
let g:flow#omnifunc = 0
autocmd FileType javascript nnoremap <silent> gd :FlowJumpToDef<CR>
autocmd FileType javascript nnoremap <silent> <leader>i :FlowType<CR>

" Markdown
" Required to format markdown tables
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

" Jenkinks
Plug 'martinda/Jenkinsfile-vim-syntax'
" --------------------------------------

" --------------------------------------
" Autocomplete
" Autocompletion manager
" mistune: autocomplete for markdown
Plug 'roxma/nvim-completion-manager'
" Requires vim8 with has('python') or has('python3')
" Requires the installation of msgpack-python. (pip install msgpack-python)
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Prev/next autocomplete result with tab/shift-tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Flow
Plug 'roxma/ncm-flow', { 'for': 'javascript' }

" CSS
Plug 'calebeby/ncm-css', { 'for': 'css' }
" --------------------------------------

" --------------------------------------
" Misc

" Distraction free writing
Plug 'junegunn/goyo.vim'
let g:goyo_width = 100

function! s:goyo_enter()
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
endfunction

function! s:goyo_leave()
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" --------------------------------------

call plug#end()


" --------------------------------------
" General key maps
" --------------------------------------

" Exit insert and command mode with jk
" Note: This is not set up for visual mode as otherwise it'll delay moving
" down when selecting text which is really annoying
inoremap jk <Esc>
cnoremap jk <C-c>

" ; instead of : to enter command mode
noremap ; :

" Yank to end of line
nnoremap Y y$

" --------------------------------------
" Colors
" --------------------------------------

if has("termguicolors")
  set termguicolors
else
  set t_Co=256
endif
set background=dark

colorscheme molokai

" --------------------------------------
" Tabs / spaces
" --------------------------------------

" 1 tab = 4 spaces
set tabstop=4
" Convert inserted tab to spaces
set expandtab
" Shift 4 spaces
set shiftwidth=4
" Convert tabs to spaces
set softtabstop=4

" --------------------------------------
" Line numbers
" --------------------------------------

" Show line number on active line
set number

" Relative numbers
set relativenumber

" Wider line numbers
set numberwidth=6

" --------------------------------------
" Undo
" --------------------------------------

" Enable persistent undo
set undofile
set undodir=~/.vim/undo

" --------------------------------------
" Movement
" --------------------------------------

" Faster movement with ctrl
if has('mac') 
    nnoremap ∆ 10j
    vnoremap ∆ 10j
    nnoremap ˚ 10k
    vnoremap ˚ 10k
    nnoremap ˙ 15h
    nnoremap ¬ 15l
else
    nnoremap <A-j> 10j
    vnoremap <A-j> 10j
    nnoremap <A-k> 10k
    vnoremap <A-k> 10k
    nnoremap <A-h> 15h
    nnoremap <A-l> 15l
endif

" Move to line above/below even if line is wrapping
nnoremap j gj
nnoremap k gk

" Move blocks in visual mode
vnoremap < <gv
vnoremap > >gv

" H and L move to beginning / end of line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" Move line up/down with alt-j/k, maintain indentation
if has('mac')
    nnoremap <silent> Ô :m .+1<CR>==
    nnoremap <silent>  :m .-2<CR>==
else
    nnoremap <silent> <A-j> :m .+1<CR>==
    nnoremap <silent> <A-k> :m .-2<CR>==
endif

" Tab: next buf, Shift-Tab prev buf
nnoremap <silent> <Tab> :cclose<CR> :bnext<CR>
nnoremap <silent> <S-Tab> :cclose<CR> :bprev<CR>

" Open quickfix list
nnoremap <silent> <leader>o :copen<CR>

" Scroll 5 lines from top/bottom
set scrolloff=5

" Prev/next in quickfix
nnoremap <silent> = :cnext<cr>zz
nnoremap <silent> - :cprev<cr>zz

" Cursorline in normal more
augroup CursorlineInsert
  autocmd!
    set cursorline " default on
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END

" --------------------------------------
" Search
" --------------------------------------

" Ignore case in search
set ignorecase

" Use case-sensitive search if query contains upper case chars
set smartcase

" Hide search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Highlight search but don't move with *
nnoremap <silent> * :let stay_star_view = winsaveview()<CR>*:call winrestview(stay_star_view)<CR>

" Enable extended regular expressions
set magic

" Make vim regexps use verymagic (more like PCREs, write \w+ instead if \w\+)
nnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" --------------------------------------
" Statusline
" --------------------------------------

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

" --------------------------------------
" Clipboard
" --------------------------------------

if has('mac')
set clipboard=unnamed
endif

" --------------------------------------
" Search & replace
" --------------------------------------

" Enable incremental (real time) search
set incsearch

" --------------------------------------
" Filetypes
" --------------------------------------

augroup GitCommit
  autocmd!
  " Enable spellcheck, allow to start with lowercase
  autocmd FileType gitcommit setlocal spell spellcapcheck=
augroup END

augroup Markdown
  autocmd!
  " Enable spellcheck
  autocmd FileType markdown setlocal spell
augroup END

augroup JavaScript
  autocmd!
  autocmd BufNewFile *.js,*.jsx 0r ~/.vimtemplates/template.js | exec "normal! G"
augroup END

augroup envrc
  autocmd!
  autocmd BufNewFile,BufRead .envrc set filetype=sh
augroup END

augroup Crontab
  autocmd!
  " Disable backups, causes issues
  autocmd filetype crontab setlocal nobackup nowritebackup
augroup END

" --------------------------------------
" Abbrevations / simple snippets
" --------------------------------------

iabbrev todo TODO(akupila):

" --------------------------------------
" Misc
" --------------------------------------

" Reload vimrc
nnoremap <silent> <leader>cr :source $MYVIMRC<CR>

" Don't move backwards with ESC
augroup NoMoveEsc
    autocmd!
    autocmd InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])
augroup END

" Open vertical help with H
" :h topic -> horizontal
" :H topic -> vertical
cnoreabbrev H vertical botright h

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

" Set more undo points in insert mode
inoremap . .<C-g>u
inoremap , ,<C-g>u

" Resize vertical windows with shift + / -
nnoremap <silent> + :exe "vertical resize"  . (winwidth(0) * 4/3)<CR>
nnoremap <silent> _ :exe "vertical resize"  . (winwidth(0) * 3/4)<CR>
