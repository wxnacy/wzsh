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
    zdbug "代理地址：${PROXY}"
    export no_proxy=${no_proxy}
    export http_proxy=${PROXY}
    export https_proxy=$http_proxy
    zinfo "已开启代理"
}

# 关闭代理
function proxyoff(){
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

# 更新 wzsh
function wzshupdate() {
    cd ~/.wzsh && git pull && cd -
}

function send_kindle() {
    # 发送文件到 kindle
    zinfo "准备发送文件"
    book_path=$1
    kindle=371032668@qq.com
    if [ $2 ]
    then
        kindle=$2
    fi
    filename=$(python -c "import os; print(os.path.basename('${book_path}'))")
    zinfo "${filename} -> ${kindle}"
    echo "$filename" | mutt ${kindle} -a ${book_path} -s "$filename"
    zinfo "发送完毕"
}
