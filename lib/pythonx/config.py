#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: wxnacy <wxnacy@gmail.com>
# Description: wzsh 配置解析模块
#
# 功能：
#   读取 config.json 和 config.local.json，merge 后解析每个插件的实际路径。
#
# 插件路径解析规则：
#   - 只有 name  → ${WZSH_HOME}/plugins/<name>
#   - 有 path    → 直接使用 path（本地插件或 github 本地调试优先）
#   - 只有 github → ${WZSH_DATA}/plugins/<repo-name>
#
# 用法（命令行）：
#   python3 config.py paths   # 输出所有插件路径，每行一个

import json
import os
import sys

WZSH_HOME = os.environ.get('WZSH_HOME', os.path.expanduser('~/.zsh'))
WZSH_DATA = os.environ.get('WZSH_DATA', os.path.expanduser('~/.local/share/wzsh'))
WZSH_TEMP = os.environ.get('WZSH_TEMP', '/tmp/wzsh')
CACHE_FILE = os.path.join(WZSH_TEMP, 'config.cache')


def _load_json(path: str) -> dict:
    """读取 JSON 文件，文件不存在时返回空 dict"""
    if not os.path.exists(path):
        return {}
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)


def load_config() -> dict:
    """
    读取并 merge config.json 和 config.local.json。
    local 的 plugins 追加到 config.json 的 plugins 后面。
    """
    base = _load_json(os.path.join(WZSH_HOME, 'config.json'))
    local = _load_json(os.path.join(WZSH_HOME, 'config.local.json'))

    plugins = base.get('plugins', []) + local.get('plugins', [])
    return {**base, **local, 'plugins': plugins}


def resolve_plugin_path(plugin: dict) -> str:
    """
    解析单个插件配置为实际路径。

    参数：
        plugin: 插件配置 dict，支持字段 name / path / github

    返回：
        插件目录的绝对路径
    """
    # 有 path 字段时直接使用（本地插件或 github 本地调试）
    if 'path' in plugin:
        return os.path.expandvars(os.path.expanduser(plugin['path']))

    # 只有 name → 内置插件
    if 'name' in plugin and 'github' not in plugin:
        return os.path.join(WZSH_HOME, 'plugins', plugin['name'])

    # github 插件：下载到 WZSH_DATA/plugins/<name>
    if 'github' in plugin:
        name = plugin.get('name') or plugin['github'].split('/')[-1]
        return os.path.join(WZSH_DATA, 'plugins', name)

    return ''


def get_plugin_paths() -> list[str]:
    """返回所有插件的实际路径列表（过滤空值）"""
    config = load_config()
    paths = [resolve_plugin_path(p) for p in config.get('plugins', [])]
    return [p for p in paths if p]


if __name__ == '__main__':
    cmd = sys.argv[1] if len(sys.argv) > 1 else 'paths'
    if cmd == 'paths':
        paths = get_plugin_paths()
        # 写入缓存
        os.makedirs(WZSH_TEMP, exist_ok=True)
        with open(CACHE_FILE, 'w') as f:
            f.write('\n'.join(paths) + '\n')
        for path in paths:
            print(path)
