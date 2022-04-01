#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2017-08-27
# Modified: 2021-11-25
# Description: zsh 命令的开始
#===============================

export WZSH_HOME=${HOME}/.zsh
export WZSH_NAME=wZsh
export WZSH_TEMP=/tmp/wzsh
export WZSH_LOG=${HOME}/.wzsh.log
# 加载基础命令
source ${WZSH_HOME}/lib/basic.zsh
# zinfo '开始加载命令'
# zinfo '加载 ~/.zshenv'

for name in `ls ${WZSH_HOME}/plugins`
do
    shfile=${WZSH_HOME}/plugins/${name}/zshenv

    if [ -f $shfile ]; then
        # zinfo "加载 zshenv $name"
        source $shfile
    fi
done
