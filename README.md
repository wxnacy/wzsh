# wzsh

## 安装

zsh 快速配置脚本

**需要的依赖** `homebrew, curl, git, zsh`

[Zsh 与 oh-my-zsh 安装与使用](https://wxnacy.com/2017/08/16/shell-2017-08-16-zsh-install/)

使用 `curl` 安装

```bash
curl -L https://raw.githubusercontent.com/wxnacy/wzsh/master/installer.sh | bash
```

或者手动安装

```bash
CUR_DIR=$(pwd)
W_HOME=$HOME/.local/share/wzsh
W_GIT=$W_HOME/wzsh.git
command mkdir -p "$W_HOME" && command chmod g-rwX "$W_HOME"
test -d "$W_GIT" || git clone --recursive --depth=1 https://github.com/wxnacy/wzsh "${W_GIT}"
cd $W_GIT
make install
cd $CUR_DIR
```

## 本人全环境安装

```bash
# install brew from https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/

# install and init zsh and ohmyzsh
curl -L https://raw.githubusercontent.com/wxnacy/wzsh/master/installer.sh | bash
# 安装全部插件
wzsh-install

# install and init tmux
# prefix + $ 修改 session 名称
# prefix + c 创建窗口
# prefix + , 修改窗口名称
# tmux a -t [session-name] 跳转指定 session
curl -L https://raw.githubusercontent.com/wxnacy/wtmux/master/install | bash

# git config
ssh-keygen -t rsa -C "wxnacy"
ggconf
cd ~/.zsh
git-set-ssh-url
cd ~/.config/nvim
git-set-ssh-url
cd ~/.tmux
git-set-ssh-url

# install karabiner
brew install --cask karabiner-elements

# 配置 mac
# 重启电脑 command + r
# csrutil disable

# install mongo
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community
brew services start mongodb/brew/mongodb-community
mongo --eval "db.version()"
# 修改绑定ip,然后重启
vim /usr/local/etc/mongod.conf
net:
  port: 27017
  bindIp: 0.0.0.0
```

### karabiner config

<!--fold-->
```json
{
    "description": "Change Command + o to Enter",
    "manipulators": [
        {
            "from": {
                "key_code": "o",
                "modifiers": {
                    "mandatory": [
                        "command"
                    ],
                    "optional": [
                        "any"
                    ]
                }
            },
            "to": [
                {
                    "key_code": "return_or_enter"
                }
            ],
            "type": "basic"
        }
    ]
}
```
<!--/fold-->

<!--fold-->
```json
{
    "description": "Change Right Command + h/j/k/l to Arrows",
    "manipulators": [
        {
            "from": {
                "key_code": "h",
                "modifiers": {
                    "mandatory": [
                        "right_command"
                    ],
                    "optional": [
                        "any"
                    ]
                }
            },
            "to": [
                {
                    "key_code": "left_arrow"
                }
            ],
            "type": "basic"
        },
        {
            "from": {
                "key_code": "j",
                "modifiers": {
                    "mandatory": [
                        "right_command"
                    ],
                    "optional": [
                        "any"
                    ]
                }
            },
            "to": [
                {
                    "key_code": "down_arrow"
                }
            ],
            "type": "basic"
        },
        {
            "from": {
                "key_code": "k",
                "modifiers": {
                    "mandatory": [
                        "right_command"
                    ],
                    "optional": [
                        "any"
                    ]
                }
            },
            "to": [
                {
                    "key_code": "up_arrow"
                }
            ],
            "type": "basic"
        },
        {
            "from": {
                "key_code": "l",
                "modifiers": {
                    "mandatory": [
                        "right_command"
                    ],
                    "optional": [
                        "any"
                    ]
                }
            },
            "to": [
                {
                    "key_code": "right_arrow"
                }
            ],
            "type": "basic"
        }
    ]
}
```
<!--/fold-->

## 方法

| 名称       | 描述                                                                                                                           | 样例                                           |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| proxyon    | 开启代理，<br/>可在 ~/.bashrc 中配置变量 <br/>export PROXY="http://127.0.0.1:1080" <br/>export no_proxy="baidu.com,wxnacy.com" | >$ proxyon                                     |
| proxyooff  | 关闭代理                                                                                                                       | >$ proxyoff                                    |
| pydl       | 下载 Python 版本包, 默认下载到当前目录                                                                                         | >$ pydl 2.7.12 <br/>>$ pydl 2.7.12 ~/Downloads |
| pyi        | 使用国内源下载 Python 版本包，并使用 pyenv 安装                                                                                | >$ pyi 2.7.12                                  |
| wzshupdate | 更新 wzsh 版本                                                                                                                 | >$ wzshupdate                                  |
| ydl        | 使用 youtube-dl 下载视频，并开启后台进程                                                                                       | >$ ydl <https://youtube.com/v/xxxx>            |
| gpush      | git 默认提交所有变动信息                                                                                                       | >$ gpush commit msg                            |
| cmd        | 命令行管理工具，管理常用命令<br/>回车：输入到 shell<br/>Ctrl-O：直接执行<br/>Ctrl-Y：复制到剪贴板                              | >$ cmd                                         |
| cmd add    | 添加新命令                                                                                                                     | >$ cmd add                                     |
| cmd edit   | 编辑命令                                                                                                                       | >$ cmd edit <id\|alias>                        |
| cmd rm     | 删除命令                                                                                                                       | >$ cmd rm <id\|alias>                          |
| cmd run    | 直接运行命令                                                                                                                   | >$ cmd run <id\|alias>                         |
| switch_dir | 交互式切换目录，使用 gum choose 选择子目录后进入                                                                               | >$ switch_dir -d ~/Projects                    |
| wzsh plugin create | 创建插件骨架，`-d/--dir` 指定父目录，已存在文件自动跳过                                                              | >$ wzsh plugin create myplugin -d ~/plugins    |
| wzsh plugin init   | 将当前目录作为插件目录，补全缺失的骨架文件（不覆盖已有文件）                                                          | >$ cd wzsh-myplugin && wzsh plugin init        |

## 插件配置

插件列表由 `${WZSH_HOME}/config.json` 和 `~/.config/wzsh/config.json` 共同管理。

```json
{
  "plugins": [
    { "name": "wzsh-self", "order": 0 },
    { "name": "wzsh-zinit", "enabled": false },
    { "github": "wxnacy/wzsh-work" },
    { "path": "/path/to/local-plugin", "name": "myplugin" }
  ]
}
```

| 字段 | 说明 |
| --- | --- |
| `name` | 插件名，内置插件对应 `plugins/<name>` 目录 |
| `github` | GitHub 仓库地址（`user/repo`），自动 clone 到 `$WZSH_DATA/plugins/` |
| `path` | 本地路径，直接使用该目录 |
| `order` | 加载顺序，默认 100，数字越小越先加载 |
| `enabled` | 是否加载，默认 `true`，设为 `false` 则跳过该插件 |
