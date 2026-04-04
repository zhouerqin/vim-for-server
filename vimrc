" ====== Vim配置入口 ======
" 模块化设计 - 假设配置文件位于 ~/.vim/
" 使用相对路径.source

let $VIMRC_DIR = $HOME . '/vim-for-server'

source $VIMRC_DIR/configs/base.vim
source $VIMRC_DIR/configs/ui.vim
source $VIMRC_DIR/configs/keys.vim

source $VIMRC_DIR/configs/filetypes/sh.vim
source $VIMRC_DIR/configs/filetypes/python.vim
source $VIMRC_DIR/configs/filetypes/yaml.vim
source $VIMRC_DIR/configs/filetypes/dockerfile.vim
source $VIMRC_DIR/configs/filetypes/go.vim
source $VIMRC_DIR/configs/filetypes/json.vim
source $VIMRC_DIR/configs/filetypes/markdown.vim
source $VIMRC_DIR/configs/filetypes/nginx.vim
source $VIMRC_DIR/configs/filetypes/mixed.vim

source $VIMRC_DIR/autoload/auto.vim
source $VIMRC_DIR/autoload/help.vim
