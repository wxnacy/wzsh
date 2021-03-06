#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2021-06-11
# Modified: 2021-06-11
# Description: try-catch 模块
#===============================

. ${WZSH_HOME}/lib/try-catch.zsh
. ${WZSH_HOME}/plugins/wzsh-git/aliases.zsh

export GitException=100

# 推送
function gpush(){
    bname=`git branch | grep '*' | awk '{print $2}'`
    echo '当前分支:' $bname
    file=$1
    echo '提交文件:' $file
    msg=${@/$1/}
    echo '提交信息:' $msg
    proxyon
    try
    (   # open a subshell !!!
        git pull origin $bname && throw $GitException
    )
    catch || {
        echo 'Pull Error'
    }
    if [ $file ]
    then
        git add $file
    fi
    if [ $msg ]
    then
        git commit -m "$msg"
    fi
    git push origin $bname
    proxyoff
}

# 拉取最新子模块
function gsub(){
    proxyon
    echo '拉取最新子模块'
    git submodule update --init --recursive
    proxyoff
}

# 添加并提交
function gcmit(){
    file=$1
    echo '提交文件:' $file
    msg=${@/$1/}
    echo '提交信息:' $msg
    git add $file
    git commit -m "$msg"
}

# 拉取
function gpull(){
    proxyon
    git pull
    proxyoff
}

# git clone
function glone(){
    proxyon
    git clone $@
    proxyoff
}

# 配置
function gconf(){
    git config user.name "wxnacy"
    git config user.email "371032668@qq.com"
}
