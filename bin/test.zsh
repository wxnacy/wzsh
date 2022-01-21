# load lib
for name in `ls ${WZSH_HOME}/lib`
do
    shfile=${WZSH_HOME}/lib/${name}
    zinfo "加载 $shfile"

    if [ -f $shfile ]; then
        source $shfile
    fi
done

function test() {
    local s=$(_color 31 "test")
    echo -e $s
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
