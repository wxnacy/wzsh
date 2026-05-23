alias ll="ls -l"
alias la="ls -la"
alias lh="ls -lh"
alias dfh="df -h"
alias du1="du -d 1 -h"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
if [ -f ~/.bash_profile ]; then
    alias bps="source ~/.bash_profile"
    alias bpc="vim ~/.bash_profile"
fi
if [ -f ~/.profile ]; then
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

# proxy - 本地代理开关（作为函数运行在当前 shell，export 才能生效）
proxy() {
    local action=$1
    shift

    case "$action" in
    on)
        local p=${1:-$PROXY}
        if [[ ! ${p} ]]; then
            z log error '代理地址 $PROXY 为空，开启代理失败'
            return 1
        fi
        unset no_proxy http_proxy https_proxy all_proxy
        export no_proxy=${NO_PROXY}
        export http_proxy=${p}
        export https_proxy=$http_proxy
        export all_proxy=$http_proxy
        z log info "已开启代理: ${p}"
        ;;
    off)
        unset http_proxy https_proxy all_proxy
        z log info "已关闭代理"
        ;;
    show)
        if [[ ${http_proxy} ]]; then
            z log info "当前已开启代理: ${http_proxy}"
        else
            z log info "当前已关闭代理"
        fi
        ;;
    *)
        echo "用法: proxy <on|off|show> [proxy_url]"
        return 1
        ;;
    esac
}
