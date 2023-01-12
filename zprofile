# echo '.zprofile' >> /tmp/zshmsg
zinfo '加载 ~/.zprofile'

# 创建临时文件目录
test -d $WZSH_TEMP || mkdir $WZSH_TEMP && zinfo '创建临时文件目录'

# for wshell
if [ -d "${HOME}/.wshell" ]; then
    export WS_HOME="${HOME}/.wshell"
    export PATH=$PATH:${WS_HOME}/bin
fi

# for homebrew
zinfo "初始化 homebrew 环境"
if [ -d "/usr/local/Homebrew" ]; then
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles #ckbrew
    eval $(/usr/local/Homebrew/bin/brew shellenv) #ckbrew
fi

# for iterm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# 加载插件
for name in `ls ${WZSH_HOME}/plugins`
do
    shfile=${WZSH_HOME}/plugins/${name}/zprofile

    if [ -f $shfile ]; then
        zinfo "加载 zprofile $name"
        source $shfile
    fi

    bindir=${WZSH_HOME}/plugins/${name}/bin
    if [[ -d $bindir ]]
    then
        zinfo "加载 bin $name"
        export PATH="$bindir:${PATH}"
    fi
done

# for python
# source /usr/local/opt/autoenv/activate.sh

# CFLAGS="-I$(brew --prefix openssl)/include" \
# LDFLAGS="-L$(brew --prefix openssl)/lib"
