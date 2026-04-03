# Kiro CLI pre block. Keep at the top of this file.
# 禁用 kiro-cli 自动建议以避免与 zsh-autosuggestions 冲突
# [[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh"

# 本文件不在做 wzsh 本身不相干代码插入
zdbug $(blue "###############################################")
zdbug $(blue "加载 ~/.zprofile")
zdbug $(blue "###############################################")

# 创建临时文件目录
test -d $WZSH_TEMP || mkdir $WZSH_TEMP && zdebug '创建临时文件目录'

# 加载 config.json 插件（新逻辑）
for plugin_path in "${WZSH_PLUGIN_PATHS[@]}"; do
    shfile=${plugin_path}/zprofile
    if [[ -f $shfile ]]; then
        zdebug "加载 zprofile $plugin_path"
        source $shfile
    fi
done

# 加载插件（旧逻辑，已迁移到 config.json，暂时注释）
# for plugin in "${WZSH_PLUGINS[@]}"; do
#     name="wzsh-${plugin}"
#     shfile=${WZSH_HOME}/plugins/${name}/zprofile
#     if [ -f $shfile ]; then
#         zdebug "加载 zprofile $name"
#         source $shfile
#     fi
# done

# 加载 bash 登录配置
for name in .local/zprofile; do
    shfile=${HOME}/${name}
    if [ -f $shfile ]; then
        zdebug "加载 $shfile"
        source $shfile
    fi
done

# Kiro CLI post block. Keep at the bottom of this file.
# 禁用 kiro-cli 自动建议以避免与 zsh-autosuggestions 冲突
# [[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh"
