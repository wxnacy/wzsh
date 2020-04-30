echo 'source ~/.zshrc'

export ZSH=${HOME}/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="bureau"
# history-substring-search
plugins=(git python sublime )
source $ZSH/oh-my-zsh.sh

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

for name in .bash_profile .bashrc
do
    # echo $name
    shfile=~/${name}

    if [ -f $shfile ]; then
        source $shfile
    fi
done

# prompt spaceship
# colorls_sh=$(dirname $(gem which colorls))/tab_complete.sh
# if [ -f $colorls_sh ]; then
    # source $colorls_sh
# fi
