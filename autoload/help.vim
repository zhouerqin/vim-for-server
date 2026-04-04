" ====== 帮助系统 ======

function! ShowHelp()
  let help_text = [
    \ '',
    \ '═══════════════════════════════════════════════════════════',
    \ '                    Vim服务器配置帮助',
    \ '═══════════════════════════════════════════════════════════',
    \ '',
    \ '【功能键】',
    \ '  <F1>              显示帮助 (本界面)',
    \ '  <F2>              显示当前文件类型配置',
    \ '  <F3>              切换特殊字符显示 (Tab→ 行尾空格·)',
    \ '',
    \ '【快捷键 - 通用】',
    \ '  <Leader>w         保存文件',
    \ '  <Leader>q         退出Vim',
    \ '  <Esc>             清除搜索高亮',
    \ '',
    \ '【快捷键 - 光标移动】',
    \ '  <Leader>g         跳转到文件末尾',
    \ '  <Leader>gg        跳转到文件开头',
    \ '  <Leader>1/2/3     跳转到指定行 (1/50/100)',
    \ '',
    \ '【快捷键 - 编辑】',
    \ '  <Leader>y         复制当前行',
    \ '  <Leader>d         删除当前行',
    \ '  <Leader>f         格式化当前文件',
    \ '  <Leader>ws        清理行尾空格',
    \ '',
    \ '【快捷键 - 窗口/标签】',
    \ '  <Leader>v         垂直分屏',
    \ '  <Leader>h         水平分屏',
    \ '  <Leader>w         切换到上一个窗口',
    \ '  <Leader>t         新建标签页',
    \ '  <Leader>n/p       下一页/上一页(标签页)',
    \ '',
    \ '【命令行命令】',
    \ '  :FormatFile       格式化当前文件',
    \ '  :CleanTrailingWhitespace  清理行尾空格',
    \ '  :RetabAll         转换Tab为空格',
    \ '',
    \ '═══════════════════════════════════════════════════════════',
    \ ]
  for line in help_text
    echohl Title
    echo line
    echohl None
  endfor
endfunction

function! ShowLangConfig()
  let ft = &filetype
  if ft == ''
    echo '文件类型: 未识别'
    return
  endif

  let configs = [
    \ '',
    \ '═══════════════════════════════════════════════════════════',
    \ '                    当前文件类型配置',
    \ '═══════════════════════════════════════════════════════════',
    \ '',
    \ ]

  call extend(configs, [
    \ '文件类型: ' . ft,
    \ 'Tab宽度: ' . &tabstop,
    \ '缩进宽度: ' . &shiftwidth,
    \ '软Tab宽度: ' . &softtabstop,
    \ '扩展Tab: ' . (&expandtab ? '是' : '否'),
    \ '行宽限制: ' . (&textwidth > 0 ? &textwidth : '无限制'),
    \ '颜色列: ' . (&colorcolumn > 0 ? &colorcolumn : '无'),
    \ '注释前缀: ' . &commentstring,
    \ '',
    \ '═══════════════════════════════════════════════════════════',
    \ ])

  for line in configs
    echohl Title
    echo line
    echohl None
  endfor
endfunction

command! VimHelp call ShowHelp()
command! LangConfig call ShowLangConfig()
