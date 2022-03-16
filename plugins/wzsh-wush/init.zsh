#!/usr/bin/env bash
# 插件初始化脚本

function main() {
    # 主方法
    pip install -r $(wzsh plugin home wush)/pythonx/requirements.txt
}

main
