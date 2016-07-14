set nocompatible

" Fix encoding (on ssh)
scriptencoding utf-8
set encoding=utf-8

" Plugins
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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'jiangmiao/auto-pairs'
Plugin 'easymotion/vim-easymotion'
Plugin 'godlygeek/tabular'
call vundle#end()


" Colors
set t_co=256
set background=dark
syntax on
filetype plugin indent on
colorscheme molokai

" Core keymaps
let mapleader=","
imap jk <Esc>l
map ; :
noremap ;; ;

" General
set autoindent                                                "  Copy indent from last line when starting new line
set autoread                                                  "  Automatically load files changed outside of vim
set backspace=indent,eol,start                                "  Allow backspace in insert mode
set clipboard=unnamed                                         "  Share clipboard with OS X
set esckeys                                                   "  Allow cursor keys in insert mode
set expandtab                                                 "  Expand tabs to spaces
set fillchars=""                                              "  Disable - | chars on horizontal/vertical splits
set formatoptions=ql                                          "  Don't continue comments
set laststatus=2                                              "  Always show status bar
set lazyredraw                                                "  Only render when needed
set noerrorbells                                              "  Disable error bells
set noshowmode                                                "  Do not show current mode (airline shows it)
set noswapfile                                                "  Disable swap files
set scrolloff=3                                               "  Scroll offset on top/bottom
set shortmess+=I                                              "  Disable vim intro screen
set ttyfast                                                   "  Send more characters at a time
set visualbell                                                "  Visual bell instead of audio

" Indentation
set list                                                      "  Enable listing chars
set listchars=tab:\ \ ,trail:·,nbsp:_
set shiftwidth=2                                              "  Shift indentation 2 spaces
set smarttab                                                  "  At beginning of line Tab inserts shiftwidth spaces
set softtabstop=2                                             "  Convert a tab to 2 spaces
set tabstop=2                                                 "  Set tab 2 spaces wide

" Navigation
set cursorline                                                "  Enable cursorline
set number                                                    "  Absolute line number on active line (required vim 7.4+)
set relativenumber                                            "  Relative line numbers
set splitright                                                "  Split vertical windows right to the current windows
set splitbelow                                                "  Split horizontal windows below to the current windows

" Search
set hlsearch                                                  "  Highlight all search results
set ignorecase                                                "  Ignore case (for opening files etc)
set incsearch                                                 "  Search as you type

" Key remaps
"  Scroll down 5 lines at a time
nnoremap <C-e> 5<C-e>
"  Scroll up 5 lines at a time
nnoremap <C-y> 5<C-y>
"  Yank to end of line
nnoremap Y y$
"  Add a line below with enter
nnoremap <CR> o<Esc>
"  Move current line up with Ctrl-j, maintaining indentation
nnoremap <C-j> :m .+1<CR>==
"  Move current line up with Ctrl-k, maintaining indentation
nnoremap <C-k> :m .-2<CR>==
"  Search current word with leader-s
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
"  Move splits with Ctrl-hjkl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
" Vertical resize windows with + -
nnoremap <silent> + :exe "vertical resize                     "  . (winwidth(0) * 4/3)<CR>
nnoremap <silent> _ :exe "vertical resize                     "  . (winwidth(0) * 3/4)<CR>
" Fast save with leader-w
nnoremap <leader>w :w!<Enter>
" Remove search Highlight
nnoremap <leader><space> :noh<Enter>
" Add comma to end of line (useful for go)
nnoremap <leader>nc A,<Esc>
" Move directly to col above/below, even if line is wrapping, we'll see if this breaks macros..
nnoremap j gj
nnoremap k gk

" -------------------------------------
" Plugin config

" Airline
let g:airline_powerline_fonts = 1                             "  Enable powerline fonts
let g:airline_theme = "powerlineish"                          "  Set theme
let g:airline_extensions = ['branch', 'ctrlp', 'tabline']     "  Set extensions
let g:airline_section_y = ''                                  "  Disable showing encoding
let g:airline_section_z = '%3p%%  %l/%L  %c'                  "  Simplified percent lines/total column
let g:airline#extensions#tabline#tab_nr_type = 1              "  Show tab number
nmap <leader>1 <Plug>AirlineSelectTab1                        "  Jump to tab n
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" vim-go
let g:go_highlight_functions = 1                              "  Highlight things
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"                            "  Run goimports on save

" vim-go keyboard shortcuts
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
"  Run tests and show coverage
autocmd FileType go nmap <Leader>t :GoCoverageToggle<CR>

" neocomplete
let g:neocomplete#enable_at_startup = 1                       "  Enable on startup
let g:neocomplete#enable_auto_select = 1                      "  Automatically select first suggestion
set completeopt-=preview                                      "  Disable preview window
let g:neocomplete#sources#syntax#min_keyword_length = 2       "  Set minimum syntax keyword length.
" <Enter>: close popup and save indent.
inoremap <silent> <Enter> <C-r>=<SID>close_popup()<Enter>
" fix adding linebreak on enter
function! s:close_popup()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" ctrlp
let g:ctrlp_custom_ignore = 'vendor'                          "  Ignore vendor dir in search

" NERDTree
"  Toggle tree view with ctrl-n
nnoremap <C-n> :NERDTreeToggle<CR>
"  Show current file in tree view with leader ctrl-n
nnoremap <leader><C-n> :NERDTreeFind<CR>

" nerdcommenter
let g:NERDSpaceDelims = 1                                     " Add soaces after comment delimeters

" Fugitive
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>

function! ToggleBG()
  let Syn=&syntax
  if &bg=="light"
    set bg=dark
    set background=dark
    colorscheme molokai
    set cursorline
    let g:airline_theme = "powerlineish"                          "  Set theme
  else
    set bg=light
    set background=light
    colorscheme one
    set nocursorline
    let g:airline_theme = "light"                          "  Set theme
  endif
  syn on
  exe "set syntax=" . Syn
endfunction
command! InvBg call ToggleBG()
noremap  <F6> :InvBg<CR>

