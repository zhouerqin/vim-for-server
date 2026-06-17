" ====== Python配置 ======

autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal textwidth=79
autocmd FileType python setlocal colorcolumn=80
autocmd FileType python setlocal commentstring=#\ %s
autocmd FileType python setlocal list

let python_highlight_all = 1
let python_highlight_space_errors = 1
highlight link pythonFunction Function
highlight link pythonOperator Operator
highlight link pythonString String
