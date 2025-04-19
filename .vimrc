" ====== 基础设置 ======
" 禁用兼容模式，启用现代Vim特性
set nocompatible
" 使用UTF-8编码
set encoding=utf-8
" 启用文件类型检测
filetype on
" 启用文件类型缩进
filetype indent on
" 启用语法高亮
syntax enable
" 确保backspace能正常工作
set backspace=indent,eol,start
" 自动缩进
set autoindent
" 高亮匹配括号
set showmatch
" 特殊字符显示设置
set listchars=tab:→\ ,trail:·
" ====== Shell脚本配置 ======
if executable('shfmt')
    autocmd FileType sh nnoremap <buffer> =G :%!shfmt -i 2 -ci -sr<CR>
    autocmd FileType sh vnoremap <buffer> = :'<,'>!shfmt -i 2 -ci -sr<CR>
    autocmd BufWritePre *.sh
        \ let b:shfmt_save = getline(1,'$') |
        \ let b:shfmt_result = system('shfmt -i 2 -ci -sr 2>&1', join(b:shfmt_save, "\n")) |
        \ if v:shell_error == 0 |
        \   silent %d _ |
        \   call setline(1, split(b:shfmt_result, "\n")) |
        \ else |
        \   echohl ErrorMsg |
        \   echomsg "shfmt 格式化失败: " . b:shfmt_result |
        \   echohl None |
        \ endif
endif

" Google Shell脚本规范要求：
" - 使用2空格缩进
" - 行宽限制80字符
" - 使用空格替代Tab
" - Shebang使用#!/bin/bash

" 设置.sh文件类型
autocmd BufNewFile,BufRead *.sh set filetype=sh

" Shell文件缩进和格式设置
autocmd FileType sh setlocal tabstop=2
autocmd FileType sh setlocal shiftwidth=2
autocmd FileType sh setlocal softtabstop=2
autocmd FileType sh setlocal expandtab
autocmd FileType sh setlocal textwidth=80
autocmd FileType sh setlocal formatoptions-=t
autocmd FileType sh setlocal iskeyword+=@,-,_
autocmd FileType sh setlocal commentstring=#\ %s

" 自动添加Shebang
autocmd BufNewFile *.sh call append(0, ['#!/bin/bash', ''])

" Shell文件快捷键映射
" F5执行当前脚本
if !hasmapto('<F5>', 'n')
    autocmd FileType sh nnoremap <buffer> <F5> :w<CR>:!bash %<CR>
endif

" ====== 通用格式规范 ======
" 自动缩进
set autoindent
" 高亮匹配括号
set showmatch
" 特殊字符显示设置
set listchars=tab:→\ ,trail:·
" Shell文件中显示特殊字符
autocmd FileType sh set list

" 保存时自动格式化
" 删除行尾空格
autocmd BufWritePre *.sh :%s/\s\+$//e
" 转换Tab为空格
autocmd BufWritePre *.sh :retab

" ====== 语法高亮增强 ======
" Shell脚本特殊语法高亮
highlight link shShebang Comment
highlight link shFunction Function
highlight link shTestOpr Operator

" ====== 其他语言兼容 ======
" Windows批处理文件设置
" 保留Tab字符，8空格宽度
autocmd FileType dosbatch setlocal noexpandtab
autocmd FileType dosbatch setlocal tabstop=8

" PowerShell脚本设置
" 使用空格缩进，2空格宽度
autocmd FileType ps1 setlocal expandtab
autocmd FileType ps1 setlocal tabstop=2

" ====== YAML文件配置 ======
" 设置.yaml文件类型
autocmd BufNewFile,BufRead *.yaml,*.yml set filetype=yaml

" YAML文件缩进和格式设置
autocmd FileType yaml setlocal tabstop=2
autocmd FileType yaml setlocal shiftwidth=2
autocmd FileType yaml setlocal softtabstop=2
autocmd FileType yaml setlocal expandtab
autocmd FileType yaml setlocal textwidth=80
autocmd FileType yaml setlocal commentstring=#\ %s

" YAML文件中显示特殊字符
autocmd FileType yaml set list

" 保存时自动格式化
" 删除行尾空格
autocmd BufWritePre *.yaml,*.yml :%s/\s\+$//e
" 转换Tab为空格
autocmd BufWritePre *.yaml,*.yml :retab

" ====== Python文件配置 ======
" 检查并设置black格式化
if executable('black')
    autocmd FileType python nnoremap <buffer> =G :%!black --quiet -<CR>
    autocmd FileType python vnoremap <buffer> = :!black --quiet -<CR>
    autocmd BufWritePre *.py :%!black --quiet -
endif

" 设置.py文件类型
autocmd BufNewFile,BufRead *.py set filetype=python

" Python文件缩进和格式设置 (PEP8标准)
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal textwidth=79
autocmd FileType python setlocal colorcolumn=80
autocmd FileType python setlocal commentstring=#\ %s

" 自动添加Shebang
autocmd BufNewFile *.py call append(0, ['#!/usr/bin/env python3', '', ''])

" Python文件快捷键映射
" F5执行当前脚本
if !hasmapto('<F5>', 'n')
    autocmd FileType python nnoremap <buffer> <F5> :w<CR>:!python3 %<CR>
endif

" Python文件中显示特殊字符
autocmd FileType python set list

" 保存时自动格式化
" 删除行尾空格
autocmd BufWritePre *.py :%s/\s\+$//e
" 转换Tab为空格
autocmd BufWritePre *.py :retab

" ====== Python语法高亮增强 ======
let python_highlight_all = 1
let python_highlight_space_errors = 1
highlight link pythonFunction Function
highlight link pythonOperator Operator
highlight link pythonString String

" ====== Dockerfile配置 ======
" 设置Dockerfile文件类型
autocmd BufNewFile,BufRead Dockerfile,*.dockerfile set filetype=dockerfile

" Dockerfile缩进和格式设置
autocmd FileType dockerfile setlocal tabstop=2
autocmd FileType dockerfile setlocal shiftwidth=2
autocmd FileType dockerfile setlocal softtabstop=2
autocmd FileType dockerfile setlocal expandtab
autocmd FileType dockerfile setlocal textwidth=80
autocmd FileType dockerfile setlocal commentstring=#\ %s
