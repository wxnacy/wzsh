#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2021-11-21
# Modified: 2021-11-21
# Description: python 相关命令
#===============================

. ${WZSH_HOME}/lib/try-catch.zsh
. ${WZSH_HOME}/plugins/wzsh-python/aliases.zsh

export GitException=100

# 推送
function zcProfile(){
    # 使用 cProfile 分析 python 文件运行耗时
    # 图形化分析需要 pip install snakeviz
    pyfile=$1
    dirname='/tmp/wzsh'
    test -d $dirname || mkdir $dirname
    tmpfile=$dirname/cProfile_$RANDOM
    python -m cProfile -o $tmpfile $pyfile
    snakeviz $tmpfile
}

