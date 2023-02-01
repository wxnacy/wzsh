# 本文件不在做 wzsh 本身不相干代码插入
zdebug '加载 ~/.zshrc'

export ZSH=${HOME}/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# ZSH_THEME="bureau"
# 使用 powerlevel10k 主题，详见 plugins/wzsh-p10k/wzsh-p10k.zsh
# history-substring-search
plugins=(git python sublime autojump)
if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
fi

# load autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
#
zdebug "开始加载本地库"
# load lib
for name in `ls ${WZSH_HOME}/lib`
do
    if [[ `echo $name | grep '__'` ]]
    then
        continue
    fi
    shfile=${WZSH_HOME}/lib/${name}

    if [ -f $shfile ]; then
        zdebug "加载 $name"
        source $shfile
    fi
done

zdebug "开始加载插件"
# load zsh plugins
for name in `ls ${WZSH_HOME}/plugins`
do
    zdebug "加载 $name"
    shfile=${WZSH_HOME}/plugins/${name}/${name}.zsh
    if [ -f $shfile ]; then
        source $shfile
    fi

    shfile=${WZSH_HOME}/plugins/${name}/zshrc
    if [ -f $shfile ]; then
        source $shfile
    fi
done


# 作者机器才会默认加载 .bashrc
# if [[ ${USER} == 'wenxiaoning' ]]; then
# fi
# load local bashrc
zdebug "开始加载本地环境"
for name in .bash_profile .bashrc
do
    # echo $name
    shfile=${HOME}/${name}

    if [ -f $shfile ]; then
        zdebug "加载 $shfile"
        source $shfile
    fi
done

