. ${WZSH_HOME}/plugins/wzsh-taskwarrior/aliases.zsh


function __get_wzsh_dir() {
    # 获取项目目录
    taskrc_path=$(wzsh plugin_home taskwarrior)/taskrc
    wzsh_dir=$(cat $taskrc_path | grep '^data\.location' | awk -vFS="=" '{print $2}')/wzsh
    test -d $wzsh_dir || mkdir $wzsh_dir
    echo $wzsh_dir
}

function task_project() {
    # 设置项目任务
    local name=$1
    if [[ ! $name ]]
    then
        zerror "缺少参数 {project_name}"
        return
    fi
    project_path=$(__get_wzsh_dir)/project_${name}
    # echo $project_path
    local log_path=$(__get_wzsh_dir)/task.log
    test -f $project_path || touch $project_path

    vim $project_path
    cat ${project_path} | while read line
    do
        if [[ `grep "add task: project:$name ${line} Success" $log_path` ]]
        then
            zinfo "add task: project:$name $line $(blue Already)"
        else
            task add "$line" project:$name
            zinfo "add task: project:$name $line $(cyan Success)"
            echo "add task: project:$name $line Success" >> $log_path
        fi
    done
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
