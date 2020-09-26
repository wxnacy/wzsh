
# 关闭代理
function proxyoff(){
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}

# 开启代理
function proxyon() {
    export no_proxy="baidu.com,wxnacy.com"
    export http_proxy="http://127.0.0.1:1080"
    export https_proxy=$http_proxy
    echo -e "已开启代理"
}

# 后台下载视频
function yd() {
    nohup youtube-dl $1 &
}

# pyenv 安装 python 新版本
function pyinstall() {
    v=$1
    echo $v
    curl https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz -o ~/.pyenv/cache/Python-$v.tar.xz
    pyenv install $v
}

# 更新 wzsh
function wzshupdate() {
    cd ~/.wzsh && git pull
}

# 添加 youtube-dl 后台任务
function ydl() {
    nohup youtube-dl $1 >> ${HOME}/Downloads/ydl.log & 2>&1
}
