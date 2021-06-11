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
        case $ex_code in
            $GitException)
                echo "GitException was thrown"
            ;;
            *)
                echo "An unexpected exception was thrown"
                throw $ex_code # you can rethrow the "exception" causing the script to exit if not caught
            ;;
        esac
    }
    git add $file
    git commit -m "$msg"
    git push origin $bname
    proxyoff
}

function gcmit(){
    file=$1
    echo '提交文件:' $file
    msg=${@/$1/}
    echo '提交信息:' $msg
    git add $file
    git commit -m "$msg"
}

