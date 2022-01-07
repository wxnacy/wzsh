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
    for name in ack, gotop;
    do
        echo $name
    done
}
