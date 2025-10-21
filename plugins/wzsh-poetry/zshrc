. ${WZSH_HOME}/plugins/wzsh-poetry/aliases.zsh


function poetry_init() {
    # 初始化 poetry

    if [[ $POETRY_PYPI_TOKEN_PYPI ]]
    then
        zinfo 'run poetry config pypi-token.pypi $POETRY_PYPI_TOKEN_PYPI'
        poetry config pypi-token.pypi $POETRY_PYPI_TOKEN_PYPI
    fi

    # 配置国内源
    poetry config repositories.tsinghua https://pypi.tuna.tsinghua.edu.cn/simple
}

