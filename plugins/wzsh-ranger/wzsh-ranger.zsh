#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2021-11-21
# Modified: 2021-12-03
# Description: python 相关命令
#===============================

. ${WZSH_HOME}/lib/try-catch.zsh
. ${WZSH_HOME}/plugins/wzsh-ranger/aliases.zsh


function rainit() {
    # 初始化 ranger 环境
    for name in ranger;
    do
        if [ $(has_command $name) ]
        then
            zinfo "$name 已安装"
        else
            zinfo "$name 开始安装"
            brew install $name
        fi
    done

    test -d ~/.config || mkdir ~/.config
    conf_dir=~/.config/ranger
    if [ ! -d $conf_dir ]
    then
        # 链接当前配置文件夹
        zinfo "链接配置 $conf_dir"
        ln -sf ${WZSH_HOME}/plugins/wzsh-ranger/config $conf_dir
    else
        zinfo "${conf_dir} 配置已存在"
    fi

    for name in trash ffmpegthumbnailer;
    do
        if [ $(has_command $name) ]
        then
            zinfo "$name 已安装"
        else
            zinfo "$name 开始安装"
            brew install $name
        fi
    done

}
