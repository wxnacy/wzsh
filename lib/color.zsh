#===============================
# Name: wxnacy's Wzsh setting
# Author: wxnacy <wxnacy@gmail.com>
# URL: https://wxnacy.com
# Created: 2022-01-21
# Modified: 2022-01-21
# Description: 颜色模块
#===============================
#
#     echo -e “\033[30m 黑色字 \033[0m”
# 　　echo -e “\033[31m 红色字 \033[0m”
# 　　echo -e “\033[32m 绿色字 \033[0m”
# 　　echo -e “\033[33m 黄色字 \033[0m”
# 　　echo -e “\033[34m 蓝色字 \033[0m”
# 　　echo -e “\033[35m 紫色字 \033[0m”
# 　　echo -e “\033[36m 天蓝字 \033[0m”
# 　　echo -e “\033[37m 白色字 \033[0m”
#
    # echo -e “\033[40;37m 黑底白字 \033[0m”
# 　　echo -e “\033[41;37m 红底白字 \033[0m”
# 　　echo -e “\033[42;37m 绿底白字 \033[0m”
# 　　echo -e “\033[43;37m 黄底白字 \033[0m”
# 　　echo -e “\033[44;37m 蓝底白字 \033[0m”
# 　　echo -e “\033[45;37m 紫底白字 \033[0m”
# 　　echo -e “\033[46;37m 天蓝底白字 \033[0m”
# 　　echo -e “\033[47;30m 白底黑字 \033[0m”
#
    # \33[0m 关闭所有属性
# 　　\33[1m 设置高亮度
# 　　\33[4m 下划线
# 　　\33[5m 闪烁
# 　　\33[7m 反显
# 　　\33[8m 消隐
# 　　\33[30m — \33[37m 设置前景色
# 　　\33[40m — \33[47m 设置背景色
# 　　\33[nA 光标上移n行
# 　　\33[nB 光标下移n行
# 　　\33[nC 光标右移n行
# 　　\33[nD 光标左移n行
# 　　\33[y;xH设置光标位置
# 　　\33[2J 清屏
# 　　\33[K 清除从光标到行尾的内容
# 　　\33[s 保存光标位置
# 　　\33[u 恢复光标位置
# 　　\33[?25l 隐藏光标
# 　　\33[?25h 显示光标

function _color() {
    # 日志输出基础函数
    local num=$1
    shift
    echo -e "\033[${num}m$@\033[0m"
}

function red() {
    _color 31 $@
}

function green() {
    _color 32 $@
}

function yellow() {
    _color 33 $@
}

function blue() {
    _color 34 $@
}

function magenta() {
    _color 35 $@
}

function cyan() {
    _color 36 $@
}

function white() {
    _color 37 $@
}

