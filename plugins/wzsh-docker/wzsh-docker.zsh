
. ${WZSH_HOME}/plugins/wzsh-docker/aliases.zsh

# 构建镜像
function dbuild(){
    docker build -t wxnacy/$1 .
}

function drun(){
    docker run -it --rm wxnacy/$1
}

