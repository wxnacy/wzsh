#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: wxnacy <wxnacy@gmail.com>
# Description: 工具模块

from datetime import date
from datetime import timedelta


def get_weekdate(day_index=0):
    """获取当前星期的日志
    :params int day_index: 星期索引 0 星期一 6 星期日 默认 0
    """
    week_index = date.today().weekday()
    monday = date.today() - timedelta(days = week_index)
    return monday + timedelta(days = day_index)

if __name__ == "__main__":
    print(get_weekdate())
    print(get_weekdate(1))
    #  print('w')
    #  print(format_float(1.23))
    #  print(format_size(111123))
    pass
