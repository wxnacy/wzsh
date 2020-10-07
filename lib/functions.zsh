
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

# 下载指定版本 Python 包
function pydl() {
    v=$1
    d=$2
    if [ ! $d ]
    then
        d=./
    fi
    echo '准备下载 Python' $v
    curl -L https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz -o ${d}/Python-$v.tar.xz
}

# pyenv 安装 python 新版本
function pyi() {
    v=$1
    echo '准备按照 Python' $v
    curl -L https://npm.taobao.org/mirrors/python/$v/Python-$v.tar.xz -o ~/.pyenv/cache/Python-$v.tar.xz
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
