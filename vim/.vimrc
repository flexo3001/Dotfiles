if ($TERM=~"xterm-256color" || $TERM=~"screen-256color")
  call plug#begin('~/.vim/plugged')
  Plug 'flexo3001/vim-colors-solarized'
  Plug 'mhinz/vim-signify'
  call plug#end()

  colorscheme solarized
  set background=light
endif

filetype plugin indent on

set autoindent
set autoread
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
set statusline=\(%n\)\ %<%.99f\ %y%w%m%r%=%-14.(%l,%c%V%)\ %P
set textwidth=120
set clipboard+=unnamedplus
set wrapscan
set path+=**

let mapleader=" "
let maplocalleader=" "

nnoremap <silent> <Leader>p :set paste!<CR>
nnoremap <silent> <Leader>h :nohlsearch<CR>
nnoremap <silent> <Leader>s :if exists("syntax_on") <BAR> syntax off <BAR> else <BAR> syntax enable <BAR> endif<CR>
nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

augroup vimrc
  autocmd!
  autocmd BufNewFile,BufRead *.pdc,*.pandoc setlocal filetype=markdown
  autocmd FileType puppet setlocal tw=140
  autocmd FileType sh,zsh,ruby,vim,yaml setlocal sw=2
  autocmd Filetype go setlocal noexpandtab sw=8
augroup END
