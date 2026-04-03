#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2017-08-27
# Modified: 2021-11-25
# Description: zsh 命令的开始
# 本文件不在做 wzsh 本身不相干代码插入
#===============================

export ZSH_START_TIME=$(/usr/bin/python3 -c 'import time; print(int(time.time() * 1000))')
# 需要加载的插件列表（已迁移到 config.json，保留注释备用）
# export WZSH_PLUGINS=(homebrew zinit go ai python direnv eza fzf gemini git kitty mpv nvim poetry rust ssh yazi vagrant chezmoi conda obsidian youtube-dl television website bilibili nvm alacritty wezterm)
export WZSH_DATA=${HOME}/.local/share/wzsh
export WZSH_BIN=${WZSH_DATA}/bin
export WZSH_COMPLETION=${WZSH_DATA}/completions
export WZSH_PLUGIN=${WZSH_DATA}/plugins
export WZSH_HOME=${HOME}/.zsh
# 加载基础命令
source ${WZSH_HOME}/lib/basic.zsh
export WZSH_NAME=wZsh
export WZSH_CACHE_HOME="${HOME}/Documents/Configs/wzsh"
export WZSH_TEMP=/tmp/wzsh
export WZSH_LOG=${WZSH_TEMP}/wzsh.log
# 创建临时文件目录
if [[ ! -d ${WZSH_TEMP} ]]; then
    mkdir ${WZSH_TEMP}
fi
echo '' >${WZSH_LOG}
# debug 模式设置日志级别为 debug
if [ $(is_debug) ]; then
    export WZSH_LOG_LEVEL=debug
else
    export WZSH_LOG_LEVEL=info
fi
# 命令安装基础信息
export WZSH_BREW_HOME=/opt/homebrew
if [ $(is_apple_intel) ]; then
    export WZSH_BREW_HOME=/usr/local
fi
if [ $(is_linux) ]; then
    if [[ -d "${HOME}/.linuxbrew/bin/brew" ]]; then
        export WZSH_BREW_HOME=${HOME}/.linuxbrew/bin/brew
    fi
    if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
        export WZSH_BREW_HOME=/home/linuxbrew/.linuxbrew
    fi
fi
export WZSH_BREW_HOME_OPT=${WZSH_BREW_HOME}/opt
export WZSH_BREW_HOME_CASK=${WZSH_BREW_HOME}/Caskroom
export WZSH_BREW_HOME_BIN=${WZSH_BREW_HOME}/bin
export WZSH_BREW="${WZSH_BREW_HOME_BIN}/brew"
zdbug $(blue "###############################################")
zdbug $(blue "加载 ~/.zshenv")
zdbug $(blue "###############################################")

# 加载 PATH
zdebug "加载 bin"
addpath "${WZSH_HOME}/bin"
addpath ${WZSH_BIN}
addpath "${HOME}/.local/bin"

# 加载 config.json 插件（新逻辑，带缓存）
_wzsh_cache=${WZSH_TEMP}/plugins.cache
_wzsh_config=${WZSH_HOME}/config.json
_wzsh_config_local=${WZSH_HOME}/config.local.json
if [[ ! -f $_wzsh_cache || $_wzsh_config -nt $_wzsh_cache || ( -f $_wzsh_config_local && $_wzsh_config_local -nt $_wzsh_cache ) ]]; then
    zdbug "重新生成插件缓存: $_wzsh_cache"
    /usr/bin/python3 ${WZSH_HOME}/lib/pythonx/config.py paths > /dev/null 2>&1
fi
WZSH_PLUGIN_PATHS=(${(f)"$(<$_wzsh_cache)"})
for plugin_path in "${WZSH_PLUGIN_PATHS[@]}"; do
    shfile=${plugin_path}/zshenv
    if [[ -f $shfile ]]; then
        source $shfile
    fi
done

# 加载插件（旧逻辑，已迁移到 config.json，暂时注释）
# for plugin in "${WZSH_PLUGINS[@]}"; do
#     name="wzsh-${plugin}"
#     shfile=${WZSH_HOME}/plugins/${name}/zshenv
#     if [ -f $shfile ]; then
#         source $shfile
#     fi
# done

