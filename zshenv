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

export WZSH_HOME=${HOME}/.zsh
export PATH="${WZSH_HOME}/bin:${PATH}"
export WZSH_NAME=wZsh
export WZSH_CACHE_HOME="${HOME}/Documents/Configs/wzsh"
export WZSH_TEMP=/tmp/wzsh
export WZSH_LOG=${WZSH_TEMP}/wzsh.log
# 创建临时文件目录
if [[ ! -d ${WZSH_TEMP} ]]; then
    mkdir ${WZSH_TEMP}
fi
echo '' > ${WZSH_LOG}
# debug 模式设置日志级别为 debug
if [ $WZSH_DEBUG ]
then
    export WZSH_LOG_LEVEL=debug
else
    export WZSH_LOG_LEVEL=info
fi
# 命令安装基础信息
export WZSH_BREW_HOME_OPT=/opt/homebrew/opt
export WZSH_BREW_HOME_CASK=/opt/homebrew/Caskroom
export WZSH_BREW_HOME_BIN=/opt/homebrew/bin
if [[ $(uname -m) == "x86_64" ]]; then
    export WZSH_BREW_HOME_OPT=/usr/local/opt
    export WZSH_BREW_HOME_CASK=/usr/local/Caskroom
    export WZSH_BREW_HOME_BIN=/usr/local/bin
fi
export WZSH_BREW="${WZSH_BREW_HOME_BIN}/brew"
# 加载基础命令
source ${WZSH_HOME}/lib/basic.zsh
zdbug $(blue "###############################################")
zdbug $(blue "加载 ~/.zshenv")
zdbug $(blue "###############################################")

export WZSH_PLUGINS=(python direnv eza fzf gemini git go homebrew kitty mpv nvim p10k poetry rust ssh yazi)

# 加载插件
for plugin in "${WZSH_PLUGINS[@]}"; do
    name="wzsh-${plugin}"
    bindir=${WZSH_HOME}/plugins/${name}/bin
    if [[ -d $bindir ]]
    then
        zdebug "加载 bin $name"
        export PATH="$bindir:${PATH}"
    fi
    shfile=${WZSH_HOME}/plugins/${name}/zshenv

    if [ -f $shfile ]; then
        source $shfile
    fi
done

# 加载 bash 登录配置
for name in .local/zshenv
do
    shfile=${HOME}/${name}
    if [ -f $shfile ]; then
        zdebug "加载 $shfile"
        source $shfile
    fi
done
