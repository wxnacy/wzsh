#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2021-11-21
# Modified: 2021-11-21
# Description: python 相关改写命令
#===============================

if [ -d "${HOME}/.pyenv" ]; then
    alias python3="${HOME}/.pyenv/shims/python3.12"
    alias pip3="${HOME}/.pyenv/shims/pip3.12"
fi
alias python="python3"
alias pip="pip3"
alias pipi="pip install -i https://pypi.tuna.tsinghua.edu.cn/simple"
alias pydb="python3 -m pdb"

# for hatch
alias hbp="hatch clean && hatch build && hatch publish"
