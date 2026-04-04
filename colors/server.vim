" ====== Server Vim 配色方案 ======
" 专为服务器端设计的深色主题

hi clear
set background=dark
let g:colors_name = 'server'

" ----- 基本配色 -----
hi Normal guifg=#d4d4d4 guibg=#1e1e1e ctermfg=252 ctermbg=234

" ----- 背景层次 -----
hi CursorLine guibg=#2d2d2d ctermbg=236
hi ColorColumn guibg=#333333 ctermbg=235

" ----- 可视化选择 -----
hi Visual guibg=#4e4e4e ctermbg=239

" ----- 搜索高亮 -----
hi Search guifg=#000000 guibg=#ffaf00 ctermfg=16 ctermbg=214
hi IncSearch guifg=#ffffff guibg=#ff5f00 ctermfg=231 ctermbg=202

" ----- 匹配括号 -----
hi MatchParen guifg=#ffffff guibg=#4e4e4e gui=bold cterm=bold ctermfg=231 ctermbg=239

" ----- 注释 -----
hi Comment guifg=#608060 ctermfg=108

" ----- 字符串/常量 -----
hi String guifg=#d4c49a ctermfg=180
hi Number guifg=#d75f5f ctermfg=167
hi Boolean guifg=#d75f5f ctermfg=167
hi Constant guifg=#d75f5f ctermfg=167

" ----- 关键字/类型 -----
hi Keyword guifg=#af87d7 ctermfg=140
hi Type guifg=#af87d7 ctermfg=140
hi Structure guifg=#af87d7 ctermfg=140

" ----- 函数 -----
hi Function guifg=#87d7ff ctermfg=117

" ----- 操作符 -----
hi Operator guifg=#d4d4d4 ctermfg=252

" ----- 预定义 -----
hi PreProc guifg=#87d7ff ctermfg=117
hi Include guifg=#87d7ff ctermfg=117
hi Define guifg=#87d7ff ctermfg=117

" ----- 标题/标记 -----
hi Title guifg=#ffaf00 ctermfg=214
hi Label guifg=#d4c49a ctermfg=180

" ----- 错误/警告 -----
hi Error guifg=#ffffff guibg=#ff0000 ctermfg=231 ctermbg=196
hi WarningMsg guifg=#ffaf00 ctermfg=214
hi ErrorMsg guifg=#ff0000 ctermfg=196

" ----- 调试 -----
hi Debug guifg=#d75f5f ctermfg=167

" ----- 行号 -----
hi LineNr guifg=#666666 ctermfg=244
hi CursorLineNr guifg=#ffaf00 ctermfg=214

" ----- 状态栏 -----
hi StatusLine guifg=#fafafa guibg=#333333 ctermfg=250 ctermbg=238
hi StatusLineNC guifg=#f5f5f5 guibg=#262626 ctermfg=245 ctermbg=235

" ----- 折叠 -----
hi Folded guifg=#666666 guibg=#2d2d2d ctermfg=244 ctermbg=236
hi FoldColumn guifg=#666666 guibg=#1e1e1e ctermfg=244 ctermbg=234

" ----- 垂直分割线 -----
hi VertSplit guifg=#333333 guibg=#333333 ctermfg=238 ctermbg=238

" ----- 特殊字符 -----
hi Special guifg=#87d7ff ctermfg=117
hi SpecialKey guifg=#666666 ctermfg=244

" ----- 链接 -----
hi Underlined guifg=#87d7ff ctermfg=117 gui=underline cterm=underline
hi Ignore guifg=#666666 ctermfg=244
hi Todo guifg=#ffaf00 guibg=#333333 ctermfg=214 ctermbg=238
