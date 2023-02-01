#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2017-08-27
# Modified: 2021-11-25
# Description: zsh 命令的开始
# 本文件不在做 wzsh 本身不相干代码插入
#===============================

export WZSH_HOME=${HOME}/.zsh
export PATH="${WZSH_HOME}/bin:${PATH}"
export WZSH_NAME=wZsh
export WZSH_TEMP=/tmp/wzsh
export WZSH_LOG=${HOME}/.wzsh.log
export WZSH_LOG_LEVEL=info
# 加载基础命令
source ${WZSH_HOME}/lib/basic.zsh
# zinfo '开始加载命令'
zdebug '加载 ~/.zshenv'

for name in `ls ${WZSH_HOME}/plugins`
do
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
