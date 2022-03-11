# http://zsh.sourceforge.net/Intro/intro_11.html#SEC11
# http://zshwiki.org/home/
# http://mindonmind.github.io/notes/linux/zsh_bindkeys.html
# bindkey '^cr' accept-and-hold
# 显示 wzsh 帮助
zle -N wzsh-help-widget
bindkey '^zh' wzsh-help-widget
