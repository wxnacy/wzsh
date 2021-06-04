# echo '.zprofile' >> /tmp/zshmsg
# echo '.zprofile'
echo 'source ~/.zprofile'

# for wshell
if [ -d "${HOME}/.wshell" ]; then
    export WS_HOME="${HOME}/.wshell"
    export PATH=$PATH:${WS_HOME}/bin
fi

# for pyenv
if [ -d "${HOME}/.pyenv" ]; then
    # https://github.com/pyenv/pyenv#basic-github-checkout
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    # config for vim plugin YouComplateMe
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)";
fi

# for nvm
if [ -d "${HOME}/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion"  ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# for homebrew
if [ -d "/usr/local/Homebrew" ]; then
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles #ckbrew
    eval $(/usr/local/Homebrew/bin/brew shellenv) #ckbrew
fi

# for python
# source /usr/local/opt/autoenv/activate.sh

# CFLAGS="-I$(brew --prefix openssl)/include" \
# LDFLAGS="-L$(brew --prefix openssl)/lib"
