set number relativenumber
filetype plugin on
syntax enable
set tabstop=8
set cursorline
set lazyredraw
set incsearch
set hlsearch
set autoindent
set scrolloff=3
set spelllang=en
set spell
set tw=70
set ruler

set foldmethod=marker

set list
set listchars=eol:\ ,tab:\|\ ,trail:~,extends:>,precedes:<,space:·

map K i<enter><esc>
map W <esc>:WordCount<enter>

colorscheme elflord


au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.ldg set filetype=ledger

function LedgerSort()
	:%! ledger -f - print --sort 'date, amount'
	:%LedgerAlign
	:%s/^    /\t/g
endfunction
command LedgerSort call LedgerSort()

filetype plugin on
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

