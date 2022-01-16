#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-13
# Modified: 2022-01-13
# Description: fzf 相关命令
# Reference: https://github.com/junegunn/fzf/wiki/examples
#===============================

. ${WZSH_HOME}/lib/try-catch.zsh
export WZSH_FZF_HOME=${WZSH_HOME}/plugins/wzsh-fzf

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
# source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fzf_key_bind_file="/usr/local/opt/fzf/shell/key-bindings.zsh"
test -f $fzf_key_bind_file && source $fzf_key_bind_file


# 自定义变量
export FZF_CUSTOM_PREVIEW="
    --preview '${WZSH_FZF_HOME}/preview.zsh {}'
"
    # --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500' \
export FZF_CUSTOM_BIND="
    --bind 'ctrl-y:execute(echo -n {} | pbcopy)'
    --bind 'ctrl-o:execute(${WZSH_FZF_HOME}/open.zsh {})'
    --bind 'ctrl-O:execute(open {})'
"

export FZF_DEFAULT_COMMAND='rg --files --hidden'
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export FZF_DEFAULT_OPTS="--height 99% --layout=reverse
    ${FZF_CUSTOM_BIND}
    "
# export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS=$FZF_CUSTOM_PREVIEW

. ${WZSH_FZF_HOME}/aliases.zsh
. ${WZSH_FZF_HOME}/functions.zsh
. ${WZSH_FZF_HOME}/chrome.zsh
. ${WZSH_FZF_HOME}/git.zsh
# https:/FZF_/github.com/wfxr/forgit
. ${WZSH_FZF_HOME}/forgit.plugin.zsh
