# Uage: curl https://raw.githubusercontent.com/wxnacy/wzsh/master/lib/aliases.zsh -o ~/.bash_aliases
# for git
alias gst="git status"
alias gb="git branch"
alias gt="git tag -l"

# for system
alias cpwd="echo -n `echo -n $(pwd) | sed 's/ /\\ /g'` | pbcopy"
alias ll="ls -l"
alias la="ls -la"
alias lh="ls -lh"
alias dfh="df -h"
alias du1="du -d 1 -h"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
if [ -f ~/.bash_profile ];then
    alias bps="source ~/.bash_profile"
    alias bpc="vim ~/.bash_profile"
fi
if [ -f ~/.profile ];then
    alias bps="source ~/.profile"
    alias bpc="vim ~/.profile"
fi
alias bashrcs="source ~/.bashrc"
alias bashrc="vim ~/.bashrc"
alias bas="source ~/.bash_aliases"
alias bac="vim ~/.bash_aliases"
alias sshc="vim ~/.ssh/config"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias zshrcs="source ~/.zshrc"
alias c="clear"
alias h="history"

# for docker
# alias docker="sudo docker"

# for vagrant
alias vg="vagrant"
alias vgreup="vagrant destroy -f && vagrant up"
alias vgd="vagrant destroy -f"

# autossh
alias assh="autossh -M 0 "

# python
alias pipi="pip install -i https://pypi.tuna.tsinghua.edu.cn/simple"
alias pydb="python -m pdb"
