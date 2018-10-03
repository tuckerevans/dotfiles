set spell
autocmd BufWritePost * !pic % | tbl | eqn | troff -ms | grops > %:r.ps
