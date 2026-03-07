alias ll="ls -l"
alias la="ls -la"
alias lh="ls -lh"
alias dfh="df -h"
alias du1="du -d 1 -h"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
if [ -f ~/.bash_profile ];then
    alias bps="source ~/.bash_profile"
    alias bpc="vim ~/.bash_profile"
fi
if [ -f ~/.profile ];then
    alias ps="source ~/.profile"
    alias pc="vim ~/.profile"
fi
alias bashrcs="source ~/.bashrc"
alias bashrc="vim ~/.bashrc"
alias bas="source ~/.bash_aliases"
alias bac="vim ~/.bash_aliases"
alias sshc="vim ~/.ssh/config"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias zshrcs="source ~/.zshrc"
alias c="clear"
alias h="history"

# autossh
alias assh="autossh -M 0 "

# fastfetch
alias ff="fastfetch"

# cmd 命令管理工具包装函数
cmd() {
    local result
    local exit_code
    
    # 调用实际的 cmd 脚本
    result=$($HOME/.wzsh/plugins/wzsh-self/bin/cmd "$@")
    exit_code=$?
    
    # 如果是搜索模式且有结果，使用 print -z 推送到输入缓冲区
    if [[ $# -eq 0 && -n "$result" && $exit_code -eq 0 ]]; then
        print -z "$result"
    else
        # 其他情况直接输出结果
        [[ -n "$result" ]] && echo "$result"
    fi
    
    return $exit_code
}
