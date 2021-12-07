#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2021-06-11
# Modified: 2021-12-02
# Description: wzsh-git 插件
#===============================

. ${WZSH_HOME}/lib/try-catch.zsh
. ${WZSH_HOME}/plugins/wzsh-git/aliases.zsh

export GitException=100

# 推送
function gpush(){
    bname=`git branch | grep '*' | awk '{print $2}'`
    zinfo '当前分支:' $bname
    file=$1
    zinfo '提交文件:' $file
    msg=${@/$1/}
    zinfo '提交信息:' $msg
    proxyon
    if [ $file ]
    then
        git add $file
    fi
    if [ $msg ]
    then
        git commit -m "$msg"
    fi
    try
    (   # open a subshell !!!
        git pull origin $bname && throw $GitException
    )
    catch || {
        # case $ex_code in
            # $GitException)
                # echo "GitException was thrown"
            # ;;
            # *)
                # echo "An unexpected exception was thrown"
                # throw $ex_code # you can rethrow the "exception" causing the script to exit if not caught
            # ;;
        # esac
        # echo -e "\033[31mPull Error \033[0m"
        zerror "git pull failed"
    }
    git push origin $bname
    proxyoff
}

# 创建并推送 tag
function gptag(){
    git tag ${1}
    proxyon
    git push origin ${1}
    proxyoff
}

# 添加并提交
function gcmit(){
    file=$1
    zinfo '提交文件:' $file
    msg=${@/$1/}
    zinfo '提交信息:' $msg
    git add $file
    git commit -m "$msg"
}

# 拉取
function gpull(){
    bname=`git branch | grep '*' | awk '{print $2}'`
    zinfo "当前分支名称: ${bname}"
    proxyon
    git pull origin $bname $@
    proxyoff
}

function gsub(){
    # 拉去子模块初始状态
    proxyon
    zinfo '拉取子模块初始化状态'
    git submodule update --init --recursive
    proxyoff
}

function gsubr(){
    # 从远程拉去最新子模块的提交
    proxyon
    zinfo '拉取子模块最新提交'
    git submodule update --recursive --remote
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
