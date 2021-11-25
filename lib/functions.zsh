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


# 更新 wzsh
function wzshupdate() {
    cd ~/.wzsh && git pull
}

# 添加 youtube-dl 后台任务
function ydl() {
    nohup youtube-dl $1 >> ${HOME}/Downloads/ydl.log & 2>&1
}

# 判断是否存在某个命令
function has_command() {
    command -v $1 >/dev/null 2>&1 && echo true  || { echo ""; }
}
