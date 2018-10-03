set spell

autocmd BufWritePost * silent! execute "!grap % | pic | tbl | eqn | troff -ms | grops > %:r.ps" | redraw!
