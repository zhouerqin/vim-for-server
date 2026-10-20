# vim-for-server

> **专为生产服务器设计的 Vim 配置：零插件、单文件可逐行审计，断外网也能一条命令装好，按 F1 查快捷键，半小时排障完就走人。**

整个项目就是一个 [`vimrc`](vimrc)（约 400 行）。没有插件管理器、没有第三方依赖、没有网络请求——你可以用 10 分钟把它从头读到尾，再决定是否装到生产机上。

## 安装

会直接覆盖 `~/.vimrc`。已有配置请先备份：

```bash
[ -f ~/.vimrc ] && cp ~/.vimrc ~/.vimrc.bak.$(date +%Y%m%d)
curl -fsSL https://raw.githubusercontent.com/zhouerqin/vim-for-server/main/vimrc -o ~/.vimrc
```

断外网的机器：

```bash
scp vimrc <host>:~/.vimrc
```

从旧版本（`~/.vim` 目录布局）迁移：先确认 `~/.vim` 内没有个人文件，然后 `rm -rf ~/.vim`，再执行上面的安装命令。

## 快捷键

| 按键 | 功能 |
|------|------|
| `<F1>` | 显示帮助 |
| `<F2>` | 显示当前文件类型配置 |
| `<F3>` | 切换特殊字符显示（Tab→ 行尾空格·，仅当前缓冲区） |
| `<F5>` | 运行当前文件（自动先保存）；可视化模式运行选中代码 |
| `<C-s>` | 保存 |
| `<C-q>` | 退出 |
| `<Leader>G` / `<Leader>gg` | 跳转到文件末尾 / 开头 |
| `<Leader>y` | 复制当前行到下一行 |
| `<Leader>f` / `<Leader>ws` | 格式化 / 清理行尾空格 |
| `<Leader>v` / `<Leader>h` | 垂直 / 水平分屏 |
| `<Leader>w` | 切换到上一个窗口 |
| `<Leader>t` / `<Leader>n` / `<Leader>p` | 新建 / 下一个 / 上一个标签页 |

`<Leader>` 默认为 `\`。

## 命令

| 命令 | 功能 |
|------|------|
| `:RunScript` | 运行当前文件（同 F5），支持 sh/python/go/node |
| `:FormatFile` | 格式化当前文件 |
| `:CleanTrailingWhitespace` | 清理行尾空格 |
| `:LangConfig` | 显示当前文件配置（同 F2） |
| `:VimHelp` | 显示帮助（同 F1） |

## 支持的文件类型

| 类型 | Tab 宽 | 行宽 | 说明 |
|------|--------|------|------|
| Shell | 2 | 80 | 新文件自动 shebang；可 F5 运行 |
| Python | 4 | 79 | 80 列颜色列提示；新文件自动 shebang；可 F5 运行 |
| YAML | 2 | 80 | k8s/CI 配置 |
| JSON | 2 | - | |
| Markdown | 2 | - | 变更单/排障记录 |
| Nginx | 2 | 80 | 识别文件名含 nginx 的 `.conf` |
| Dockerfile | 2 | 80 | |
| Go | 2 | 80 | 80 列颜色列提示；可 F5 运行整个文件 |
| SQL | 2 | - | |
| Terraform/HCL | 2 | - | |
| 日志（`*.log`） | - | - | 自动关行号 |
| 大文件（>1MB） | - | - | 自动禁用 swap/undo 文件 |

## 注意事项

- **需要 256 色终端**（`TERM=xterm-256color` 等），不额外适配更老的终端。
- **`<C-s>` 流控**：未执行 `stty -ixon` 的终端里，`<C-s>` 会冻结屏幕（按 `<C-q>` 解冻）。建议在 `~/.bashrc` 中加 `stty -ixon`。
- **modeline 已启用**（`modelines=5`）：请勿用本配置编辑来源不明的文件。
- **`:RunScript` 运行的是磁盘内容**：有未保存修改时会自动先 `:update` 写盘。
- 高亮直接内嵌在 `vimrc` 中，没有独立的 colorscheme，`colorscheme server` 不可用。

## 设计原则

- **可审计优先**：单文件、无闭包魔法，每一行的效果都可以预判；出问题时你看得懂、改得动。
- **零网络行为**：安装后不产生任何网络请求、二进制下载或后台进程。
- **缓冲区级副作用**：文件类型设置通过 `b:undo_ftplugin` 正确撤销，`<F3>` 等开关只影响当前缓冲区，不污染全局。
