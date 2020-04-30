echo 'source ~/.zshrc'

export ZSH=${HOME}/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="bureau"
# history-substring-search
plugins=(git python sublime )
if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
fi

# load zsh plugins
for name in `ls ${WZSH_HOME}/plugins`
do
    echo $name
    shfile=${WZSH_HOME}/plugins/${name}/${name}.zsh

    if [ -f $shfile ]; then
        source $shfile
    fi
done

# load lib
for name in `ls ${WZSH_HOME}/lib`
do
    shfile=${WZSH_HOME}/lib/${name}
    echo $shfile

    if [ -f $shfile ]; then
        source $shfile
    fi
done

# 作者机器才会默认加载 .bashrc
if [[ ${USER} == 'wxnacy' ]]; then
    for name in .bash_profile .bashrc
    do
        # echo $name
        shfile=${HOME}/${name}
        echo $shfile

        if [ -f $shfile ]; then
            source $shfile
        fi
    done
fi
# prompt spaceship
# colorls_sh=$(dirname $(gem which colorls))/tab_complete.sh
# if [ -f $colorls_sh ]; then
    # source $colorls_sh
# fi
