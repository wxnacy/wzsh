
function __is_ttl() {
    # 文件是否过期
    local name=$1
    local ttl=$2
    local ts=$(date "+%s")
    local old_filepath=$(ls -l ${WZSH_TEMP} | grep ${name} | awk '{print $NF}')
    if [[ ! $old_filepath ]]
    then
        echo 'true'
        return
    fi
    local old_ts=$(echo $old_filepath | awk -vFS='.' '{print $NF}')
    # 时间差
    local td=$((ts - old_ts))
    if [[ $((td > ttl)) == '1' ]]
    then
        echo 'true'
    else
        echo 'false'
    fi
}

function __ttl_save_data() {
    # 保存数据，并负载有效期
    local name=$1
    local data=$2
    local ts=$(date "+%s")
    local new_filepath=${WZSH_TEMP}/${name}.$ts
    test $(ls $WZSH_TEMP | grep ${name}) && rm $WZSH_TEMP/${name}.* 2>/dev/null
    echo $data > $new_filepath
}

function __get_ttl_path() {
    # 获取定期地址
    local name=$1
    local old_filepath=$(ls -l ${WZSH_TEMP} | grep ${name} | awk '{print $NF}')
    echo ${WZSH_TEMP}/$old_filepath
}

function ttl() {
    # function_body
    local name=$1
    name="ttl_${name}"
    local cmd=$2
    local ttl=$3

    if [[ $(__is_ttl $name $ttl) == 'true' ]]
    then

        local pyenv_ver=$(pyenv version | awk '{print $1}')
        pyenv local wush
        data=$(/bin/zsh -c $cmd)
        __ttl_save_data $name "$data" $ttl
        pyenv local $pyenv_ver
    fi
    cat $(__get_ttl_path $name)
}

function ttl_clear() {
    # 清理 ttl 数据
    local name=$1
    for _name in `ls ${WZSH_TEMP} | grep $name`
    do
        zinfo "清理缓存文件 $_name"
        rm ${WZSH_TEMP}/$_name
    done
}


if [[ $* ]]
then
    # shell main 函数
    # ./xxxx.sh func_name params1 params2
    # 就是运行 func_name 函数并传入 params1 params2 两个参数
    local cmd="$1"
    # 将参数左移一位
    shift
    local rc=0
    $cmd "$@" || rc=$?
    return $rc
fi
