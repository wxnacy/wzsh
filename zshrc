# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# NOTE: 必须放在 zshrc 最开始执行
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 本文件不在做 wzsh 本身不相干代码插入
zdbug $(blue "###############################################")
zdbug $(blue "加载 ~/.zshrc")
zdbug $(blue "###############################################")

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
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select

# 计算加载时间
if [ -n "$ZSH_START_TIME" ]; then
    ZSH_END_TIME=$(/usr/bin/python3 -c 'import time; print(int(time.time() * 1000))')
    ZSH_LOAD_TIME=$(printf "%.3f\n" $(echo "($ZSH_END_TIME - $ZSH_START_TIME)/1000" | bc -l))
    zdebug "Zsh load time: ${ZSH_LOAD_TIME}s"
fi
