#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-17
# Modified: 2022-01-17
# Description: fzf preview 命令
#===============================

filepath=$1
if [[ -d $filepath ]]
then
    # rg $filepath --files --hidden 2> /dev/null
    $FZF_DEFAULT_COMMAND $filepath 2> /dev/null
elif [[ -f $filepath ]]
then
    (highlight -O ansi $filepath || cat $filepath) 2> /dev/null | head -500
fi

