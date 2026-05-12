" ====== JSON配置 ======

autocmd BufNewFile,BufRead *.json set filetype=json

autocmd FileType json setlocal tabstop=2
autocmd FileType json setlocal shiftwidth=2
autocmd FileType json setlocal softtabstop=2
autocmd FileType json setlocal expandtab
autocmd FileType json setlocal textwidth=0
autocmd FileType json setlocal colorcolumn=0
autocmd FileType json setlocal commentstring=//\ %s
