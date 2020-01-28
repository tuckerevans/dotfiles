set number relativenumber
syntax enable
set tabstop=8
set cursorline
"set lazyredraw
set incsearch
set hlsearch
set autoindent
set scrolloff=3
set spelllang=en
set spell
set tw=80
set ruler

set foldmethod=marker

set colorcolumn=70

set encoding=utf-8


set list
set listchars=eol:\ ,tab:\|\ ,trail:~,extends:>,precedes:<,space:·

map K i<enter><esc>
map W <esc>:WordCount<enter>

"colorscheme elflord
set t_Co=256
set background=light
"colorscheme firewatch
colorscheme PaperColor

au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.ldg set filetype=ledger
au BufRead,BufNewFile *.re set filetype=c

function LedgerSort()
	:%! ledger -f - print --sort 'date, amount'
	:%LedgerAlign
	:%s/^    /\t/g
endfunction
command LedgerSort call LedgerSort()

filetype plugin on
