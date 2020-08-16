if ($TERM=~"xterm-256color" || $TERM=~"screen-256color" || has("gui_vimr"))
    call plug#begin('~/.vim/plugged')
    Plug 'flexo3001/vim-colors-solarized'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'mhinz/vim-signify'
    Plug 'pearofducks/ansible-vim'
    call plug#end()

    colorscheme solarized
    set background=light

    let g:fzf_colors = {
        \ 'fg':      ['fg', 'Normal'],
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
        \ 'header':  ['fg', 'Normal']
    }

    if has('nvim')
        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noshowmode noruler
        \ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    endif
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
set mouse=a
set nojoinspaces
set number
set printoptions=paper:A4,syntax:n,number:y
set shiftwidth=4
set showbreak=↪\
set statusline=\(%n\)\ %<%.99f\ %y%w%m%r%=%-14.(%l,%c%V%)\ %P
set tabstop=4
set textwidth=120
"set clipboard+=unnamedplus
set wrapscan

let mapleader=" "
let maplocalleader=" "

nnoremap <silent> <Leader>p :set paste!<CR>
nnoremap <silent> <Leader>h :nohlsearch<CR>
nnoremap <silent> <Leader>s :if exists("syntax_on") <BAR> syntax off <BAR> else <BAR> syntax enable <BAR> endif<CR>
nnoremap <silent> <Leader>f :FZF<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

augroup vimrc
    autocmd!
    autocmd BufNewFile,BufRead *.pdc,*.pandoc setlocal filetype=markdown
    autocmd BufNewFile,BufRead Vagrantfile setlocal filetype=ruby
    autocmd FileType puppet setlocal tw=140
    autocmd FileType ruby,yaml setlocal sw=2
    autocmd FileType go setlocal noexpandtab sw=8 ts=8
augroup END
