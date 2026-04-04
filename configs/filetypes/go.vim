" ====== Go配置 ======

autocmd BufNewFile,BufRead *.go set filetype=go

autocmd FileType go setlocal tabstop=2
autocmd FileType go setlocal shiftwidth=2
autocmd FileType go setlocal softtabstop=2
autocmd FileType go setlocal expandtab
autocmd FileType go setlocal textwidth=80
autocmd FileType go setlocal commentstring=//\ %s
autocmd FileType go setlocal colorcolumn=80
