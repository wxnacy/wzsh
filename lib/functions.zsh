#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2017-08-27
# Modified: 2022-01-16
# Description: 方法脚本
#===============================

PROXY="http://127.0.0.1:1080"
no_proxy="baidu.com,wxnacy.com,localhost"

# 开启代理
function proxyon() {
    zdbug "代理地址：${PROXY}"
    export no_proxy=${no_proxy}
    export http_proxy=${PROXY}
    export https_proxy=$http_proxy
    zinfo "已开启代理"
}

# 关闭代理
function proxyoff(){
    unset http_proxy
    unset https_proxy
    zinfo "已关闭代理"
}

function proxy() {
    # 查看当前代理开启状态
    if [ $http_proxy ]
    then
        zinfo "当前已开启代理"
    else
        zinfo "当前已关闭代理"
    fi
}

# 更新 wzsh
function wzshupdate() {
    cd ~/.zsh && gpull && gsub && cd - && zsh
}

# 更新 wvim
function wvimupdate() {
    cd ~/.vim && gpull && gsub && cd -
}

function send_kindle() {
    # 发送文件到 kindle
    zinfo "准备发送文件"
    book_path=$1
    kindle=371032668@qq.com
    if [ $2 ]
    then
        kindle=$2
    fi
    filename=$(python -c "import os; print(os.path.basename('${book_path}'))")
    zinfo "${filename} -> ${kindle}"
    echo "$filename" | mutt ${kindle} -a ${book_path} -s "$filename"
    zinfo "发送完毕"
}

function p() {
    # 查看环境变量
    echo $PATH | sed 's/:/\n/g' | awk '!a[$0]++'
}

function lnsf() {
    # 软连接
    filepath=$1
    linkpath=$2

    if [[ -f $linkpath || -d $linkpath ]]
    then
        zinfo "$linkpath exists"
        return
    fi

    if [[ -f $filepath || -d $filepath ]]
    then
        ln -sf $filepath $linkpath
        zinfo "Linked: $filepath ==> $linkpath"
    else
        zwarn "$filepath not found"
    fi
}

function dotall() {
    # 安装所有 dotfile
    local dotfile=$1
    if [[ ! $dotfile ]]
    then
        dotfile=${WZSH_HOME}/data/dotfile_kv
    fi
    zinfo "使用 dotfile: ${dotfile}"

    cat ${dotfile} | while read line
    do

        # 判断是否 # 开头
        local is_note=$(echo $line | grep "^#")
        if [[ "$is_note" != "" ]]
        then
            zinfo "$line"
        else
            local filepath=`echo $line | awk '{print $1}'`
            filepath=${filepath//\${HOME}/${HOME}}
            filepath=${filepath//\$HOME/$HOME}
            local linkpath=`echo $line | awk '{print $2}'`
            linkpath=${linkpath//\${HOME}/${HOME}}
            linkpath=${linkpath//\$HOME/$HOME}
            if [[ "$filepath" != "" ]]
            then
                lnsf "$filepath" $linkpath
            fi
        fi
    done

}

function cpwd() {
    # 复制当前目录并输出
    local _pwd=$(pwd)
    if [[ $(has_command pbcopy) ]]
    then
        # echo $_pwd | pbcopy
        echo -n `echo -n $(pwd) | sed 's/ /\\ /g'` | pbcopy
    fi
    echo $_pwd
}

function dirsize() {
    # 查看目录大小
    # 当前目录文件大小
    # > dirsize
    # 当前目录文件大小，格式化输出
    # > dirsize -h
    # ~/Downloads 文件大小，格式化输出
    # > dirsize -h ~/Downloads
    local first=$1
    local second=$2
    local dir=$first
    local is_fmt=''
    if [[ $first == '-h' ]]
    then
        dir=''
        is_fmt=true
        if [[ $second ]]
        then
            dir=$second
        fi
    fi

    if [[ $second == '-h' ]]
    then
        is_fmt=true
    fi

    if [[ $dir ]]
    then
        if [[ ! -d $dir ]]
        then
            echo 'no such directory:' $dir
            return
        fi
        cd $dir
    fi
    local _dirsize=$(du -d 1 | awk '{sum += $1} END {print sum}' 2>/dev/null)
    local _filesize=$(ls -l | awk '{sum += $5} END {print sum}' 2>/dev/null)
    local total=$(( _dirsize + _filesize ))
    if [[ $is_fmt ]]
    then
        format_size $total
    else
        echo $total
    fi
    if [[ $dir ]]
    then
        cd - > /dev/null
    fi
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
