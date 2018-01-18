set number
syntax enable
set tabstop=8
set cursorline
set lazyredraw
set incsearch
set hlsearch
set autoindent
set cindent
set scrolloff=3
set spelllang=en
"set spell
set tw=70
set ruler

set list
set listchars=eol:\ ,tab:\|\ ,trail:~,extends:>,precedes:<,space:·

map K i<enter><esc>

colorscheme default

au BufRead,BufNewFile *.go set filetype=go

call plug#begin('~/.vim/plugged')
Plug 'townk/vim-autoclose'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
"Plug 'fatih/vim-go'
"Plug 'larvag/vimtex'
"Plug 'rykka/riv.vim'
"Plug 'rykka/instantrst'
call plug#end()


