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

function is_apple_arm() {
    # 是否为苹果m芯片
    if [[ "$(uname -s) $(uname -m)" == "Darwin arm64" ]]
    then
        echo true
    else
        echo ''
    fi
}

function is_apple_intel() {
    # 是否为苹果intel芯片
    if [[ "$(uname -s) $(uname -m)" == "Darwin x86_64" ]]
    then
        echo true
    else
        echo ''
    fi
}

function is_apple() {
    # 是否是苹果系统
    if [[ "$(uname -s)" == "Darwin" ]]
    then
        echo true
    else
        echo ''
    fi
}

function is_linux() {
    # 是否是 Linux 系统
    if [[ "$(uname -s)" == "Linux" ]]
    then
        echo true
    else
        echo ''
    fi
}

function debugon() {
    # 开始 wzsh debug 模式
    export WZSH_DEBUG=true
    export WZSH_LOG_LEVEL=debug
    zinfo "${WZSH_NAME} DEBUG 模式开启"
}

function debugoff() {
    # 关闭 wzsh debug 模式
    unset WZSH_DEBUG
    export WZSH_LOG_LEVEL=info
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

function weekdate() {
    # 运行 python 的 datetimes.get_weekdate 模块函数
    # 获取当前星期的某一天
    # weekdate 0 周一的日期
    # weekdate 6 周日的日期
    echo "$(python -c "import sys; sys.path.append('${WZSH_HOME}/lib/pythonx'); import datetimes; print(datetimes.get_weekdate($1))")"
}

# date +%V 第几周
# date +%j 第几天
# date +%G 年份
# date +%Y%m01 当月第一天

function weeknum() {
    # 第几周
    date +%V
}

function monday() {
    # 返回周一的日期
    weekdate 0
}

function sunday() {
    # 返回周日的日期
    weekdate 6
}

# PROXY=""
# NO_PROXY="baidu.com,wxnacy.com,localhost"

function proxyon() {
    # 开启代理
    local proxy=$1
    if [[ ! ${proxy} ]]
    then
	    proxy=${PROXY}
    fi
    if [[ ! ${proxy} ]]
    then
        zerror '代理地址 $PROXY 为空，开始代理失败'
        return
    fi
    zdbug "代理地址：${proxy}"

    unset no_proxy
    unset http_proxy
    unset https_proxy
    unset all_proxy

    export no_proxy=${NO_PROXY}
    export http_proxy=${proxy}
    export https_proxy=$http_proxy
    export all_proxy=$http_proxy
    zinfo "已开启代理"
}

function proxyoff(){
    # 关闭代理
    unset http_proxy
    unset https_proxy
    unset all_proxy
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

BACKUP_SUFFIX=".bak.$(date +%Y%m%d%H%M%S)"

function zlink() {
    local src=$1
    local dest=$2
    zinfo "Checking ${dest}"
    if [ -L "${dest}" ]; then
        if [ "$(readlink "${dest}")" = "${src}" ]; then
            zinfo "✓ Already linked correctly"
        else
            zinfo "Relinking ${dest} -> ${src}"
            ln -sf "${src}" "${dest}"
        fi
    elif [ -e "${dest}" ]; then
        zinfo "Backing up existing ${dest} to ${dest}${BACKUP_SUFFIX}"
        mv "${dest}" "${dest}${BACKUP_SUFFIX}"
        zinfo "Linking ${dest} -> ${src}"
        ln -sf "${src}" "${dest}"
    else
        zinfo "Linking ${dest} -> ${src}"
        ln -sf "${src}" "${dest}"
    fi
}

# 第一个参数作为文件夹
# 判断文件夹是否存在，如果存在添加到 $PATH 中
function addpath() {
    local dir_to_add="$1"

    if [[ -z "$dir_to_add" ]]; then
        zerr "错误: addpath 函数需要一个目录路径作为参数。"
        return 1
    fi

    if [[ -d "$dir_to_add" ]]; then
        # 检查是否已存在于 PATH 中
        if [[ ":$PATH:" == *":$dir_to_add:"* ]]; then
            zdbug "路径 '${dir_to_add}' 已存在于 PATH 中。"
        else
            export PATH="${dir_to_add}:${PATH}"
            zdbug "已将路径 '${dir_to_add}' 添加到 PATH。"
        fi
    else
        zwarn "警告: 目录 '${dir_to_add}' 不存在，未添加到 PATH。"
        return 1
    fi
    return 0
}
