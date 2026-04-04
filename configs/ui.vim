" ====== UI/配色/状态栏 ======

" ----- 当前行高亮 -----
set cursorline
highlight CursorLine cterm=NONE ctermbg=236 guibg=#2d2d2d

" ----- 可视化选择 -----
highlight Visual cterm=NONE ctermbg=239 ctermfg=NONE guibg=#4e4e4e

" ----- 注释颜色 -----
highlight Comment ctermfg=150 guifg=#afd787

" ----- 搜索高亮 -----
highlight Search ctermbg=214 ctermfg=16 guibg=#ffaf00 guifg=#000000
highlight IncSearch ctermbg=202 ctermfg=231 guibg=#ff5f00 guifg=#ffffff

" ----- 颜色列 -----
highlight ColorColumn ctermbg=238 guibg=#444444

" ----- 语法高亮 -----
highlight String ctermfg=180 guifg=#d4c49a
highlight Number ctermfg=167 guifg=#d75f5f
highlight Keyword ctermfg=140 guifg=#af87d7
highlight Function ctermfg=117 guifg=#87d7ff
highlight Type ctermfg=167 guifg=#d75f5f
highlight Error ctermfg=231 ctermbg=196 guifg=#ffffff guibg=#ff0000
highlight WarningMsg ctermfg=214 guifg=#ffaf00
highlight LineNr ctermfg=244 guifg=#808080
highlight MatchParen cterm=bold ctermbg=239 ctermfg=231 gui=bold guibg=#4e4e4e guifg=#ffffff

" ----- vimdiff配色 -----
highlight DiffAdd ctermbg=22 ctermfg=NONE guibg=#1d421d guifg=NONE
highlight DiffDelete ctermbg=52 ctermfg=NONE guibg=#421d1d guifg=NONE
highlight DiffChange ctermbg=17 ctermfg=NONE guibg=#1d2d4d guifg=NONE
highlight DiffText ctermbg=26 ctermfg=231 guibg=#3a5fcd guifg=#ffffff

" ----- 浅色主题适配 -----
autocmd ColorScheme * if &background == 'light' | highlight Comment ctermfg=28 guifg=#008400 | endif
autocmd ColorScheme * if &background == 'light' | highlight Search ctermbg=226 ctermfg=16 guibg=#ffff00 guifg=#000000 | endif
autocmd ColorScheme * if &background == 'light' | highlight DiffAdd ctermbg=194 guibg=#d7ffd7 | endif
autocmd ColorScheme * if &background == 'light' | highlight DiffDelete ctermbg=224 guibg=#ffd7d7 | endif
autocmd ColorScheme * if &background == 'light' | highlight DiffChange ctermbg=189 guibg=#d7d7ff | endif
autocmd ColorScheme * if &background == 'light' | highlight DiffText ctermbg=153 guifg=16 guibg=#afd7ff | endif

" ----- 状态栏 -----
set laststatus=2

highlight StatusLine   cterm=NONE ctermbg=238 ctermfg=250
highlight StatusLineNC cterm=NONE ctermbg=235 ctermfg=245
highlight User1        cterm=bold ctermbg=245 ctermfg=232
highlight User2        cterm=NONE ctermbg=238 ctermfg=252
highlight User3        cterm=NONE ctermbg=236 ctermfg=248
highlight User4        cterm=bold ctermbg=242 ctermfg=232
highlight User5        cterm=NONE ctermbg=235 ctermfg=249

set statusline=
set statusline+=%1*\ %{ModeText()}\ %*
set statusline+=%2*%t
set statusline+=%{&modified?\"+\":\"\"}
set statusline+=%{&readonly?\"\":\"\"}
set statusline+=\ 
set statusline+=%=
set statusline+=%5*\ %{&filetype==\"\"?\"-\":&filetype}\ %*
set statusline+=%3*\ %l:%v\ %p%%\ %*

function! ModeText()
  let l:m = mode()
  return get({'n':'NORMAL','i':'INSERT','v':'VISUAL','V':'V-LINE','^V':'V-BLOCK','s':'SELECT','S':'S-LINE','R':'REPLACE','c':'COMMAND'}, l:m, toupper(l:m))
endfunction

augroup StatusMode
  autocmd!
  autocmd InsertEnter * highlight User1 cterm=bold ctermbg=252 ctermfg=232
  autocmd InsertLeave * highlight User1 cterm=bold ctermbg=245 ctermfg=232
augroup END
