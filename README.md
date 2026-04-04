# Vim服务器配置

## 特性亮点

✨ **零插件设计** - 仅用Vim原生功能实现高效编辑  
✨ **模块化架构** - 配置拆分，易于维护和扩展  
✨ **多语言支持** - Shell/Python/YAML/Dockerfile/Go/JSON/Markdown/Nginx等  
✨ **内置帮助系统** - `F1`查看快捷键，`F2`查看当前文件配置  
✨ **专属配色方案** - 深色主题 `colors/server.vim`  
✨ **特殊字符可视化** - `F3`切换Tab→、行尾空格·显示  
✨ **服务器端优化** - 禁用鼠标、自动读取文件变化、大文件处理

## 快速开始

### Linux/macOS

```bash
cd ~
git clone git@github.com:zhouerqin/vim-for-server.git
ln -s ~/vim-for-server/vimrc ~/.vimrc
```

### Windows

```powershell
git clone git@github.com:zhouerqin/vim-for-server.git $env:USERPROFILE\vim-for-server
Copy-Item $env:USERPROFILE\vim-for-server\vimrc $env:USERPROFILE\vimfiles\vimrc
```

## 项目结构

```
vim-for-server/
├── vimrc                    # 主入口
├── configs/
│   ├── base.vim            # 基础设置
│   ├── ui.vim              # 配色/状态栏
│   ├── keys.vim            # 快捷键
│   └── filetypes/          # 语言配置
│       ├── sh.vim
│       ├── python.vim
│       ├── yaml.vim
│       ├── dockerfile.vim
│       ├── go.vim
│       ├── json.vim
│       ├── markdown.vim
│       ├── nginx.vim
│       └── mixed.vim
├── autoload/
│   ├── auto.vim            # 自动命令
│   └── help.vim            # 帮助系统
└── colors/
    └── server.vim          # 专属配色
```

## 快捷键

| 按键 | 功能 |
|------|------|
| `<F1>` | 显示帮助 |
| `<F2>` | 显示当前文件配置 |
| `<F3>` | 切换特殊字符显示 |
| `<Leader>w` | 保存文件 |
| `<Leader>q` | 退出 |
| `<Leader>g` | 跳转到文件末尾 |
| `<Leader>gg` | 跳转到文件开头 |
| `<Leader>f` | 格式化当前文件 |
| `<Leader>ws` | 清理行尾空格 |

## 支持的语言

| 语言 | Tab宽 | 行宽 | 特性 |
|------|--------|------|------|
| Shell | 2 | 80 | 自动Shebang |
| Python | 4 | 79 | ColorColumn提示 |
| YAML | 2 | 80 | - |
| Dockerfile | 2 | 80 | - |
| Go | 2 | 80 | ColorColumn提示 |
| JSON | 2 | - | - |
| Markdown | 2 | - | - |
| Nginx | 2 | 80 | - |
| XML/HTML | 2 | - | - |
| JavaScript | 2 | 80 | - |
| SQL | 2 | - | - |
| Terraform | 2 | - | - |
| PowerShell | 2 | - | - |

## 命令行命令

- `:FormatFile` - 格式化当前文件
- `:CleanTrailingWhitespace` - 清理行尾空格
- `:RetabAll` - 转换Tab为空格
- `:VimHelp` - 显示帮助（同F1）
- `:LangConfig` - 显示文件配置（同F2）

## 使用配色方案

```vim
:colorscheme server
```

或在 `vimrc` 中添加：

```vim
colorscheme server
```
