" ====== Markdown配置 ======

autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown

autocmd FileType markdown setlocal tabstop=2
autocmd FileType markdown setlocal shiftwidth=2
autocmd FileType markdown setlocal softtabstop=2
autocmd FileType markdown setlocal expandtab
autocmd FileType markdown setlocal textwidth=0
autocmd FileType markdown setlocal commentstring=<!--\ %s\ -->
