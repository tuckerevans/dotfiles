set spell
autocmd BufWritePost * silent! !grap % | pic | tbl | eqn | troff -ms | grops > %:r.ps
