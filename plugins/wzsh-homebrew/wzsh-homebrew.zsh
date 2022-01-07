#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-06
# Modified: 2022-01-06
# Description: homebrew 相关命令
#===============================

. ${WZSH_HOME}/lib/try-catch.zsh
. ${WZSH_HOME}/plugins/wzsh-homebrew/aliases.zsh


function brewready() {
    # 准备 brew 初始安装包
    # ack 全文检索 ack.vim 需要使用
    # gotop htop 监控电脑性能
    # ffmpeg 适配编辑软件
    # tmux 窗口管理
    # ctags vim 中插件解析代码文件
    # ncdu 电脑存储分析工具
    # vim 文本编辑器
    # w3m shell 环境打开浏览器
    # node nodejs
    # wget 文件下载工具
    # watch 循环执行任务
    # yarn node 包管理工具
    zinfo '开始安装必备工具'
    for name in ack gotop htop ffmpeg tmux ctags ncdu vim w3m node wget watch \
        yarn;
    do
        brew install $name
    done
    echo '---------'

    zinfo '开始安装必备软件'
    for name in font-hack-nerd-font vagrant virtualbox;
    do
        echo $name
    done
}
