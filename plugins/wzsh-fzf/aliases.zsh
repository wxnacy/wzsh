#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-13
# Modified: 2022-01-16
# Description: fzf 相关改写命令
#===============================

# 搜索当前目录
# 使用 CTRL-T 映射的方法
alias f="__fsel \
    --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500' \
    --bind 'ctrl-v:execute(vim {})' \
    "
# 搜索当前用户根目录
alias fa="rg $HOME --files --hidden 2> /dev/null | f"
