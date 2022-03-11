. ${WZSH_HOME}/plugins/wzsh-tool/aliases.zsh

function weather() {
    # 查询天气
    local location=$1
    curl "wttr.in/${location}?lang=zh"
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
