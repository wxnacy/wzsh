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

function format_size() {
    # 运行 python 的 utils 模块函数
    echo "$(python -c "import sys; sys.path.append('${WZSH_HOME}/lib/pythonx'); import utils; print(utils.format_size($1))")"
}

function proxyon() {
    # 开启代理
    zdbug "代理地址：${PROXY}"
    export no_proxy=${no_proxy}
    export http_proxy=${PROXY}
    export https_proxy=$http_proxy
    zinfo "已开启代理"
}

function proxyoff(){
    # 关闭代理
    unset http_proxy
    unset https_proxy
    zinfo "已关闭代理"
}

function proxy() {
    # 查看当前代理开启状态
    if [ $http_proxy ]
    then
        zinfo "当前已开启代理"
    else
        zinfo "当前已关闭代理"
    fi
}

# if [[ $* ]]
# then
    # # shell main 函数
    # # ./xxxx.sh func_name params1 params2
    # # 就是运行 func_name 函数并传入 params1 params2 两个参数
    # local cmd="$1"
    # # 将参数左移一位
    # shift
    # local rc=0
    # $cmd "$@" || rc=$?
    # return $rc
# fi
