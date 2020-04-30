
# 关闭代理
function proxyoff(){
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}

# 开启代理
function proxyon() {
    export no_proxy="baidu.com,github.com,wxnacy.com"
    export http_proxy="http://127.0.0.1:1080"
    export https_proxy=$http_proxy
    echo -e "已开启代理"
}

# 后台下载视频
function yd() {
    nohup youtube-dl $1 &
}
