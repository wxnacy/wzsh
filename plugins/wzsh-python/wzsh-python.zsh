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

# 下载指定版本 Python 包
function pydl() {
    v=$1
    d=$2
    if [ ! $d ]
    then
        d=./
    fi
    echo '准备下载 Python' $v
    url=https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz
    echo '包地址：' $url
    curl -L $url -o ${d}/Python-$v.tar.xz
}

# pyenv 安装 python 新版本
function pyi() {
    v=$1
    echo '准备安装 Python' $v
    url=https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz
    echo '包地址：' $url
    # dl_dir=$(pip cache dir)
    dl_dir=~/.pyenv/cache
    pyname=Python-$v.tar.xz
    dl_path=$dl_dir/$pyname
    echo "下载 $pyname"
    echo "-> $url"
    echo "-> $dl_path"
    # ~/.pyenv/cache
    test -f $dl_path || curl -L $url -o $dl_path
    echo "Python $v 下载完毕"
    # TODO 优化日志输出
    # export PYTHON_BUILD_CACHE_PATH=~/.pyenv/cache/
    # export PYTHON_BUILD_CACHE_PATH=$dl_dir
    pyenv install $v -v
    # python-build $v $dl_path
    test -f $dl_path && rm $dl_path
}