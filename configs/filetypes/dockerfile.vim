" ====== Dockerfile配置 ======

autocmd BufNewFile,BufRead Dockerfile,*.dockerfile set filetype=dockerfile

autocmd FileType dockerfile setlocal tabstop=2
autocmd FileType dockerfile setlocal shiftwidth=2
autocmd FileType dockerfile setlocal softtabstop=2
autocmd FileType dockerfile setlocal expandtab
autocmd FileType dockerfile setlocal textwidth=80
autocmd FileType dockerfile setlocal commentstring=#\ %s
