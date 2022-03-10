# 用于预览 fzf 命令

function __get_help_files() {
    # 获取帮助文件列表
    local help_files="${WZSH_HOME}/config/help.json"

    for name in `ls ${WZSH_HOME}/plugins`
    do
        _file=${WZSH_HOME}/plugins/${name}/config/help.json

        if [ -f $_file ]; then
            help_files="${help_files} ${_file}"
        fi
    done
    echo $help_files
}

function preview_help () {
    local cmd=$1
    cmd=$(echo $cmd | awk '{print $1}')
    local help_files=$(__get_help_files)
    local doc=$(zsh -c "cat $help_files | jq -s '.[0] * .[1]'" | jq -r ".${cmd}.doc")
    echo $doc
    echo ''
    local help=$(zsh -c "cat $help_files | jq -s '.[0] * .[1]'" | jq -r ".${cmd}.help")
    echo $help
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
