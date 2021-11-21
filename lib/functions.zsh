#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2017-08-27
# Modified: 2021-04-01
# Description: 方法脚本
#===============================

PROXY="http://127.0.0.1:1080"
no_proxy="baidu.com,wxnacy.com"

# 开启代理
function proxyon() {
    echo 'proxy' ${PROXY}
    export no_proxy=${no_proxy}
    export http_proxy=${PROXY}
    export https_proxy=$http_proxy
    echo -e "已开启代理"
}

# 关闭代理
function proxyoff(){
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}

# 下载指定版本 Python 包
# function pydl() {
    # v=$1
    # d=$2
    # if [ ! $d ]
    # then
        # d=./
    # fi
    # echo '准备下载 Python' $v
    # curl -L https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz -o ${d}/Python-$v.tar.xz
# }

# pyenv 安装 python 新版本
# function pyi() {
    # v=$1
    # echo '准备按照 Python' $v
    # curl -L https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz -o ~/.pyenv/cache/Python-$v.tar.xz
    # pyenv install $v
# }

# 更新 wzsh
function wzshupdate() {
    cd ~/.wzsh && git pull
}

# 添加 youtube-dl 后台任务
function ydl() {
    nohup youtube-dl $1 >> ${HOME}/Downloads/ydl.log & 2>&1
}

