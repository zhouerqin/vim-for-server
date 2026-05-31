" ====== 自动命令 ======

" 文件类型到执行命令的映射
let s:runner_map = {
      \ 'sh': {'cmd': 'bash', 'inline_arg': '-c'},
      \ 'bash': {'cmd': 'bash', 'inline_arg': '-c'},
      \ 'python': {'cmd': 'python3', 'inline_arg': '-c'},
      \ 'ruby': {'cmd': 'ruby', 'inline_arg': '-e'},
      \ 'lua': {'cmd': 'lua', 'inline_arg': '-e'},
      \ 'javascript': {'cmd': 'node', 'inline_arg': '-e'},
      \ 'go': {'cmd': 'go run', 'inline_arg': ''},
      \ 'perl': {'cmd': 'perl', 'inline_arg': '-e'}
      \ }

" 手动格式化命令
command! CleanTrailingWhitespace :%s/\s\+$//e
command! RetabAll :retab
command! FormatFile :call FormatCurrentFile()

function! FormatCurrentFile()
    let save_cursor = getpos('.')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    echo "清理行尾空格完成"
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
    if empty(selected)
        echo '未选中任何代码'
        return
    endif
    if !has_key(s:runner_map, filetype)
        echo '不支持的文件类型: ' . filetype
        return
    endif
    let runner = s:runner_map[filetype]
    if runner.inline_arg == ''
        echo '不支持对该文件类型执行选中代码，请使用 :RunScript 运行整个文件'
        return
    endif
    let cmd = runner.cmd . ' ' . runner.inline_arg . ' ' . shellescape(selected)
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
