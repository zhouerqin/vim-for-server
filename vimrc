" ============================================================================
" vim-for-server —— 专为生产服务器设计的 Vim 配置
"
" 零插件、单文件可逐行审计，断外网也能一条命令装好，
" 按 F1 查快捷键，半小时排障完就走人。
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
"   - <C-s> 在未执行 stty -ixon 的终端会触发流控冻结屏幕（按 <C-q> 解冻或执行 stty -ixon）
"   - 已启用 modeline（modelines=5），请勿用本配置编辑来源不明的文件
"   - F5 运行当前文件前会自动 :update（仅在有未保存修改时写盘）
"   - 打开 >1MB 的文件自动禁用 swap/undo 文件
" ============================================================================

" ====== 基础选项 ======
set nocompatible
set encoding=utf-8
set fileencoding=utf-8

filetype plugin indent on
syntax enable

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
" 配色原则：默认优先，只覆盖 Vim 自带配色在 256 色深色终端下确实不可读的部分。
" 语法高亮组（Keyword/String/Function 等）一律交还默认；Normal 也不覆盖，
" 背景色由终端决定，深浅色主题都能用。vimdiff 的 Diff 四色必须自定义——
" 默认配色在深色终端下增删改难以分辨（见设计原则第 4 条）。

" 搜索高亮：默认 reverse 在深色背景下常与文字混在一起
highlight Search         ctermfg=16  ctermbg=214 guifg=#000000 guibg=#ffaf00
highlight IncSearch      ctermfg=231 ctermbg=202 guifg=#ffffff guibg=#ff5f00

" 注释：默认灰暗，深色终端下接近不可见
highlight Comment        ctermfg=108 guifg=#608060

" 当前行 / 颜色列 / 错误：扫日志、对齐检查、错误定位的视觉锚点
highlight CursorLine     cterm=NONE  ctermbg=236 guibg=#2d2d2d
highlight ColorColumn    ctermbg=235 guibg=#333333
highlight Error          ctermfg=231 ctermbg=196 guifg=#ffffff guibg=#ff0000

" vimdiff：增/删/改/改中之改，深色终端下必须可分辨
highlight DiffAdd        ctermbg=22 guibg=#1d421d
highlight DiffDelete     ctermbg=52 guibg=#421d1d
highlight DiffChange     ctermbg=17 guibg=#1d2d4d
highlight DiffText       ctermbg=26 ctermfg=231 guibg=#3a5fcd guifg=#ffffff

" ====== 按键 ======

" F1 帮助 / F2 当前文件配置 / F3 特殊字符显示（缓冲区级）
nnoremap <silent> <F1> :call ShowHelp()<CR>
nnoremap <silent> <F2> :call ShowLangConfig()<CR>
nnoremap <silent> <F3> :setlocal list!<CR>:echo '特殊字符显示：' . (&l:list ? '开启' : '关闭')<CR>

" F5 运行当前文件；可视化模式运行选中代码
nnoremap <silent> <F5> :call RunScript()<CR>
vnoremap <silent> <F5> :call RunSelectedCode()<CR>

" 快速保存 / 退出（仅普通模式；终端流控风险见头部注意事项）
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>

" 文件开头 / 末尾跳转
nnoremap <Leader>G G
nnoremap <Leader>gg gg

" 复制当前行到下一行
nnoremap <Leader>y yyp

" 窗口分屏 / 切换
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>h :split<CR>
nnoremap <Leader>w <C-w>w

" 标签页
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>n :tabnext<CR>
nnoremap <Leader>p :tabprevious<CR>

" 格式化 / 清理行尾空格
nnoremap <Leader>f :FormatFile<CR>
nnoremap <Leader>ws :CleanTrailingWhitespace<CR>

" ====== 命令与函数 ======
command! CleanTrailingWhitespace :%s/\s\+$//e
command! FormatFile call FormatCurrentFile()
command! RunScript call RunScript()
command! VimHelp call ShowHelp()
command! LangConfig call ShowLangConfig()

function! FormatCurrentFile() abort
  let l:save = getpos('.')
  silent! %s/\s\+$//e
  call setpos('.', l:save)
  echo '清理行尾空格完成'
endfunction

" 可选执行器：inline_arg 为空表示不支持选中执行（如 go run 需要完整文件）
let s:runner_map = {
      \ 'sh':       {'cmd': 'bash',      'inline_arg': '-c'},
      \ 'bash':     {'cmd': 'bash',      'inline_arg': '-c'},
      \ 'python':   {'cmd': 'python3',   'inline_arg': '-c'},
      \ 'go':       {'cmd': 'go run',    'inline_arg': ''},
      \ 'javascript': {'cmd': 'node',    'inline_arg': '-e'},
      \ }

function! RunScript() abort
  let l:ft = &filetype
  if !has_key(s:runner_map, l:ft)
    echo '不支持的文件类型: ' . (l:ft == '' ? '(未识别)' : l:ft)
    return
  endif
  if !filereadable(expand('%'))
    echo '文件尚未保存到磁盘，无法运行'
    return
  endif
  " 运行的是磁盘上的内容，先同步未保存的修改，避免跑旧代码
  if &modified
    silent update
  endif
  let l:cmd = s:runner_map[l:ft].cmd . ' ' . shellescape(expand('%'))
  echo '执行: ' . l:cmd
  execute '!' . l:cmd
endfunction

function! RunSelectedCode() abort
  let l:ft = &filetype
  if !has_key(s:runner_map, l:ft)
    echo '不支持的文件类型: ' . (l:ft == '' ? '(未识别)' : l:ft)
    return
  endif
  let l:runner = s:runner_map[l:ft]
  if l:runner.inline_arg == ''
    echo '不支持对该文件类型执行选中代码，请使用 :RunScript 运行整个文件'
    return
  endif
  let l:selected = s:get_visual_selection()
  if empty(l:selected)
    echo '未选中任何代码'
    return
  endif
  let l:cmd = l:runner.cmd . ' ' . l:runner.inline_arg . ' ' . shellescape(l:selected)
  echo '执行选中代码...'
  execute '!' . l:cmd
endfunction

function! s:get_visual_selection() abort
  let [l:lnum1, l:col1] = getpos("'<")[1:2]
  let [l:lnum2, l:col2] = getpos("'>")[1:2]
  let l:lines = getline(l:lnum1, l:lnum2)
  if empty(l:lines)
    return ''
  endif
  let l:lines[-1] = l:lines[-1][: l:col2 - 1]
  let l:lines[0] = l:lines[0][l:col1 - 1:]
  return join(l:lines, "\n")
endfunction

function! ShowHelp() abort
  let l:help = [
    \ '',
    \ '═══════════════════════════════════════════════════════════',
    \ '              vim-for-server 帮助（零插件 · 单文件）',
    \ '═══════════════════════════════════════════════════════════',
    \ '',
    \ '【功能键】',
    \ '  <F1>              显示帮助（本界面）',
    \ '  <F2>              显示当前文件类型配置',
    \ '  <F3>              切换特殊字符显示（Tab→ 行尾空格·，仅当前缓冲区）',
    \ '  <F5>              运行当前文件（自动先保存）；可视化模式运行选中代码',
    \ '',
    \ '【快捷键 - 通用】',
    \ '  <C-s>             保存（终端需 stty -ixon，否则可能冻结屏幕）',
    \ '  <C-q>             退出',
    \ '',
    \ '【快捷键 - 移动】',
    \ '  <Leader>G         跳转到文件末尾',
    \ '  <Leader>gg        跳转到文件开头',
    \ '',
    \ '【快捷键 - 编辑】',
    \ '  <Leader>y         复制当前行到下一行',
    \ '  <Leader>f         格式化当前文件（清理行尾空格）',
    \ '  <Leader>ws        清理行尾空格',
    \ '',
    \ '【快捷键 - 窗口/标签】',
    \ '  <Leader>v / <Leader>h    垂直 / 水平分屏',
    \ '  <Leader>w         切换到上一个窗口',
    \ '  <Leader>t         新建标签页',
    \ '  <Leader>n / <Leader>p    下一个 / 上一个标签页',
    \ '',
    \ '【命令】',
    \ '  :RunScript        运行当前文件（同 F5）',
    \ '  :FormatFile       格式化当前文件',
    \ '  :CleanTrailingWhitespace  清理行尾空格',
    \ '  :LangConfig       显示当前文件配置（同 F2）',
    \ '  :VimHelp          显示帮助（同 F1）',
    \ '',
    \ '═══════════════════════════════════════════════════════════',
    \ ]
  for l:line in l:help
    echohl Title
    echo l:line
    echohl None
  endfor
endfunction

function! ShowLangConfig() abort
  let l:ft = &filetype
  if l:ft == ''
    echo '文件类型: 未识别'
    return
  endif
  let l:info = [
    \ '',
    \ '═══════════════════════════════════════════════════════════',
    \ '                    当前文件类型配置',
    \ '═══════════════════════════════════════════════════════════',
    \ '',
    \ '文件类型: ' . l:ft,
    \ 'Tab宽度: ' . &tabstop,
    \ '缩进宽度: ' . &shiftwidth,
    \ '软Tab宽度: ' . &softtabstop,
    \ '扩展Tab: ' . (&expandtab ? '是' : '否'),
    \ '行宽限制: ' . (&textwidth > 0 ? &textwidth : '无限制'),
    \ '颜色列: ' . (&colorcolumn != '' ? &colorcolumn : '无'),
    \ '注释前缀: ' . &commentstring,
    \ '',
    \ '═══════════════════════════════════════════════════════════',
    \ ]
  for l:line in l:info
    echohl Title
    echo l:line
    echohl None
  endfor
endfunction

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

  " Shell：排障主力，函数名/测试运算符参与关键词搜索
  autocmd FileType sh setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ textwidth=80 formatoptions-=t iskeyword+=@,-,_ commentstring=#\ %s
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth< formatoptions< iskeyword< commentstring<')

  " Python：PEP8 缩进，80 列颜色列提示
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
        \ textwidth=79 colorcolumn=80 commentstring=#\ %s
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth< colorcolumn< commentstring<')

  " YAML：k8s/CI 配置主力
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ textwidth=80 commentstring=#\ %s
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth< commentstring<')

  " JSON
  autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ textwidth=0 colorcolumn=0 commentstring=//\ %s
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth< colorcolumn< commentstring<')

  " Markdown：写变更单/排障记录
  autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ textwidth=0 commentstring=<!--\ %s\ -->
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth< commentstring<')

  " Nginx
  autocmd FileType nginx setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ textwidth=80 commentstring=#\ %s
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth< commentstring<')

  " Dockerfile
  autocmd FileType dockerfile setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ textwidth=80 commentstring=#\ %s
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth< commentstring<')

  " Go：gofmt 官方约定是 tab 缩进，用空格会被整个文件重排
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
        \ textwidth=80 colorcolumn=80 commentstring=//\ %s
        \ | call s:UndoAdd('setlocal expandtab< tabstop< shiftwidth< softtabstop< textwidth< colorcolumn< commentstring<')

  " Makefile：语法强制 recipe 行必须是 tab，空格会导致 make 直接报错
  autocmd FileType make setlocal noexpandtab
        \ | call s:UndoAdd('setlocal expandtab<')

  " SQL
  autocmd FileType sql setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ commentstring=--\ %s
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< commentstring<')

  " Terraform/HCL
  autocmd FileType hcl setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
        \ commentstring=#\ %s
        \ | call s:UndoAdd('setlocal tabstop< shiftwidth< softtabstop< expandtab< commentstring<')

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
