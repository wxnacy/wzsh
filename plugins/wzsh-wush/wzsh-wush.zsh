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

function yiqing() {
    # 查看进出京
    local city=$1
    local type=$2
    if [[ ! $type ]]
    then
        type='fzf'
    fi
    if [[ ! $city ]]
    then
        zerror "缺少参数 $city"
        return
    fi
    local isCaseIn=0
    local target='trendCity'
    for _city in 北京 天津 上海 重庆 香港 台湾
    do
        if [[ `echo $_city | grep $city` ]]
        then
            isCaseIn=1
            target='trend'
        fi
    done
    zinfo "信息来源：https://voice.baidu.com/act/newpneumonia/newpneumonia"
    wush run --module newpneumonia --name get_by_city --params area=${city} --params isCaseIn=$isCaseIn --params target=$target --config ${WZSH_WUSH_HOME}/config/config.yml --attr "{\"type\": \"${type}\"}"

    local query_city=$(echo $city | sed 's/-//g')
    local line=$(wush run --module baidu --name inner --env query_city=$query_city --config ${WZSH_WUSH_HOME}/config/config.yml --attr "{\"type\": \"${type}\"}" | fzf +m --height 30%)
    if [[ $line ]]
    then
        local url=$(echo $line | awk '{print $4}')
        echo $line
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
