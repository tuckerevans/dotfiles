set spell
"autocmd BufWritePost * silent! !refer % | grap | pic | tbl | eqn  | troff -dpaper=a4 -ms  | grops -p a4 > %:r.ps
"autocmd BufWritePost * silent! !cat % | n-eqn | n-roff -ms -mtbl | n-post > %:r.ps
set tw=0
set nowrap

set tabstop=8                   "A tab is 8 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=4               "Insert 4 spaces when tab is pressed
set shiftwidth=4                "An indent is 4 spaces
set shiftround                  "Round indent to nearest shiftwidth multiple
