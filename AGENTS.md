# wzsh 项目结构

## 项目目录结构

```
.wzsh/
├── bin/                        # 全局可执行脚本
│   ├── wzsh                    # wzsh 主程序
│   ├── wzsh-install            # 安装所有插件
│   └── wzsh-brew               # brew 相关工具
├── lib/                        # 公共库
│   ├── basic.zsh               # 基础工具函数（最先加载）
│   ├── functions.zsh           # 通用函数库
│   ├── color.zsh               # 颜色输出工具
│   ├── logger.zsh              # 日志工具
│   ├── ttl.zsh                 # TTL 缓存工具
│   └── pythonx/                # Python 工具库
├── plugins/                    # 插件目录，每个插件独立一个子目录
│   ├── wzsh-self/              # wzsh 核心插件（别名、cmd 工具等）
│   ├── wzsh-homebrew/          # Homebrew 管理
│   ├── wzsh-zinit/             # zinit 插件管理器 + p10k 主题
│   ├── wzsh-git/               # git 增强（别名、gcz 提交工具等）
│   ├── wzsh-fzf/               # fzf 模糊搜索增强
│   ├── wzsh-python/            # Python/pyenv 环境
│   ├── wzsh-go/                # Go 环境及版本工具
│   ├── wzsh-rust/              # Rust/cargo 环境
│   ├── wzsh-nvm/               # Node.js/nvm 环境
│   ├── wzsh-ai/                # AI 工具（aider、tts 等）
│   ├── wzsh-gemini/            # Gemini CLI 工具
│   ├── wzsh-nvim/              # Neovim 配置
│   ├── wzsh-kitty/             # Kitty 终端配置
│   ├── wzsh-wezterm/           # WezTerm 终端配置
│   ├── wzsh-alacritty/         # Alacritty 终端配置
│   ├── wzsh-yazi/              # yazi 文件管理器配置
│   ├── wzsh-mpv/               # mpv 播放器配置及脚本
│   ├── wzsh-ssh/               # SSH 工具
│   ├── wzsh-obsidian/          # Obsidian 笔记工具
│   ├── wzsh-bilibili/          # Bilibili 下载工具
│   ├── wzsh-youtube-dl/        # youtube-dl 下载工具
│   ├── wzsh-television/        # television 模糊搜索工具
│   ├── wzsh-website/           # 个人网站工具
│   ├── wzsh-config/            # 配置目录管理工具
│   ├── wzsh-direnv/            # direnv 环境变量管理
│   ├── wzsh-conda/             # conda 环境管理
│   ├── wzsh-poetry/            # Poetry Python 包管理
│   ├── wzsh-docker/            # Docker 别名
│   ├── wzsh-vagrant/           # Vagrant 虚拟机工具
│   ├── wzsh-chezmoi/           # chezmoi dotfiles 管理
│   ├── wzsh-eza/               # eza 文件列表增强
│   ├── wzsh-ranger/            # ranger 文件管理器
│   ├── wzsh-superfile/         # superfile 文件管理器
│   ├── wzsh-wush/              # wush 远程工具
│   ├── wzsh-taskwarrior/       # taskwarrior 任务管理
│   ├── wzsh-browser/           # 浏览器工具
│   ├── wzsh-tool/              # 通用工具集
│   └── wzsh-agent/             # (symlink) agent 插件
├── completions/                # zsh 命令补全脚本
├── config/                     # 全局配置文件
├── docs/                       # 项目文档
├── scripts/                    # 安装脚本
├── zshenv                      # zsh 环境变量（最先加载，定义插件列表和路径）
├── zshrc                       # zsh 主配置（加载 lib 和插件 zshrc）
├── zprofile                    # zsh 登录配置
├── installer.sh                # curl 一键安装脚本
└── Makefile                    # make install 入口
```

## 插件配置系统

### config.json

位于 `${WZSH_HOME}/config.json`，纳入版本控制，定义插件加载列表。

```json
{
  "plugins": [
    { "name": "wzsh-self" },
    { "path": "/Users/wxnacy/Projects/agent/.agent", "name": "agent" },
    { "github": "wxnacy/wzsh-work" },
    { "github": "wxnacy/wzsh-work", "path": "/local/debug/path" }
  ]
}
```

### config.local.json

位于 `${WZSH_HOME}/config.local.json`，**不纳入版本控制**，用于本地私有插件扩展。其 `plugins` 列表追加到 `config.json` 之后。

### 插件路径解析规则

| 配置 | 实际加载路径 |
|------|------------|
| `{ "name": "wzsh-self" }` | `${WZSH_HOME}/plugins/wzsh-self` |
| `{ "path": "/foo/bar" }` | `/foo/bar` |
| `{ "github": "user/repo" }` | `${WZSH_DATA}/plugins/repo` |
| `{ "github": "...", "path": "/foo" }` | `/foo`（本地调试优先） |

解析逻辑由 `lib/pythonx/config.py` 实现，输出 `WZSH_PLUGIN_PATHS` 数组供 `zshenv` / `zshrc` / `zprofile` 加载。

## 项目规范

### 路径引用规范

- 本项目文件根目录统一使用 `${WZSH_HOME}` 变量引用，不使用 `$HOME/.wzsh` 硬编码路径
- 示例：`${WZSH_HOME}/plugins/wzsh-self/bin/cmd`

### 关键环境变量

| 变量 | 说明 |
| --- | --- |
| `WZSH_HOME` | wzsh 根目录，值为 `$HOME/.wzsh` |
| `WZSH_DATA` | 数据目录，值为 `$HOME/.local/share/wzsh` |
| `WZSH_BIN` | 安装后的可执行文件目录 `$WZSH_DATA/bin` |
| `WZSH_CACHE_HOME` | 配置缓存目录 `~/Documents/Configs/wzsh` |
| `WZSH_PLUGINS` | 已启用的插件列表（在 `zshenv` 中定义） |
| `WZSH_BREW_HOME` | Homebrew 安装路径（自动适配 Apple Silicon / Intel / Linux） |

### 插件结构规范

每个插件目录（`plugins/wzsh-<name>/`）可包含以下文件：

| 文件 | 说明 |
| --- | --- |
| `zshenv` | 环境变量，在 `~/.zshenv` 阶段加载 |
| `zshrc` | 函数和配置，在 `~/.zshrc` 阶段加载 |
| `zprofile` | 登录 shell 配置 |
| `aliases.zsh` | 别名定义 |
| `bin/` | 可执行脚本，安装时软链到 `$WZSH_BIN` |
| `config/` | 插件配置文件 |
| `installer` | 自定义安装脚本（`wzsh-install` 时执行） |
| `Brewfile` | Homebrew 依赖声明 |

### 加载顺序

1. `zshenv` → 加载所有插件的 `zshenv`
2. `zshrc` → 加载 `lib/basic.zsh`、`lib/functions.zsh`，初始化补全，再加载所有插件的 `zshrc`
3. 最后加载 `~/.local/zshrc`（本地私有配置，不纳入版本控制）

## 命令说明

### switch_dir - 交互式切换目录

在 `plugins/wzsh-self/zshrc` 中定义的 zsh 函数，使用 `gum choose` 选择器列出指定根目录下的子目录，选择后进入该目录。

#### 参数

- `-d, --dir <目录>` - 指定根目录，默认为当前目录，支持 `~` 路径展开

#### 示例

```bash
switch_dir                    # 在当前目录下选择子目录
switch_dir -d ~/Projects      # 在 ~/Projects 下选择子目录
```

### cmd - 命令行管理工具

管理常用命令行，避免遗忘，可搜索并将选中命令输入到 shell 中。脚本位于 `${WZSH_HOME}/plugins/wzsh-self/bin/cmd`，通过 `plugins/wzsh-self/zshrc` 中的同名函数包装调用。

#### 子命令

| 子命令 | 说明 |
| --- | --- |
| `cmd` | fzf 搜索命令，回车后推送到 shell 输入框 |
| `cmd add` | 交互式添加新命令 |
| `cmd edit <id\|alias>` | 交互式编辑命令 |
| `cmd rm <id\|alias>` | 删除命令 |
| `cmd run <id\|alias> [args...]` | 直接执行命令，支持追加参数 |

#### 快捷键（搜索模式）

| 快捷键 | 说明 |
| --- | --- |
| `Enter` | 将命令推送到 shell 输入框 |
| `Ctrl-O` | 直接执行命令 |
| `Ctrl-Y` | 复制命令到剪贴板 |

#### 数据存储

命令数据以 JSON 格式保存在 `${config}/cmd.json`（默认 `~/Documents/Configs/wzsh/self/cmd.json`）：

```json
{
  "commands": [
    {
      "id": 1,
      "command": "ls -la",
      "desc": "列出所有文件详细信息",
      "alias": "ll"
    }
  ],
  "next_id": 2
}
```

### wzsh-install - 安装插件

```bash
wzsh-install          # 安装所有插件
wzsh-install <name>   # 安装指定插件（不含 wzsh- 前缀）
wzsh-install --no-brew  # 跳过 brew bundle install
```

安装流程：软链 `bin/` 下可执行文件到 `$WZSH_BIN` → 执行 `Brewfile` → 执行 `installer`。
