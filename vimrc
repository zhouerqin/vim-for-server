" ====== 基础设置 ======
" 禁用兼容模式，启用现代Vim特性
set nocompatible
" 使用UTF-8编码
set encoding=utf-8
" 启用文件类型检测
filetype on
" 启用文件类型缩进
filetype indent on
" 启用文件类型插件
filetype plugin on
" 启用语法高亮
syntax enable
" 确保backspace能正常工作
set backspace=indent,eol,start
" 自动缩进
set autoindent
" 高亮匹配括号
set showmatch
" 设置单词分隔符，允许连字符(-)作为单词的一部分，便于补全带连字符的单词
set iskeyword+=@,-,_ 
" 特殊字符显示设置
" tab:→ 表示Tab显示为→+空格
" trail:· 表示行尾空格显示为·
" nbsp:␣  表示非断行空格显示为␣
set listchars=tab:→\ ,trail:·,nbsp:␣
" 提供便捷的开关命令：<F3>切换特殊字符显示
nnoremap <silent> <F3> :set list!<CR> :echo '特殊字符显示：' . (&list ? '开启' : '关闭')<CR>

" ====== 服务器端优化设置 ======
" 禁用鼠标（服务器端SSH连接不需要）
set mouse=
" 显示行号
set number
" 自动读取文件变化（适合查看日志）
set autoread

" ====== 配色与可读性增强 ======
" 设置终端颜色支持
set t_Co=256

" 当前行高亮（提升定位感）
set cursorline
highlight CursorLine cterm=NONE ctermbg=236 guibg=#2d2d2d

" 可视化选择区域（更醒目）
highlight Visual cterm=NONE ctermbg=239 ctermfg=NONE guibg=#4e4e4e

" 注释颜色 - 提高对比度（更亮的绿色）
highlight Comment ctermfg=150 guifg=#afd787

" 搜索高亮 - 更醒目但不刺眼
set hlsearch
highlight Search ctermbg=214 ctermfg=16 guibg=#ffaf00 guifg=#000000
highlight IncSearch ctermbg=202 ctermfg=231 guibg=#ff5f00 guifg=#ffffff

" 颜色列（Python 80列提示）
highlight ColorColumn ctermbg=238 guibg=#444444

" 字符串颜色 - 更清晰
highlight String ctermfg=180 guifg=#d4c49a

" 数字颜色
highlight Number ctermfg=167 guifg=#d75f5f

" 关键字颜色
highlight Keyword ctermfg=140 guifg=#af87d7

" 函数名颜色
highlight Function ctermfg=117 guifg=#87d7ff

" 类型/类名颜色
highlight Type ctermfg=167 guifg=#d75f5f

" 错误和警告
highlight Error ctermfg=231 ctermbg=196 guifg=#ffffff guibg=#ff0000
highlight WarningMsg ctermfg=214 guifg=#ffaf00

" 行号颜色
highlight LineNr ctermfg=244 guifg=#808080

" 匹配括号高亮
highlight MatchParen cterm=bold ctermbg=239 ctermfg=231 gui=bold guibg=#4e4e4e guifg=#ffffff

" ====== vimdiff 配色优化 ======
" 差异背景色（深色主题）
highlight DiffAdd ctermbg=22 ctermfg=NONE guibg=#1d421d guifg=NONE
highlight DiffDelete ctermbg=52 ctermfg=NONE guibg=#421d1d guifg=NONE
highlight DiffChange ctermbg=17 ctermfg=NONE guibg=#1d2d4d guifg=NONE
highlight DiffText ctermbg=26 ctermfg=231 guibg=#3a5fcd guifg=#ffffff

" 浅色主题适配
autocmd ColorScheme * if &background == 'light' | highlight Comment ctermfg=28 guifg=#008400 | endif
autocmd ColorScheme * if &background == 'light' | highlight Search ctermbg=226 ctermfg=16 guibg=#ffff00 guifg=#000000 | endif
autocmd ColorScheme * if &background == 'light' | highlight DiffAdd ctermbg=194 guibg=#d7ffd7 | endif
autocmd ColorScheme * if &background == 'light' | highlight DiffDelete ctermbg=224 guibg=#ffd7d7 | endif
autocmd ColorScheme * if &background == 'light' | highlight DiffChange ctermbg=189 guibg=#d7d7ff | endif
autocmd ColorScheme * if &background == 'light' | highlight DiffText ctermbg=153 guifg=16 guibg=#afd7ff guifg=#000000 | endif
" 搜索时忽略大小写
set ignorecase
" 智能大小写搜索
set smartcase
" 增量搜索
set incsearch
" 命令行补全
set wildmenu
set wildmode=longest:full,full
" 历史记录长度
set history=1000
" 隐藏缓冲区而不是关闭
set hidden
" 更快的更新时间
set updatetime=300
" 禁止显示模式切换消息
set noshowmode
" 滚动时保持光标居中
set scrolloff=8
set sidescrolloff=8
" 简化状态栏
set laststatus=2
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [LN=%l,COL=%v][%p%%]
" 命令行高度
set cmdheight=1
" 禁用折叠
set nofoldenable
" 禁用拼写检查
set nospell



" ====== 手动格式化命令 ======
" 手动删除行尾空格：:CleanTrailingWhitespace
command! CleanTrailingWhitespace :%s/\s\+$//e
" 手动转换Tab为空格：:RetabAll
command! RetabAll :retab
" 手动格式化当前文件：:FormatFile
command! FormatFile :call FormatCurrentFile()

" 格式化函数定义
function! FormatCurrentFile()
    " 保存当前位置
    let save_cursor = getpos('.')
    " 删除行尾空格
    silent! %s/\s\+$//e
    " 转换Tab为空格
    silent! retab
    " 恢复光标位置
    call setpos('.', save_cursor)
    echo "文件格式化完成"
endfunction

" ====== 选择性自动处理 ======
" 仅对特定文件类型启用自动处理（可选）
" autocmd FileType sh,yaml,json,xml,html,css,js,py BufWritePre <buffer> :%s/\s\+$//e
" autocmd FileType sh,yaml,json,xml,html,css,js,py BufWritePre <buffer> :retab

" ====== 日志查看增强 ======
" 当打开大文件时，优化性能
autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 1000000 | setlocal noswapfile nobackup noundofile shada= | endif
" 日志文件自动高亮
autocmd BufRead,BufNewFile *.log,*.LOG set syntax=log
" 日志文件禁用行号（处理超大日志文件时提高性能）
autocmd BufRead,BufNewFile *.log,*.LOG setlocal nonumber

" ====== Shell脚本配置 =====

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



" Shell文件中显示特殊字符
autocmd FileType sh set list

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

" ====== Python文件配置 =====

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



" Python文件中显示特殊字符
autocmd FileType python set list

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
