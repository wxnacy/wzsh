#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-13
# Modified: 2022-01-17
# Description: fzf 相关命令
#===============================

function f() {
    # 查找文件
    # 使用 CTRL-T 映射的方法
    dir=$1
    # __fsel $FZF_CUSTOM_PREVIEW
    rg --files --hidden $dir 2>/dev/null | \
        fzf +m --preview "${WZSH_FZF_HOME}/preview.zsh {}"
}

function fd() {
  # 搜索目录并进入
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

function fkill() {
    # 搜索并 kill 掉当前用户能 kill 的进程
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

function bml() {
    # 搜索书签命令
    local _path
    _path=$(bm list | fzf +m | awk '{print $1}')

    if [[ -d $_path ]]
    then
        cd $_path
    elif [[ -f $_path ]]
    then
        vim $_path
    elif [[ $_path ]]
    then
        open $_path
    fi
}

function pipl() {
    # 搜索 pip list
    local name
    name=$(pip list | awk 'NR > 2 {print $0}' | fzf +m | awk '{print $1}')
    if [[ $name ]]
    then
        pip show $name
    fi
}

function brewl() {
    # 搜索 brew list
    local name
    name=$(brew list | fzf +m)
    if [[ $name ]]
    then
        brew info $name
    fi
}

function brews() {
    # 搜索 brew list
    brew search $1 2>/dev/null | fzf +m
}

function brewi() {
    # 搜索 brew list
    local name
    name=$(brew search $1 2>/dev/null | fzf +m)
    if [[ $name ]]
    then
        zdbug "Run comand 'brew install ${name}'"
        brew install $name
    fi
}

function fupdate() {
    # 更新 fzf 相关信息
    wget https://raw.githubusercontent.com/wfxr/forgit/master/forgit.plugin.zsh -O ${WZSH_FZF_HOME}/forgit.plugin.zsh
}
