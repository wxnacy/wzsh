#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: wxnacy <wxnacy@gmail.com>
"""
chrome 相关代码模块
"""

import json
import sys


if __name__ == "__main__":
    args = sys.argv[1:]
    action = args[0]
    if action == 'index':
        s = args[2]
        _index = int(args[1])
        print(s.split(' ')[_index])
