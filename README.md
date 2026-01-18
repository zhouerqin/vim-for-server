# 无插件Vim配置

## 特性亮点

✨ **零插件设计** - 仅用Vim原生功能实现高效编辑  
✨ 内置Shell/Python/YAML/Dockerfile/PowerShell等语言支持  
✨ 提供手动格式化命令（清理行尾空格、转换Tab为空格）  
✨ 特殊字符可视化（Tab、行尾空格、非断行空格）  
✨ 统一编码规范（UTF-8 + 空格缩进）  
✨ 服务器端优化设置（禁用鼠标、自动读取文件变化）  
✨ 增强的语法高亮和颜色配置  
✨ 简化的状态栏设计  
✨ 便捷的快捷键（F3切换特殊字符显示）

## 快速开始

### Linux/macOS
```bash
cd ~
git clone https://github.com/zhouerqin/vim-for-server.git
ln -s ~/vim-for-server/.vimrc ~/.vimrc
```

### Windows
```powershell
# 克隆仓库到用户目录
git clone https://github.com/zhouerqin/vim-for-server.git $env:USERPROFILE\vim-for-server
# 创建符号链接或直接复制文件到vimfiles目录
# 方法1：创建符号链接（需要管理员权限）
New-Item -ItemType SymbolicLink -Path $env:USERPROFILE\vimfiles\vimrc -Target $env:USERPROFILE\vim-for-server\.vimrc
# 方法2：直接复制文件
Copy-Item $env:USERPROFILE\vim-for-server\.vimrc $env:USERPROFILE\vimfiles\vimrc
```
