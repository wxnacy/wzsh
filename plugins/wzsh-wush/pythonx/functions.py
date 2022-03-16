#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: wxnacy <wxnacy@gmail.com>
# Description: desc

import json
import plotext as plt

from wush.web.response import ResponseHandler
from wush.config.function import load_super_function
from requests_html import HTML

super_function = load_super_function()


@ResponseHandler.register('bendibao', 'search')
def hr_bendibao_search(response):

    html = HTML(html = response.content)
    for item in html.find('#results > div.result'):
        a_doc = item.find('a')[0]
        title = a_doc.text
        url = a_doc.attrs.get("href")
        span_doc = item.find('span.c-showurl')[0]
        _, _date = span_doc.text.split(' ')
        print(f'{_date}\t{url}\t{title}')

@ResponseHandler.register('newpneumonia', 'get_by_city')
def hr_newpneumonia_get_by_city(response):
    """获取城市疫情数据"""

    attr = response.request_builder.argument.attr
    attr = json.loads(attr)
    if attr.get("type") == 'origin':
        super_function.handler_response(response)
        return

    def _print_bar(title, _show_names, show_nums):

        print('')
        plt.bar(_show_names, show_nums, orientation = "v", width = 0.3) # or shorter orientation = 'h'
        plt.title(title)
        plt.clc() # to remove colors
        plt.plotsize(100, 2 * len(_show_names) - 1 + 4) # 4 = 1 for x numerical ticks + 2 for x axes + 1 for title
        plt.show()
        #  plt.clear()

    def _print_by_title(title, _show_names):

        _items = []
        for _data in data_list:
            if _data.get("name") == title:
                _items = _data.get("data")
        if _items:
            _items = _items[-len(_show_names):]
            _new_show_names = []
            for i, _name in enumerate(_show_names):
                name = f"{_name}({_items[i]})"
                _new_show_names.append(name)

            print(_new_show_names, _items)
            _print_bar(title, _new_show_names, _items)


    data = response.json()
    if data.get("status") != 0:
        print(data.get("errmsg"))
        return

    dates = data.get("data", {})[0].get("trend", {}).get("updateDate", [])
    data_list = data.get("data", {})[0].get("trend", {}).get("list", [])

    days = -7
    show_names = dates[days:]

    _print_by_title('新增本土', show_names)

    _print_by_title('新增无症状', show_names)
