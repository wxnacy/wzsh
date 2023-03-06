# 本文件不在做 wzsh 本身不相干代码插入
zdbug $(blue "###############################################")
zdbug $(blue "加载 ~/.zprofile")
zdbug $(blue "###############################################")

# 创建临时文件目录
test -d $WZSH_TEMP || mkdir $WZSH_TEMP && zdebug '创建临时文件目录'

# 加载插件
for name in `ls ${WZSH_HOME}/plugins`
do
    shfile=${WZSH_HOME}/plugins/${name}/zprofile

    if [ -f $shfile ]; then
        zdebug "加载 zprofile $name"
        source $shfile
    fi
done
