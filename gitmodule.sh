#!/usr/bin/env bash

git submodule add --force https://github.com/zsh-users/zsh-syntax-highlighting plugins/zsh-syntax-highlighting
git submodule add --force https://github.com/zsh-users/zsh-autosuggestions plugins/zsh-autosuggestions

# ln -sf $(PWD) ${HOME}/.tmux
# ln -sf $(PWD)/tmux.conf ${HOME}/.tmux.conf
