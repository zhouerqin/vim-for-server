" ====== Shell脚本配置 ======

autocmd FileType sh setlocal tabstop=2
autocmd FileType sh setlocal shiftwidth=2
autocmd FileType sh setlocal softtabstop=2
autocmd FileType sh setlocal expandtab
autocmd FileType sh setlocal textwidth=80
autocmd FileType sh setlocal formatoptions-=t
autocmd FileType sh setlocal iskeyword+=@,-,_
autocmd FileType sh setlocal commentstring=#\ %s
autocmd FileType sh setlocal list

highlight link shShebang Comment
highlight link shFunction Function
highlight link shTestOpr Operator
