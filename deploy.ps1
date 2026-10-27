# Cursor Plugins 源码复制安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/cursor/plugins#cursor-plugins
# 更新日期：2026-10-27
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

git clone --depth 1 https://github.com/cursor/plugins.git cursor-plugins-src
$dst = Join-Path $env:USERPROFILE '.cursor\plugins' ; New-Item -ItemType Directory -Force -Path $dst | Out-Null ; foreach ($p in @('thermos','teaching','advisor','orchestrate')) { Copy-Item -Recurse -Force (Join-Path 'cursor-plugins-src' $p) $dst }
Get-ChildItem $dst | Select-Object -ExpandProperty Name

Write-Host ''

Write-Host '部署完成：插件已复制到 ~/.cursor/plugins，重启 Cursor 后在 Plugins 面板启用'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/cursor/plugins#cursor-plugins'
