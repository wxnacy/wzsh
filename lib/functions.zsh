#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2017-08-27
# Modified: 2022-01-16
# Description: 方法脚本
#===============================


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
    # 加载全部 dotfile
    for dotfile in ${WZSH_HOME}/config/dotfile ${HOME}/Documents/Configs/dotfile
    do
        if [[ -f $dotfile ]]
        then
            dot $dotfile
        fi
    done

}
function dot() {
    # 安装所有 dotfile
    local dotfile=$1
    # if [[ ! $dotfile ]]
    # then
        # dotfile=${WZSH_HOME}/data/dotfile_kv
    # fi
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
            filepath=${filepath//\${WZSH_HOME}/${WZSH_HOME}}
            filepath=${filepath//\$WZSH_HOME/$WZSH_HOME}
            local linkpath=`echo $line | awk '{print $2}'`
            linkpath=${linkpath//\${HOME}/${HOME}}
            linkpath=${linkpath//\$HOME/$HOME}
            linkpath=${linkpath//\${WZSH_HOME}/${WZSH_HOME}}
            linkpath=${linkpath//\$WZSH_HOME/$WZSH_HOME}
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

function funcs() {
    # 列举方法

    # print -l ${(ok)functions} | while read line
    # do
        # # type $line
        # # echo $line
        # # local match=$(type $line | grep "${HOME}/.zsh")
        # if [[ $(type $line | rg "/\.zsh") ]]
        # then
            # echo $line 
            # # echo ''
        # fi
    # done | fzf +m

    # print -l ${(ok)functions} | fzf +m --preview "${WZSH_HOME}/lib/_which.zsh {}"
    # local _functions=$(print -l ${(ok)functions} | while read line; do; type $line ;done)
    # echo $_functions | rg '/Users/wxnacy/.zsh/plugins/wzsh' | awk '{print $1}' | fzf +m --preview 'which {}'

}

function __wzsh_help() {
    # 显示方法和帮助文档
    local help_files=$(zsh ${WZSH_HOME}/lib/preview_fzf.zsh __get_help_files)
    file_list=(${(@s: :)help_files})
    index=1
    jq_param=".[0]"
    for name in {1..${#file_list[@]}}
    do
        jq_param="$jq_param * .[$index]"
        index=$((index + 1))
        if [[ $index == ${#file_list[@]} ]]
        then
            break
        fi
    done
    local line=$(zsh -c "cat $help_files | jq -s '$jq_param'" \
            | jq -r 'keys[] as $k | "\($k)\t\(.[$k] | .doc)"' \
            | fzf +m --query="${LBUFFER}" \
            --preview "/bin/zsh $WZSH_HOME/lib/preview_fzf.zsh preview_help {}"
        )

    echo $line | awk '{print $1}'
    local ret=$?
    return $ret
}

function wzsh-help-widget() {
    # 显示方法和帮助文档
    # LBUFFER="${LBUFFER}$(__help)"
    LBUFFER="$(__wzsh_help)"
    local ret=$?
    zle reset-prompt
    return $ret
}

