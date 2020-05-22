if (&t_Co == 256 || &term == "xterm-256color" || &term == "screen-256color")
  call plug#begin('~/.vim/plugged')
  Plug 'icymind/NeoSolarized'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-eunuch'
  call plug#end()

  let $FZF_DEFAULT_COMMAND = 'find .'
  let g:signify_realtime = 1

  let g:fzf_colors =
   \ { 'fg':      ['fg', 'Normal'],
     \ 'bg':      ['bg', 'Normal'],
     \ 'fg+':     ['fg', 'Normal'],
     \ 'bg+':     ['bg', 'CursorLine'],
     \ 'hl':      ['fg', 'Error'],
     \ 'hl+':     ['fg', 'Error'],
     \ 'pointer': ['fg', 'Normal'],
     \ 'info':    ['fg', 'Comment'],
     \ 'prompt':  ['fg', 'Normal'],
     \ 'spinner': ['fg', 'Normal'],
     \ 'border':  ['fg', 'StatusLine'],
     \ 'header':  ['fg', 'Normal']}
  if has('nvim')
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  endif

  set background=light
  set termguicolors
  colorscheme NeoSolarized
endif

filetype plugin indent on

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
set smartindent
set statusline=[%n]\ %<%f\ %h%w%m%r%=%{&fileencoding?&fileencoding:&encoding}[%{&fileformat}\]\ %y\ %l,%c%V\ %P
set textwidth=80
set wrapscan

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
nnoremap <silent> <Leader>f :FZF<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

augroup flexo
  autocmd!
  autocmd BufNewFile,BufRead *.pdc,*.pandoc setlocal filetype=markdown
  autocmd FileType puppet setlocal tw=140
  autocmd FileType sh,zsh,ruby,vim,yaml setlocal sw=2
  autocmd Filetype go setlocal noexpandtab
augroup END
