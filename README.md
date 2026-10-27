# Cursor Plugins 源码复制安装指南

> 第三方部署指南 · 非 Cursor Plugins 官方仓库。官方项目：[cursor/plugins](https://github.com/cursor/plugins)
> 内容来自官方文档（2026-10-27）。项目迭代快，请以[官方文档](https://github.com/cursor/plugins#cursor-plugins)为准。

[![⚡ 源码复制安装](https://img.shields.io/badge/%E2%9A%A1_%E6%BA%90%E7%A0%81%E5%A4%8D%E5%88%B6%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#源码复制安装推荐用百度搭子)

## 源码复制安装（推荐：用百度搭子）

> [!TIP]
> 不想一个个找 Cursor 插件，让百度搭子把官方市场仓库拉下来，挑几个装进本地插件目录。

⚠️ 仓库是插件市场源码集合，不是一键安装器。每个插件是独立目录，需要按需复制；部分第三方插件（Gmail、Salesforce、Stripe 等）还要额外做 OAuth 授权。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/cursor-plugins-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子克隆插件市场仓库，把需要的插件目录复制到 Cursor 的插件目录，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## Cursor Plugins 是什么？

Cursor Plugins 是开源的14.2k stars，MIT，Cursor 维护的插件市场仓库，内含 60+ 个官方与第三方插件（协议：MIT，<img src="https://img.shields.io/github/stars/cursor/plugins?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

Cursor 的插件市场仓库：根目录 `.cursor-plugin/marketplace.json` 列出全部插件，每个插件自带 `.cursor-plugin/plugin.json`、skills、rules 和 mcp.json。

- 14.2k stars：Cursor 维护，插件质量有基本保证
- 60+ 插件：开发工具、生产力、SaaS 集成三大类
- 结构统一：每个插件都有 manifest，便于脚本化安装
- 含 MCP 定义：第三方服务插件自带 mcp.json
- MIT：可以直接改、内部复用
- 持续更新：新插件跟进主流 SaaS

（来源：[官方仓库](https://github.com/cursor/plugins)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 14.2k stars | Cursor 维护，目录结构规范 |
| 插件数量多 | 开发、效率、SaaS 集成都有 |
| 结构统一 | 可以用脚本批量复制 |
| 自带 MCP 定义 | 第三方服务接入不用手写配置 |
| MIT | 可改可分发 |

| 需要注意 | 说明 |
|---|---|
| 没有安装器 | 要自己克隆并复制目录 |
| 质量不均 | 官方插件和第三方插件差异大 |
| 多数要授权 | SaaS 类插件必须走 OAuth |
| 依赖 Cursor | 换编辑器基本用不上 |
| 插件更新要手动 | 克隆下来的副本不会自动同步 |

> 以上基于官方文档与社区反馈整理（2026-10-27），以官方最新文档为准。

## 快速部署（官方方式）

```bash
git clone --depth 1 https://github.com/cursor/plugins.git cursor-plugins-src
mkdir -p "$HOME/.cursor/plugins" ; for p in thermos teaching advisor orchestrate; do cp -r "cursor-plugins-src/$p" "$HOME/.cursor/plugins/" ; done
ls "$HOME/.cursor/plugins"
```

部署步骤来源：[https://github.com/cursor/plugins](https://github.com/cursor/plugins)

## 验证状态

| 场景 | 状态 |
|---|---|
| 仓库元数据已核对：14.2k stars、MIT、2026-01 建仓 | 已核对 2026-10-27 |
| README 确认插件根目录结构与 marketplace.json 机制 | 已核对 2026-10-27 |
| 未实测 Cursor 内加载效果 | 说明 2026-10-27 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

部分插件目录内自带 `mcp.json`，由 Cursor 在启用插件时读取；本仓库不注册 MCP。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-27）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\cursor-plugins-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

重启 Cursor，在 **Settings → Plugins** 里启用刚才复制的插件。

### 已复制的四个插件

| 插件 | 作用 |
|---|---|
| `thermos` | 深度安全 / 正确性审查，带并行子 Agent |
| `teaching` | 技能映射、练习计划、学习复盘 |
| `advisor` | 重大决策前咨询更强模型 |
| `orchestrate` | 大任务拆给多个云端 Agent 并行 |

### 换别的插件

仓库根目录就是插件名，把 `for p in ...` 里的名字换成目标目录即可。完整列表见仓库 README 的表格。

### 第三方集成

Gmail、Google Drive、Salesforce、Stripe、GitHub 等插件首次使用要授权对应账号，按 Cursor 弹窗走 OAuth。

> ⚠️ 启用第三方插件等于把对应账号权限交给 Agent，先看清楚要哪些 scope。

## 常见坑

- 复制后不显示：确认目录结构是 `<name>/.cursor-plugin/plugin.json`
- 复制到项目里只对该项目生效：全局要放 `~/.cursor/plugins`
- 插件不生效：重启 Cursor
- OAuth 反复失败：先退出对应账号再重新授权
- 更新插件：删掉旧目录重新 `git pull` 再复制
- 慎装高权限插件：会读邮件、日历、代码库

## 免责声明

本仓库为第三方指南，与 Cursor Plugins 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-27），项目迭代快，请以[官方文档](https://github.com/cursor/plugins#cursor-plugins)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
