alias youtube-dl="youtube-dl --config-location ${WZSH_HOME}/plugins/wzsh-youtube-dl/config/youtube-dl.conf --proxy 127.0.0.1:${PROXY_PORT:-7890}"
alias dydl="docker run --rm -v ~/Downloads:/root/Downloads wxnacy/youtube-dl -o ~/Downloads/%(title)s.%(ext)s --proxy docker.for.mac.host.internal:1080"

# 添加 youtube-dl 后台任务
function ydl() {
    nohup youtube-dl $1 >> /tmp/ydl.log & 2>&1
}
