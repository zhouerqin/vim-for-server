" ====== YAML配置 ======

autocmd BufNewFile,BufRead *.yaml,*.yml set filetype=yaml

autocmd FileType yaml setlocal tabstop=2
autocmd FileType yaml setlocal shiftwidth=2
autocmd FileType yaml setlocal softtabstop=2
autocmd FileType yaml setlocal expandtab
autocmd FileType yaml setlocal textwidth=80
autocmd FileType yaml setlocal commentstring=#\ %s
autocmd FileType yaml set list
