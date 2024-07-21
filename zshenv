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
export WZSH_LOG=${WZSH_TEMP}/wzsh.log
# 创建临时文件目录
if [[ ! -d ${WZSH_TEMP} ]]; then
    mkdir ${WZSH_TEMP}
fi
# debug 模式设置日志级别为 debug
if [ $WZSH_DEBUG ]
then
    export WZSH_LOG_LEVEL=debug
else
    export WZSH_LOG_LEVEL=info
fi
# 加载基础命令
source ${WZSH_HOME}/lib/basic.zsh
zdbug $(blue "###############################################")
zdbug $(blue "加载 ~/.zshenv")
zdbug $(blue "###############################################")


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
. "$HOME/.cargo/env"
