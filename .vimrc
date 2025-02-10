" 显示行号
set number

" 高亮当前行
set cursorline

" 自动缩进
set autoindent

" 显示匹配的括号
set showmatch

" 搜索时忽略大小写
set ignorecase

" 搜索时高亮显示匹配结果
set hlsearch

" 设置tab为4个空格
set tabstop=4
set shiftwidth=4
set expandtab

" 显示命令输入
set showcmd

" 启用语法高亮
syntax on

" 设置编码为UTF-8
set encoding=utf-8

" 设置文件编码为UTF-8
set fileencoding=utf-8

" 设置文件格式为Unix
set fileformat=unix

" 设置备份文件目录
set backupdir=~/.vim/backup//

" 设置交换文件目录  
set directory=~/.vim/swap//

" 设置撤销文件目录
set undodir=~/.vim/undo//

" 启用撤销历史持久化
set undofile

" 设置历史记录长度
set history=1000

" 设置命令行高度
set cmdheight=2

" 设置鼠标支持
set mouse=a

" 设置粘贴模式
set paste

" 设置自动保存
set autowrite

" 设置自动读取外部修改
set autoread

" 设置文件类型检测
filetype on
filetype plugin on
filetype indent on

" 保存时自动删除行尾空格
autocmd BufWritePre *.sh,*.py,*.js,*.java,*.md,*.yml,*.yaml,*.json,*.txt :%s/\s\+$//e

autocmd FileType sh setlocal tabstop=2 shiftwidth=2
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType java setlocal tabstop=4 shiftwidth=4
autocmd FileType javascript setlocal tabstop=4 shiftwidth=4
autocmd FileType html setlocal tabstop=4 shiftwidth=4
autocmd FileType css setlocal tabstop=4 shiftwidth=4
autocmd FileType xml setlocal tabstop=4 shiftwidth=4
autocmd FileType php setlocal tabstop=4 shiftwidth=4
autocmd FileType markdown setlocal tabstop=2 shiftwidth=2
autocmd FileType yaml,yml setlocal tabstop=2 shiftwidth=2