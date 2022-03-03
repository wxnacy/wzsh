. ${WZSH_HOME}/plugins/wzsh-wush/aliases.zsh
WZSH_WUSH=${WZSH_HOME}/plugins/wzsh-wush


function bjb_jinchujing() {
    # 查看进出京
    wush run --module bendibao --name search --params q=进出京 --config ${WZSH_WUSH}/config/config.yml --no-browser
}
