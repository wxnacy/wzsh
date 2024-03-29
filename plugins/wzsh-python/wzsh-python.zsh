#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2021-11-21
# Modified: 2021-12-03
# Description: python 相关命令
#===============================

. ${WZSH_HOME}/lib/try-catch.zsh
. ${WZSH_HOME}/plugins/wzsh-python/aliases.zsh

export GitException=100

function pipi() {
    # 使用国内源下载
    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple $@
    pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple $@
}

function pypush() {
    # 发布 python 包
    TAG_NAME=$1
    if [ -f setup.py ]
    then
        # TODO 检查 twine 命令
        test -d dist && rm -rf dist; zinfo "清理 dist 目录"

        zinfo "开始打包"
        python setup.py sdist
        zinfo "开始上传"
        proxyon
        twine upload dist/*
        # TODO 检查环境变量 TWINE_USERNAME TWINE_PASSWORD
        # twine upload dist/* --verbose
        proxyoff

        # TODO 判断是否已经存在某个版本
        test -d .git && zinfo "上传 tag 到 git"; gptag $TAG_NAME
        zinfo "$TAG_NAME 推送成功"
    else
        zerror "缺失 setpy.py 进程终止"
    fi
}

function pyver() {
    # 查看当前模块的版本
    dirname=$(python -c "import os; print(os.path.basename(os.getcwd()))")
    echo $(python -c "from ${dirname}.__version__ import __version__;print(__version__)")
}

function pycrypto3() {
    # py3 环境下重装 pycrypto 包
    pip uninstall pycrypto
    pip uninstall pycryptodome
    pip install pycryptodome
}

function pymkdir() {
    # 创建 python 文件夹，自动创建 __init__.py
    dirname=$1
    if [ -d $dirname ]
    then
        zinfo "$dirname 已存在，不再重新创建"
    else
        zinfo "创建 $dirname"
        mkdir $dirname
    fi

    init_path=$dirname/__init__.py
    if [ -f $init_path ]
    then
        zinfo "$init_path 已存在，不再重新创建"
    else
        zinfo "创建 $init_path"
        touch $init_path
        echo '#!/usr/bin/env python' >> $init_path
        echo '# -*- coding:utf-8 -*-' >> $init_path
        echo '# Author: wxnacy@gmail.com' >> $init_path
    fi
    zinfo "Python 文件夹 $dirname 创建完毕"

}

function lProfile() {
    # 使用 line_profiler 对 python 程序进行分析
    tmpfile=$WZSH_TEMP/lProfile_$RANDOM
    kernprof -l -o $tmpfile $@
    python -m line_profiler $tmpfile
}

# 推送
function cProfile(){
    # 使用 cProfile 分析 python 文件运行耗时
    # 图形化分析需要 pip install snakeviz
    if [ ! $(has_command snakeviz) ];
    then
        echo '图形化分析需要安装 snakeviz'
        echo '可以执行命令进行安装'
        echo '    pip install snakeviz'
        exit
    fi

    pyfile=$1
    tmpfile=$WZSH_TEMP/cProfile_$RANDOM
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

function pyready() {
    # python 常用包和环境的准备工作
    pip install -U pip
    pipi pytest bpython pigar twine pyflakes
}
