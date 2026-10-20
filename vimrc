" ============================================================================
" vim-for-server —— 专为生产服务器设计的 Vim 配置
"
" 零插件、单文件可逐行审计，断外网也能一条命令装好，
" 只用 Vim 默认命令与键位，半小时排障完就走人。
"
" 安装（会直接覆盖 ~/.vimrc，已有配置请先备份）：
"   curl -fsSL https://raw.githubusercontent.com/zhouerqin/vim-for-server/main/vimrc -o ~/.vimrc
" 保守安装（先备份）：
"   [ -f ~/.vimrc ] && cp ~/.vimrc ~/.vimrc.bak.$(date +%Y%m%d)
"   curl -fsSL https://raw.githubusercontent.com/zhouerqin/vim-for-server/main/vimrc -o ~/.vimrc
" 断外网机器：
"   scp vimrc <host>:~/.vimrc
" 旧版本（~/.vim 目录布局）迁移：
"   确认 ~/.vim 内无个人文件后 rm -rf ~/.vim，再执行上面的 curl
"
" 注意事项：
"   - 需要 256 色终端（TERM=xterm-256color / screen-256color 等），不额外适配更老的终端
"   - 已启用 modeline（modelines=5），请勿用本配置编辑来源不明的文件
"   - 打开 >1MB 的文件自动禁用 swap/undo 文件
" ============================================================================

" ====== 基础选项 ======
set nocompatible

" encoding 不需要设：Vim 默认即 utf-8。fileencoding 也不设——留空表示与
" encoding 相同、读写不转码，文件编码交给 fileencodings 自动检测
" （默认 ucs-bom,utf-8,default,latin1）。硬设 fileencoding=utf-8 会强制转码，
" 并让缓冲区在打开时即被标记 modified（见 :help 'fileencoding'）。

filetype plugin indent on
syntax enable

" 注意：本文件本身就是 vimrc，Vim 自带的 defaults.vim 不会加载，因此 Vim 的
" "好用默认值"（showmatch、backspace 等）在这里并不生效，需显式设置。
set backspace=indent,eol,start
set autoindent
set showmatch

" 全局缩进默认值：修正 Vim 默认 tab 宽 8、不转空格（编码规范出现之前的产物）
" 各语言在下方 FileType 段按主流规范覆盖；语法强制 tab 的场景（Go/Makefile）显式保护
set expandtab
set tabstop=4
set shiftwidth=4

set listchars=tab:→\ ,trail:·,nbsp:␣

set ignorecase
set smartcase
set incsearch
set hlsearch

set wildmenu
set wildmode=longest:full,full
set history=1000
set hidden
set updatetime=300
set scrolloff=8
set sidescrolloff=8
set cmdheight=1

set nofoldenable
set number
set autoread
set mouse=

" 排障时编辑不可信文件（如下载的日志）存在 modeline 风险，见头部注意事项
set modeline
set modelines=5

" ====== 高亮 ======
" 配色原则：默认优先。每组都用实测数据裁决（`vim --clean` + pty 渲染），只覆盖
" 默认在 256 色深色终端下确实不可读的项。实测结论：Vim 9 的搜索默认亮黄底、
" Diff 四色默认马卡龙底色，均清晰可分辨——全部交还默认（见设计原则第 3/4 条）。

" 注释：默认 ctermfg=4（暗蓝），深色终端下接近不可见
highlight Comment    ctermfg=108 guifg=#608060

" 当前行：默认下划线在多数终端不可靠，改用低亮背景
highlight CursorLine cterm=NONE ctermbg=236 guibg=#2d2d2d

" ====== 文件类型设置 ======
" 单文件模式下无法使用 ftplugin/ 目录，统一用 FileType autocmd 实现。
" 每个 autocmd 必须同步追加 b:undo_ftplugin，否则同一缓冲区切换文件类型时
" 设置会残留（已实测验证）。

" 追加 b:undo_ftplugin（runtime 的 ftplugin 也会设置该变量，必须追加而非覆盖）
function! s:UndoAdd(cmd) abort
  let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin . ' | ' : '') . a:cmd
endfunction

augroup FiletypeSettings
  autocmd!
  " 规则：runtime 已给正确值的选项不重复定义（commentstring 等），只补充/覆盖
  " 与社区实践冲突的部分。runtime 的 tab=8/不转空格是几十年前的约定，一律以
  " 各语言社区规范为准（见下方逐条）。为统一口径，缩进选项总是显式设定，
  " 不依赖 runtime 的既有值，便于审计。

  " Shell：Google Shell Style Guide 用 2 空格；iskeyword 追加是我的个人偏好
  " （排障时便于按名字搜函数/测试运算符），非规范要求，不认同可删
  autocmd FileType sh setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ textwidth=80 formatoptions-=t iskeyword+=@,-,_
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth< formatoptions< iskeyword<')

  " Python：PEP8 = 4 空格 + 79 列，80 列处给颜色列提示
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
        \ textwidth=79 colorcolumn=80
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth< colorcolumn<')

  " YAML：社区惯例 2 空格（k8s/CI 配置主力）；runtime 漏设 ts，一并补上
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ textwidth=80
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth<')

  " JSON：社区惯例 2 空格；注释前缀交还 runtime（JSON 标准无注释，runtime 设为空）
  autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ textwidth=0
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth<')

  " Markdown：不参与代码缩进，交还 runtime 的 4 空格；长段落不自动折行
  autocmd FileType markdown setlocal textwidth=0
        \ | call s:UndoAdd('setlocal textwidth<')

  " Nginx：社区无权威缩进规范，沿用主机全局偏好，不强制覆盖；不设行宽
  autocmd FileType nginx setlocal textwidth=0
        \ | call s:UndoAdd('setlocal textwidth<')

  " Dockerfile：社区惯例 4 空格、不折行
  autocmd FileType dockerfile setlocal textwidth=0
        \ | call s:UndoAdd('setlocal textwidth<')

  " Go：gofmt 强制 tab 缩进，用空格会被整个文件重排
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
        \ textwidth=80 colorcolumn=80
        \ | call s:UndoAdd('setlocal expandtab< tabstop< shiftwidth< softtabstop< textwidth< colorcolumn<')

  " Makefile：runtime 已保证 noexpandtab（recipe 行必须是 tab，空格会报错），不重复定义

  " SQL：缩进交还主机全局；注释前缀由 runtime 按方言处理（默认 /* */）
  autocmd FileType sql setlocal textwidth=80
        \ | call s:UndoAdd('setlocal textwidth<')

  " Terraform/HCL：官方 fmt 用 2 空格（terraform fmt 默认）；注释前缀交还 runtime
  autocmd FileType hcl setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab<')

  " 兼容旧版 Vim：补足原生检测（新版 Vim 已内置这些规则）
  autocmd BufNewFile,BufRead Dockerfile,*.dockerfile set filetype=dockerfile
  autocmd BufNewFile,BufRead *.tf,*.tfvars set filetype=hcl
  autocmd BufNewFile,BufRead *.conf if expand('%:t') =~? 'nginx' || expand('%:p') =~? '/nginx/' | set filetype=nginx | endif

  " 新文件自动 shebang（setline 覆盖初始空行，避免多余空行）
  autocmd BufNewFile *.sh call setline(1, '#!/bin/bash') | call append(1, '')
  autocmd BufNewFile *.py call setline(1, '#!/usr/bin/env python3') | call append(1, '')

augroup END

" ====== 服务器场景 ======
augroup ServerSpecial
  autocmd!

  " 日志文件：关行号，减少排障时的视觉噪音
  autocmd BufRead,BufNewFile *.log setlocal nonumber

  " 大文件（>1MB）：禁用 swap/undo 文件，防止卡顿和磁盘占用
  " 只用 buffer-local 选项，避免影响本会话其他缓冲区
  autocmd BufReadPre * if getfsize(expand('%')) > 1000000 | setlocal noswapfile noundofile | endif
augroup END
