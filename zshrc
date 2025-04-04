# 本文件不在做 wzsh 本身不相干代码插入
zdbug $(blue "###############################################")
zdbug $(blue "加载 ~/.zshrc")
zdbug $(blue "###############################################")

export ZSH=${HOME}/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# ZSH_THEME="bureau"
# 使用 powerlevel10k 主题，详见 plugins/wzsh-p10k/wzsh-p10k.zsh
# history-substring-search
plugins=(git python sublime autojump poetry)
if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
fi

zdbug $(yellow "开始加载本地库")
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

zdebug $(yellow "开始加载插件")
mkdir -p ~/.zfunc
# load zsh plugins
for name in `ls ${WZSH_HOME}/plugins`
do
    zdebug "加载 $name"
    # TODO: 待清理
    shfile=${WZSH_HOME}/plugins/${name}/${name}.zsh
    if [ -f $shfile ]; then
        source $shfile
    fi

    # 加载 zshrc
    shfile=${WZSH_HOME}/plugins/${name}/zshrc
    if [ -f $shfile ]; then
        source $shfile
    fi

    # 加载 zfunc
    zfunc_dir=${WZSH_HOME}/plugins/${name}/zfunc
    if [[ -d "$zfunc_dir" ]]; then
        for zfunc_name in `ls ${zfunc_dir}`
        do
            zfunc=${zfunc_dir}/${zfunc_name}
            zfunc_link="${HOME}/.zfunc/${zfunc_name}"
            zdebug "${zfunc} ==> ${zfunc_link}"
            ln -sf "${zfunc}" "${zfunc_link}"
        done
    fi
done


zdebug $(yellow "开始加载本地环境")
for name in .bash_profile .bashrc
do
    # echo $name
    shfile=${HOME}/${name}

    if [ -f $shfile ]; then
        zdebug "加载 $shfile"
        source $shfile
    fi
done

# 懒加载
fpath+="${WZSH_HOME}/zfunc";
fpath+=~/.zfunc; autoload -Uz compinit; compinit
zstyle ':completion:*' menu select
