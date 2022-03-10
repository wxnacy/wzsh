. ${WZSH_HOME}/plugins/wzsh-wush/aliases.zsh
export WZSH_WUSH_HOME=${WZSH_HOME}/plugins/wzsh-wush


function wush_ttl() {
    # function_body
    local name=$1
    local cmd=$2
    local _ttl=$3
    local pyenv_ver=$(pyenv version | awk '{print $1}')
    pyenv local wush
    ttl $name $cmd $_ttl
    pyenv local $pyenv_ver
}

function bjb_jinchujing() {
    # 查看进出京
    local line=$(wush_ttl bjb_jinchujing "wush run --module bendibao --name search --params q=进出京 --config ${WZSH_WUSH_HOME}/config/config.yml --no-browser" 3600 | fzf +m)
    # local line=$(wush run --module bendibao --name search --params q=进出京 --config ${WZSH_WUSH_HOME}/config/config.yml --no-browser | fzf +m )
    if [[ $line ]]
    then
        local url=$(echo $line | awk '{print $2}')
        zinfo "打开文章 $url"
        open $url
    fi
}

if [[ $* ]]
then
    # shell main 函数
    # ./xxxx.sh func_name params1 params2
    # 就是运行 func_name 函数并传入 params1 params2 两个参数
    local cmd="$1"
    if [[ ! $cmd ]]
    then
        return
    fi
    # 将参数左移一位
    shift
    local rc=0
    $cmd "$@" || rc=$?
    # return $rc
fi
