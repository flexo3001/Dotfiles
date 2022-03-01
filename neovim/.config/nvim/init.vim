call plug#begin('~/.config/nvim/plugins')
Plug 'cloudhead/neovim-fuzzy'
Plug 'mhinz/vim-signify'
Plug 'overcache/NeoSolarized'
Plug 'LnL7/vim-nix'
Plug 'neovimhaskell/haskell-vim'
call plug#end()

if ($TERM=~"xterm-256color" || $TERM=~"screen-256color")
    colorscheme NeoSolarized
    set background=light
    set termguicolors
endif

filetype plugin indent on

" https://github.com/cloudhead/neovim-fuzzy/issues/50
let g:fuzzy_rootcmds = [["git", "rev-parse", "--show-toplevel"]]

let g:markdown_fenced_languages = ['python', 'bash=sh', 'go', 'c', 'cpp', 'yaml', 'json', 'sql', 'haskell']

set autowrite
set expandtab
set ignorecase
set laststatus=2
set linebreak
set list listchars=tab:▸\ ,trail:·
set mouse=a
set nofoldenable
set nojoinspaces
set nowrap
set number
set printoptions=paper:A4,syntax:n,number:y
set shiftwidth=2
set showbreak=↪\
set splitbelow
set splitright
set statusline=\(%n\)\ %<%.99f\ %y\ %w%m%r%=%-14.(%l,%c%V%)\ %P
set textwidth=120
set wrapscan

let mapleader=" "
let maplocalleader=" "

map <silent> <C-i> <NOP>
map <silent> <C-o> :FuzzyOpen<CR>
map <silent> <C-_> :FuzzyGrep<CR>

nnoremap <silent> <esc><esc> :nohls<CR>

nnoremap <silent> gB :bp<CR>
nnoremap <silent> gb :bn<CR>

" https://github.com/neovim/neovim/pull/13268
if matchstr(execute('version'), 'NVIM v0.\zs[^\n]') > 5
  unmap Y
endif

function! s:StripTrailing()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

augroup vimrc
  autocmd!
  autocmd BufWritePre * call s:StripTrailing()
  autocmd BufNewFile,BufRead *.pdc,*.pandoc setlocal filetype=markdown
  autocmd FileType go setlocal noexpandtab sw=8
augroup END
