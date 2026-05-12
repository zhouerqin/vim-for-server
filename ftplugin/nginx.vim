" ====== Nginx配置 ======

autocmd BufNewFile,BufRead *.conf if expand('%') =~ 'nginx' | set filetype=nginx | endif

autocmd FileType nginx setlocal tabstop=2
autocmd FileType nginx setlocal shiftwidth=2
autocmd FileType nginx setlocal softtabstop=2
autocmd FileType nginx setlocal expandtab
autocmd FileType nginx setlocal textwidth=80
autocmd FileType nginx setlocal commentstring=#\ %s
