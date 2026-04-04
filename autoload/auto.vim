" ====== 自动命令 ======

" 手动格式化命令
command! CleanTrailingWhitespace :%s/\s\+$//e
command! RetabAll :retab
command! FormatFile :call FormatCurrentFile()

function! FormatCurrentFile()
    let save_cursor = getpos('.')
    silent! %s/\s\+$//e
    silent! retab
    call setpos('.', save_cursor)
    echo "文件格式化完成"
endfunction
