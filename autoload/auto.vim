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

function! RunScript()
    let filetype = &filetype
    let cmd = ''
    
    if filetype == 'sh' || filetype == 'bash'
        let cmd = 'bash ' . shellescape(expand('%'))
    elseif filetype == 'python'
        let cmd = 'python3 ' . shellescape(expand('%'))
    elseif filetype == 'ruby'
        let cmd = 'ruby ' . shellescape(expand('%'))
    elseif filetype == 'lua'
        let cmd = 'lua ' . shellescape(expand('%'))
    elseif filetype == 'javascript'
        let cmd = 'node ' . shellescape(expand('%'))
    elseif filetype == 'go'
        let cmd = 'go run ' . shellescape(expand('%'))
    elseif filetype == 'perl'
        let cmd = 'perl ' . shellescape(expand('%'))
    else
        echo '不支持的文件类型: ' . filetype
        return
    endif
    
    if cmd != ''
        echo '执行: ' . cmd
        execute '!' . cmd
    endif
endfunction

function! RunSelectedCode()
    let filetype = &filetype
    let selected = s:get_visual_selection()
    
    if empty(selected)
        return
    endif
    
    let cmd = ''
    
    if filetype == 'python'
        let cmd = 'python3 -c ' . shellescape(selected)
    elseif filetype == 'javascript'
        let cmd = 'node -e ' . shellescape(selected)
    elseif filetype == 'sh' || filetype == 'bash'
        let cmd = 'bash -c ' . shellescape(selected)
    elseif filetype == 'ruby'
        let cmd = 'ruby -e ' . shellescape(selected)
    elseif filetype == 'perl'
        let cmd = 'perl -e ' . shellescape(selected)
    else
        echo '不支持的文件类型: ' . filetype
        return
    endif
    
    if cmd != ''
        echo '执行选中代码...'
        execute '!' . cmd
    endif
endfunction

function! s:get_visual_selection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    if empty(lines)
        return ''
    endif
    let lines[-1] = lines[-1][: col2 - 1]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction
