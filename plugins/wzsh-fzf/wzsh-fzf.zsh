#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-13
# Modified: 2022-01-13
# Description: fzf 相关命令
#===============================

. ${WZSH_HOME}/lib/try-catch.zsh
. ${WZSH_HOME}/plugins/wzsh-fzf/aliases.zsh

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

export FZF_DEFAULT_COMMAND='rg --files --hidden'
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export FZF_DEFAULT_OPTS="--height 99% --layout=reverse
    --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'
    --bind 'v:execute(vim {})'
    "

function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
				  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

function glog() {
  local id
  id=$(git log --oneline $* | fzf -e --multi --preview="git show {+1}") &&
  git show "$id"
}

. ${WZSH_HOME}/plugins/wzsh-fzf/chrome.zsh
