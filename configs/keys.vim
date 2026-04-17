" ====== 快捷键定义 ======

" F3 切换特殊字符显示
nnoremap <silent> <F3> :set list!<CR> :echo '特殊字符显示：' . (&list ? '开启' : '关闭')<CR>

" F1 显示帮助
nnoremap <silent> <F1> :call ShowHelp()<CR>

" F2 显示当前文件类型配置
nnoremap <silent> <F2> :call ShowLangConfig()<CR>

" F5 执行当前文件
nnoremap <silent> <F5> :call RunScript()<CR>
vnoremap <silent> <F5> :call RunSelectedCode()<CR>

" 快速保存
" inoremap <C-s> <Esc>:w<CR>a
nnoremap <C-s> :w<CR>

" 快速退出
" inoremap <C-q> <Esc>:q<CR>
nnoremap <C-q> :q<CR>

" 快速行跳转
nnoremap <Leader>G G
nnoremap <Leader>gg gg

" 快速切换书签
" nnoremap <Leader>1 :1<CR>
" nnoremap <Leader>2 :50<CR>
" nnoremap <Leader>3 :100<CR>

" 快速复制当前行
" nnoremap <Leader>y yyp

" 快速删除当前行
" nnoremap <Leader>d dd

" 窗口分屏快捷键
" nnoremap <Leader>v :vsplit<CR>
" nnoremap <Leader>h :split<CR>

" 快速切换到上一个窗口
" nnoremap <Leader>w <C-w>w

" 标签页操作
" nnoremap <Leader>t :tabnew<CR>
" nnoremap <Leader>n :tabnext<CR>
" nnoremap <Leader>p :tabprevious<CR>

" 格式化当前文件
" nnoremap <Leader>f :FormatFile<CR>

" 清理行尾空格
" nnoremap <Leader>ws :CleanTrailingWhitespace<CR>
