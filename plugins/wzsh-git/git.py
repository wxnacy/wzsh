#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: wxnacy(wxnacy@gmail.com)
"""
git 相关工具
"""

def conver_clone_url(*lines):
    """
    转换 clone 地址

    >>> conver_clone_url('https://github.com/wxnacy/wpy --xxx')
    >>> git@github.com:wxnacy/wpy.git -xxx
    """

    res = []
    for line in lines:
        if line.startswith('http'):
            line = line.replace('https://github.com/', 'git@github.com:')
            line = '{}.git'.format(line)

        res.append(line)
    return ' '.join(res)

def main():
    import sys
    args = sys.argv[1:]
    func_name = args[0]
    module = sys.modules[__name__]
    func = getattr(module, func_name)
    res = func(*args[1:])
    print(res)

if __name__ == "__main__":
    main()
