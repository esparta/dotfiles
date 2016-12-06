" Leader
let mapleader = ","

scriptencoding utf-8
set encoding=utf-8

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set nocompatible              " be iMproved, required
filetype off                  " required
set shell=bash                " needed for my non POSIX Shell (Fish)
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Optional packages
Plugin 'kchmck/vim-coffee-script'
Plugin 'skwp/greplace.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'vim-ruby/vim-ruby'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ngmy/vim-rubocop'
Plugin 'rking/ag.vim'
" Colors
Plugin 'jpo/vim-railscasts-theme'

" Windows
Plugin 'vim-scripts/ZoomWin'

" Nerdtree
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Tab vs Space. Space win always.
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set autoindent                    " set auto indent

" Get off my lawn
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>


ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

set laststatus=2                  " always show status bar
"set number
set relativenumber                " show relative line numbers
set ruler                         " show row and column in footer
set backspace=indent,eol,start

" Backup? I don't know that Pokemon
set nobackup
set nowritebackup
set noswapfile

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Use the colorscheme from above
syntax enable
set background=dark
colorscheme railscasts

" put git status, column/row number, total lines, and percentage in status
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]

" vim-rspec mappings
let g:rspec_command = "!rspec --color --format documentation --fail-fast {spec}"
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" ctrlp config
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0

" NerdTree
map <C-n> :NERDTreeToggle<CR>
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" use silver searcher for ctrlp
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" set grepprg=ag
