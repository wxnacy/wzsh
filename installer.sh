#!/usr/bin/env bash
# Author: wxnacy(wxnacy@gmail.com)
# Description:

for i in git ;do
    if [ ! `command -v git` ];then
        echo 'Install Wzsh failed'
        echo 'Wzsh need git'
        exit 0
    fi
done

W_HOME=${HOME}/.wzsh

test -d ${W_HOME} || git clone --recursive https://github.com/wxnacy/wzsh ${W_HOME}


echo 'The final step is to complete the configuration of Wzsh'
echo 'Run these commands'
echo ''
echo -n -e "\t"
echo 'ln -sf ${HOME}/.wzsh ${HOME}/.zsh'
echo -n -e "\t"
echo 'ln -sf ${HOME}/.wzsh/zshenv ${HOME}/.zshenv'
echo -n -e "\t"
echo 'ln -sf ${HOME}/.wzsh/zprofile ${HOME}/.zprofile'
echo -n -e "\t"
echo 'ln -sf ${HOME}/.wzsh/zshrc ${HOME}/.zshrc'
echo -n -e "\t"
echo 'zsh'
