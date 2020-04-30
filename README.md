# wzsh

zsh 快速配置脚本

**需要的依赖** `curl, git, zsh`

[Zsh 与 oh-my-zsh 安装与使用](https://wxnacy.com/2017/08/16/shell-2017-08-16-zsh-install/)


使用 `curl` 按照

```bash
$ curl -L https://raw.githubusercontent.com/wxnacy/wzsh/master/installer.sh | bash
```



```bash
$ git clone --recursive https://github.com/wxnacy/wzsh
$ cd wzsh
$ ln -sf $(pwd) ${HOME}/.zsh
$ ln -sf $(pwd)/zshenv ${HOME}/.zshenv
$ ln -sf $(pwd)/zprofile ${HOME}/.zprofile
$ ln -sf $(pwd)/zshrc ${HOME}/.zshrc
$ zsh
```

