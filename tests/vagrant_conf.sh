#!/usr/bin/env bash
# Author: wxnacy(wxnacy@gmail.com)
# Description:

vagrant destroy -f

cat >> Vagrantfile <<EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.provision "shell", inline: <<-SHELL
    sudo yum install -y git zsh
    curl -L https://raw.githubusercontent.com/wxnacy/wzsh/master/installer.sh | bash
    ln -sf /home/vagrant/.wzsh /home/vagrant/.zsh
    ln -sf /home/vagrant/.wzsh/zshenv /home/vagrant/.zshenv
    ln -sf /home/vagrant/.wzsh/zprofile /home/vagrant/.zprofile
    ln -sf /home/vagrant/.wzsh/zshrc /home/vagrant/.zshrc
    zsh
  SHELL
end
EOF

vagrant up
vagrant ssh
