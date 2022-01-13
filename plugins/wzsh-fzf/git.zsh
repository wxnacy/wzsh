#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-13
# Modified: 2022-01-13
# Description: fzf git 相关命令
#===============================

gct() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function _log_id() {
    echo $@ | awk '{print $1}'
}

unalias gl
function gl() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
            FZF-EOF"
    # --preview "/Users/wxnacy/.pyenv/shims/python ${WZSH_HOME}/plugins/wzsh-fzf/utils.py index 0 '{}'" \
}

function is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

unalias gst
function gst() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} 
    --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS
    " \
        fzf -m "$@" \
        --preview "echo {} | sed 's/M //g; s/?? //g; s/D //g' | xargs git diff --color=always 2> /dev/null" \
        | while read -r item; do
    echo "$item" | awk '{print $2}'
  done
  echo
        # fzf -m "$@" --preview "echo {} | sed 's/M //g; s/?? //g' | xargs git diff > /tmp/fzf_git && echo /tmp/fzf_git | (xargs highlight -O ansi || cat ) 2> /dev/null | head -500" | while read -r item; do
}

cmd=$1
if [[ $cmd == 'gst' ]]
then
    gst
fi
