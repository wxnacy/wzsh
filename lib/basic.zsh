#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2021-11-25
# Modified: 2021-11-25
# Description: 基础命令
#===============================

function now() {
    date '+%F %T'
}

# 加载日志命令
source ${WZSH_HOME}/lib/logger.zsh

function has_command() {
    # 判断是否存在某个命令
    # 使用方式
    # > test $(has_command python) && echo 'yes' || echo 'no'
    # > yes
    # > if [ $(has_command python) ];then;echo 'yes';else; echo 'no';fi;
    # > yes
    command -v $1 >/dev/null 2>&1 && echo true  || { echo ""; }
}

function is_debug() {
    # 判断是否为 debug 模式
    if [ $WZSH_DEBUG ]
    then
        echo true
    else
        echo ''
    fi
}

function debugon() {
    # 开始 wzsh debug 模式
    export WZSH_DEBUG=true
    zinfo "${WZSH_NAME} DEBUG 模式开启"
}

function debugoff() {
    # 关闭 wzsh debug 模式
    unset WZSH_DEBUG
    zinfo "${WZSH_NAME} DEBUG 模式关闭"
}

function debug() {
    # 查看当前是否为 debug 模式
    if [ $(is_debug) ]
    then
        zinfo "当前已开启 DEBUG 模式"
    else
        zinfo "当前已关闭 DEBUG 模式"
    fi
}

function zdbug() {
    # 在 zdebug 的基础上增加模式判断
    test $(is_debug) && zdebug $@
}
