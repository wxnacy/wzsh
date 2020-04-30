#!/usr/bin/env bash
# Author: wxnacy(wxnacy@gmail.com)
# Description:

WZSH_HOME=${HOME}/.wzsh

git clone --recursive https://github.com/wxnacy/wzsh -o ${WZSH_HOME}

cd ${wzsh}
ln -sf $(pwd) ${HOME}/.zsh
ln -sf $(pwd)/zshenv ${HOME}/.zshenv
ln -sf $(pwd)/zprofile ${HOME}/.zprofile
ln -sf $(pwd)/zshrc ${HOME}/.zshrc


