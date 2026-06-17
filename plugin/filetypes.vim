" ====== 混合文件类型配置（启动时加载） ======
" 原本位于 ftplugin/mixed.vim，但 mixed 不是有效文件类型，
" 该文件不会被 Vim ftplugin 机制自动加载，
" 因此迁移至 plugin/ 目录，由 Vim 在启动时自动加载。

augroup FileTypeOverrides
  autocmd!

  " ----- 日志文件 -----
  autocmd BufRead,BufNewFile *.log,*.LOG set syntax=log
  autocmd BufRead,BufNewFile *.log,*.LOG setlocal nonumber

  " ----- 大文件优化（仅读取时触发） -----
  autocmd BufReadPre * if getfsize(expand("%")) > 1000000 | setlocal noswapfile nobackup noundofile shada= | endif

  " ----- XML配置 -----
  autocmd BufNewFile,BufRead *.xml set filetype=xml
  autocmd FileType xml setlocal tabstop=2
  autocmd FileType xml setlocal shiftwidth=2
  autocmd FileType xml setlocal softtabstop=2
  autocmd FileType xml setlocal noexpandtab

  " ----- HTML配置 -----
  autocmd BufNewFile,BufRead *.html,*.htm set filetype=html
  autocmd FileType html setlocal tabstop=2
  autocmd FileType html setlocal shiftwidth=2
  autocmd FileType html setlocal softtabstop=2
  autocmd FileType html setlocal expandtab

  " ----- JavaScript配置 -----
  autocmd BufNewFile,BufRead *.js,*.mjs set filetype=javascript
  autocmd FileType javascript setlocal tabstop=2
  autocmd FileType javascript setlocal shiftwidth=2
  autocmd FileType javascript setlocal softtabstop=2
  autocmd FileType javascript setlocal expandtab
  autocmd FileType javascript setlocal textwidth=80

  " ----- Windows批处理 -----
  autocmd FileType dosbatch setlocal noexpandtab
  autocmd FileType dosbatch setlocal tabstop=8

  " ----- PowerShell -----
  autocmd FileType ps1 setlocal expandtab
  autocmd FileType ps1 setlocal tabstop=2

  " ----- SQL -----
  autocmd BufNewFile,BufRead *.sql set filetype=sql
  autocmd FileType sql setlocal tabstop=2
  autocmd FileType sql setlocal shiftwidth=2
  autocmd FileType sql setlocal softtabstop=2
  autocmd FileType sql setlocal expandtab

  " ----- Terraform -----
  autocmd BufNewFile,BufRead *.tf,*.tfvars set filetype=hcl
  autocmd FileType hcl setlocal tabstop=2
  autocmd FileType hcl setlocal shiftwidth=2
  autocmd FileType hcl setlocal softtabstop=2
  autocmd FileType hcl setlocal expandtab

  " ----- YAML -----
  autocmd BufNewFile,BufRead *.yaml,*.yml set filetype=yaml

  " ----- Nginx -----
  autocmd BufNewFile,BufRead *.conf if expand('%') =~ 'nginx' | set filetype=nginx | endif

  " ----- Dockerfile -----
  autocmd BufNewFile,BufRead Dockerfile,*.dockerfile set filetype=dockerfile

  " ----- Tomcat日志 -----
  autocmd BufNewFile,BufRead *.log setlocal foldmethod=expr

  " ----- Go -----
  autocmd BufNewFile,BufRead *.go set filetype=go

  " ----- JSON -----
  autocmd BufNewFile,BufRead *.json set filetype=json

  " ----- Markdown -----
  autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown

  " ----- Shell -----
  autocmd BufNewFile,BufRead *.sh set filetype=sh
  autocmd BufNewFile *.sh call append(0, ['#!/bin/bash', '', ''])

  " ----- Python -----
  autocmd BufNewFile,BufRead *.py set filetype=python
  autocmd BufNewFile *.py call append(0, ['#!/usr/bin/env python3', '', ''])

augroup END
