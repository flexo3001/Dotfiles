if ($TERM=~"xterm-256color" || $TERM=~"screen-256color")
  call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'romainl/flattened'
  Plug 'tpope/vim-eunuch'
  call plug#end()

  colorscheme flattened_light
endif

filetype plugin indent on

set autoindent
set autowrite
set expandtab
set ignorecase
set incsearch
set laststatus=2
set linebreak
set list listchars=trail:·,tab:▸\ ,eol:¬
set nojoinspaces
set number
set printoptions=paper:A4,syntax:n,number:y
set shiftwidth=4
set showbreak=↪\
set statusline=[%n]\ %<%f\ %h%w%m%r%=%{&fileencoding?&fileencoding:&encoding}[%{&fileformat}\]\ %y\ %l,%c%V\ %P
set textwidth=120
set wrapscan
set path+=**

let mapleader=" "
let maplocalleader=" "

nnoremap <silent> <Leader>p :set paste!<CR>
nnoremap <silent> <Leader>h :nohlsearch<CR>
nnoremap <silent> <Leader>s
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>
             \    syntax enable <BAR>
             \ endif<CR>

nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

augroup vimrc
  autocmd!
  autocmd BufNewFile,BufRead *.pdc,*.pandoc setlocal filetype=markdown
  autocmd FileType puppet setlocal tw=140
  autocmd FileType sh,zsh,ruby,vim,yaml setlocal sw=2
  autocmd Filetype go setlocal noexpandtab sw=8
augroup END
