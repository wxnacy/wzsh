# wzsh

## 安装

zsh 快速配置脚本

**需要的依赖** `curl, git, zsh`

[Zsh 与 oh-my-zsh 安装与使用](https://wxnacy.com/2017/08/16/shell-2017-08-16-zsh-install/)

使用 `curl` 安装

```bash
curl -L https://raw.githubusercontent.com/wxnacy/wzsh/master/installer.sh | bash
```

或者手动安装

```bash
git clone --recursive https://github.com/wxnacy/wzsh
cd wzsh
ln -sf $(pwd) ${HOME}/.zsh
ln -sf $(pwd)/zshenv ${HOME}/.zshenv
ln -sf $(pwd)/zprofile ${HOME}/.zprofile
ln -sf $(pwd)/zshrc ${HOME}/.zshrc
zsh
```

## 方法

| 名称       | 描述                                                                                                                           | 样例                                           |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| proxyon    | 开启代理，<br/>可在 ~/.bashrc 中配置变量 <br/>export PROXY="http://127.0.0.1:1080" <br/>export no_proxy="baidu.com,wxnacy.com" | >$ proxyon                                     |
| proxyooff  | 关闭代理                                                                                                                       | >$ proxyoff                                    |
| pydl       | 下载 Python 版本包, 默认下载到当前目录                                                                                         | >$ pydl 2.7.12 <br/>>$ pydl 2.7.12 ~/Downloads |
| pyi        | 使用国内源下载 Python 版本包，并使用 pyenv 安装                                                                                | >$ pyi 2.7.12                                  |
| wzshupdate | 更新 wzsh 版本                                                                                                                 | >$ wzshupdate                                  |
| ydl        | 使用 youtube-dl 下载视频，并开启后台进程                                                                                       | >$ ydl <https://youtube.com/v/xxxx>            |
| gpush      | git 默认提交所有变动信息                                                                                                       | >$ gpush commit msg                            |
