set spell
"autocmd BufWritePost * silent! !refer % | grap | pic | tbl | eqn  | troff -dpaper=a4 -ms  | grops -p a4 > %:r.ps
"autocmd BufWritePost * silent! !cat % | n-eqn | n-roff -ms -mtbl | n-post > %:r.ps
set tw=0
