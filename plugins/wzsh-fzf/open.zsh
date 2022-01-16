#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-16
# Modified: 2022-01-16
# Description: fzf ctrl-o 使用的打开文件命令
#===============================

filepath=$1
if [[ -d $filepath ]]
then
    open $filepath
elif [[ -f $filepath ]]
then
    # https://github.com/junegunn/fzf/issues/1361
    vim $filepath < /dev/tty > /dev/tty
fi

