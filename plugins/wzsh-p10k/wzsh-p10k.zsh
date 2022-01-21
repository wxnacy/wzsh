#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-21
# Modified: 2022-01-21
# Description: p10k 相关命令
# https://github.com/romkatv/powerlevel10k
#===============================

# 加载 powerlevel10k 主题
if [ -f "${WZSH_HOME}/themes/powerlevel10k/powerlevel10k.zsh-theme" ]
then
    source "${WZSH_HOME}/themes/powerlevel10k/powerlevel10k.zsh-theme"
fi

# 加载主题配置
source ${WZSH_HOME}/plugins/wzsh-p10k/p10k.zsh

# 停止提示 p10k configure
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
