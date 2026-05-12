" ====== 自动命令 ======

" 文件类型到执行命令的映射
let s:runner_map = {
      \ 'sh': {'cmd': 'bash', 'arg': ''},
      \ 'bash': {'cmd': 'bash', 'arg': ''},
      \ 'python': {'cmd': 'python3', 'arg': '-c'},
      \ 'ruby': {'cmd': 'ruby', 'arg': '-e'},
      \ 'lua': {'cmd': 'lua', 'arg': ''},
      \ 'javascript': {'cmd': 'node', 'arg': '-e'},
      \ 'go': {'cmd': 'go run', 'arg': ''},
      \ 'perl': {'cmd': 'perl', 'arg': '-e'}
      \ }

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
    if !has_key(s:runner_map, filetype)
        echo '不支持的文件类型: ' . filetype
        return
    endif
    let runner = s:runner_map[filetype]
    let cmd = runner.cmd . ' ' . shellescape(expand('%'))
    echo '执行: ' . cmd
    execute '!' . cmd
endfunction

function! RunSelectedCode()
    let filetype = &filetype
    let selected = s:get_visual_selection()
    if empty(selected) || !has_key(s:runner_map, filetype)
        if !has_key(s:runner_map, filetype)
            echo '不支持的文件类型: ' . filetype
        endif
        return
    endif
    let runner = s:runner_map[filetype]
    let cmd = runner.cmd
    if runner.arg != ''
        let cmd .= ' ' . runner.arg
    endif
    let cmd .= ' ' . shellescape(selected)
    echo '执行选中代码...'
    execute '!' . cmd
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
