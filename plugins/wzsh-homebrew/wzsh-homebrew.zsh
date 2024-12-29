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


function brewinit() {
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
    # taskwarrior-tui 任务管理工具
    # ranger 文件管理区
    # trash 回收站管理
    # jq json 处理工具
    # fzf 文件搜索
    # rg 文件查找引擎
    # ag 文件查找引擎
    # highlight 文本高亮工具
    # autojump 快速跳转目录
    # imgcat 在 iterm2 上显示图片
    # gitlint git 提交规范校验工具
    # tree 目录树状展示
    # direnv 自动加载环境变量
    # pyenv for python env manager
    # font-hack-nerd-font 客户端中的icon展示 iterm2 配置 https://blog.csdn.net/SmallTeddy/article/details/124850597
    # brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font
    # eza   取代 ls
    zinfo '开始安装必备工具'
    for name in ack gotop htop ffmpeg tmux ctags ncdu vim w3m node wget watch \
        taskwarrior-tui jq fzf rg autojump highlight gitlint tree direnv \
        font-hack-nerd-font \
        eza \
        yarn ranger trash "eddieantonio/eddieantonio/imgcat";
    do
        wzsh-brew install $name
        # cmd=$name
        # if [[ $name == 'taskwarrior-tui' ]]
        # then
            # cmd=task
        # fi
        # if [ $(has_command $cmd) ]
        # then
            # zinfo "$name 已安装"
        # else
            # zinfo "$name 开始安装"
            # wzsh-brew install $name
            # # if [[ $name == 'fzf' ]]
            # # then
                # # $(brew --prefix)/opt/fzf/install
            # # fi
        # fi
    done

    echo '---------'

    zinfo '开始安装必备软件'
    # font-hack-nerd-font vim 插件需要的字体
    # vagrant virtualbox 虚拟机
    # raycast 效率工具
    # iterm2 iterminal 工具
    # keycastr 键盘映射打印
    # keepassxc 密码管理工具
    #

    # for name in font-hack-nerd-font vagrant virtualbox raycast;
    # do
        # brew install --cask $name
    # done
}
