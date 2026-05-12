" ====== Vim配置入口 ======
" 模块化设计 - 假设配置文件位于 ~/.vim/
" 使用相对路径.source

" 尝试多种方式获取配置目录
if exists('$VIMRC_DIR')
  let s:vimrc_dir = $VIMRC_DIR
else
  " 先尝试标准位置 ~/.vim
  let s:vimrc_dir = $HOME . '/.vim'
  if !isdirectory(s:vimrc_dir . '/configs')
    " 如果不存在，尝试当前脚本所在目录（使用 <sfile>）
    let s:script_path = expand('&lt;sfile&gt;')
    if s:script_path != ''
      let s:vimrc_dir = fnamemodify(s:script_path, ':h')
    endif
  endif
endif

execute 'source ' . s:vimrc_dir . '/configs/base.vim'
execute 'source ' . s:vimrc_dir . '/configs/ui.vim'
execute 'source ' . s:vimrc_dir . '/configs/keys.vim'

execute 'source ' . s:vimrc_dir . '/autoload/auto.vim'
execute 'source ' . s:vimrc_dir . '/autoload/help.vim'
