# 本文件不在做 wzsh 本身不相干代码插入
zdbug $(blue "###############################################")
zdbug $(blue "加载 ~/.zshrc")
zdbug $(blue "###############################################")

export ZSH=${HOME}/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# ZSH_THEME="bureau"
# 使用 powerlevel10k 主题，详见 plugins/wzsh-p10k/zshrc
# history-substring-search
plugins=(git python autojump poetry)
if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
fi
source ${WZSH_HOME}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${WZSH_HOME}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
# load zsh plugins
for plugin in "${WZSH_PLUGINS[@]}"; do
    name="wzsh-${plugin}"
    # 加载 zshrc
    shfile=${WZSH_HOME}/plugins/${name}/zshrc
    if [ -f $shfile ]; then
        source $shfile
    fi
done

zdebug $(yellow "开始加载本地环境")
for name in .local/zshrc
do
    shfile=${HOME}/${name}
    if [ -f $shfile ]; then
        zdebug "加载 $shfile"
        source $shfile
    fi
done

# 懒加载
fpath=(${WZSH_HOME}/completions $fpath) # 命令补全目录
fpath+="${WZSH_HOME}/zfunc";
fpath+=~/.zfunc; autoload -Uz compinit; compinit
zstyle ':completion:*' menu select

# 计算加载时间
if [ -n "$ZSH_START_TIME" ]; then
    ZSH_END_TIME=$(/usr/bin/python3 -c 'import time; print(int(time.time() * 1000))')
    ZSH_LOAD_TIME=$(printf "%.3f\n" $(echo "($ZSH_END_TIME - $ZSH_START_TIME)/1000" | bc -l))
    zdebug "Zsh load time: ${ZSH_LOAD_TIME}s"
fi
