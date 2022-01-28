#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-28
# Modified: 2022-01-28
# Description: taskwarrior-tui 相关命令
#===============================

function ftask() {
    # taskwarrior-tui 命令的 fzf 改造
    action=$1
    local ids
    task | fzf +m --multi | while read line
    do
        id=$(echo $line | awk '{print $1}')
        # 判断是否位数字
        if [[ `grep '^[[:digit:]]*$' <<< $id` ]]
        then
            ids="$ids $id"
        fi
    done
    case "$action" in
        start|done)
            zinfo "run task$ids $action"
            $(task $ids $action)
            ;;
        *)
            echo $ids
            ;;
    esac
}
