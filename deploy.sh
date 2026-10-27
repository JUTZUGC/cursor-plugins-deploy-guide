#!/usr/bin/env bash
set -euo pipefail
# Cursor Plugins 源码复制安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/cursor/plugins#cursor-plugins
# 更新日期：2026-10-27
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }

mkdir -p .download
cd .download

git clone --depth 1 https://github.com/cursor/plugins.git cursor-plugins-src
mkdir -p "$HOME/.cursor/plugins" ; for p in thermos teaching advisor orchestrate; do cp -r "cursor-plugins-src/$p" "$HOME/.cursor/plugins/" ; done
ls "$HOME/.cursor/plugins"

echo ""

echo "部署完成：插件已复制到 ~/.cursor/plugins，重启 Cursor 后在 Plugins 面板启用"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/cursor/plugins#cursor-plugins"
