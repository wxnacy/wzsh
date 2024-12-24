

if [ $(is_apple_arm) ]
then
    zdbug "加载 Apple Arm64 芯片脚本"
else
    zdbug "加载 Apple Intel 芯片脚本"
    # load autojump
    [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
fi
