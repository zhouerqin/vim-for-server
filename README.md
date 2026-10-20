# vim-for-server

> **专为生产服务器设计的 Vim 配置：零插件、单文件可逐行审计，断外网也能一条命令装好，按 F1 查快捷键，半小时排障完就走人。**

整个项目就是一个 [`vimrc`](vimrc)（约 350 行）。没有插件管理器、没有第三方依赖、没有网络请求——你可以用 10 分钟把它从头读到尾，再决定是否装到生产机上。

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
| `<F5>` | 运行当前文件：可执行则直接运行（用其 shebang），否则按 shebang / 文件类型选解释器；可视化模式运行选中代码 |
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
| `:RunScript` | 运行当前文件（同 F5）：优先直接执行，其次 shebang，最后按 ft（sh/python/go/node） |
| `:FormatFile` | 格式化当前文件 |
| `:CleanTrailingWhitespace` | 清理行尾空格 |
| `:LangConfig` | 显示当前文件配置（同 F2） |
| `:VimHelp` | 显示帮助（同 F1） |

## 支持的文件类型

| 类型 | Tab 宽 | 行宽 | 说明 |
|------|--------|------|------|
| （全局默认） | 4 | - | `expandtab`，修正 Vim 默认 tab 宽 8/不转空格 |
| Shell | 2 | 80 | Google Shell Style Guide；新文件自动 shebang；可 F5 运行 |
| Python | 4 | 79 | PEP8；80 列颜色列提示；新文件自动 shebang；可 F5 运行 |
| YAML | 2 | 80 | 社区惯例；k8s/CI 配置 |
| JSON | 2 | - | 社区惯例 |
| Markdown | runtime | - | 交还 runtime（4 空格） |
| Nginx | 全局 | - | 社区无权威缩进规范，不强制 |
| Dockerfile | 全局 | - | 无权威规范 |
| Go | 4 | 80 | **tab 缩进**（gofmt 约定）；80 列颜色列提示；可 F5 运行整个文件 |
| Makefile | tab | - | runtime 保证 tab（语法强制，空格会报错） |
| SQL | 全局 | 80 | 注释前缀按方言由 runtime 处理 |
| Terraform/HCL | 2 | - | `terraform fmt` 默认 |

## 注意事项

- **需要 256 色终端**（`TERM=xterm-256color` 等），不额外适配更老的终端。
- **`<C-s>` 流控**：未执行 `stty -ixon` 的终端里，`<C-s>` 会冻结屏幕（按 `<C-q>` 解冻）。建议在 `~/.bashrc` 中加 `stty -ixon`。
- **modeline 已启用**（`modelines=5`）：请勿用本配置编辑来源不明的文件。
- **`:RunScript` / `<F5>` 运行的是磁盘内容**：有未保存修改时会自动先 `:update` 写盘。执行优先级：可执行文件直接运行（尊重其 shebang）→ 有 shebang 的文件按其解释器运行 → 按文件类型选解释器（sh/python/go/node）→ 都不满足则提示。
- 高亮直接内嵌在 `vimrc` 中，没有独立的 colorscheme，`colorscheme server` 不可用。

## 设计原则

1. **修正偏差，不堆砌配置**
   Vim 默认值停留在两个时代之前：编码规范出现之前（tab 宽 8、不转空格）和深色终端普及之前（搜索高亮、注释对比度差）。本配置的每一行都必须回答：你在修正默认值与现代规范或可读性的**什么偏差**？答不上来的行就不该存在。

2. **缩进跟主流规范走，runtime 冲突时以规范为准**
   全局默认 `expandtab` + 4 空格；各语言覆盖：Python 4（PEP8）、sh 2（Google Shell Style Guide）、yaml/json 2（社区惯例）、Go 用 tab（gofmt）、HCL 2（`terraform fmt`）。runtime 自带的 tab 宽 8 / 不转空格是几十年前的约定，与上述规范冲突时以社区规范为准。runtime 已给正确值的项（`commentstring`、make 的 `noexpandtab`）不重复定义，避免与官方 ftplugin 相互覆盖。

3. **配色默认优先，只修看不清的**
   能用 Vim 自带配色和终端调色板，就不自定义。取舍不靠猜测：每组都用 `vim --clean` + pty 渲染实测，只覆盖默认在 256 色深色终端下**确实不可读**的项。实测后仅剩两处覆盖——注释（默认暗蓝 cf=4，深色下不可见）与当前行（默认下划线在多数终端不可靠）。搜索默认亮黄底、vimdiff 默认马卡龙底色均清晰可分辨，全部交还默认；语法高亮组和 `Normal` 背景同样不覆盖，背景由终端决定，深浅色主题都能用。

4. **正常模式与 vimdiff 都必须开箱可读**
   这是两种实际使用形态，缺一不可。默认 vimdiff 配色（增=浅蓝/删=浅青/改=浅紫/改中之改=红底加粗）在深色终端下经实测可分辨，直接沿用；真实不合用时再覆盖，不做无依据的自定义。

5. **单文件可审计**
   零插件、零网络行为，10 分钟能从头读到尾，每一行效果可预判；出问题时你看得懂、改得动。

6. **副作用有边界**
   文件类型设置通过 `b:undo_ftplugin` 正确撤销；`<F3>` 等开关只作用于当前缓冲区，不污染全局。

7. **环境基线**
   256 色终端；不为更老的终端做适配；状态栏使用 Vim 默认（不自定义）。
