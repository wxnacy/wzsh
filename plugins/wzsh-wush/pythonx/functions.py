#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: wxnacy <wxnacy@gmail.com>
# Description: desc

import json
import plotext as plt
from datetime import datetime

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
        plt.clear_plot()
        plt.bar(_show_names, show_nums, orientation = "v", width = 0.2) # or shorter orientation = 'h'
        plt.title(title)
        plt.clc() # to remove colors
        plt.plotsize(100, 2 * len(_show_names) - 1 + 4) # 4 = 1 for x numerical ticks + 2 for x axes + 1 for title
        plt.show()

    def _print_bar_by_title(title, _show_names):

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

            _print_bar(title, _new_show_names, _items)


    data = response.json()
    if data.get("status") != 0:
        print(data.get("errmsg"))
        return

    dates = data.get("data", {})[0].get("trend", {}).get("updateDate", [])
    data_list = data.get("data", {})[0].get("trend", {}).get("list", [])

    days = -7
    show_names = dates[days:]

    _print_bar_by_title('新增本土', show_names)
    _print_bar_by_title('新增确诊', show_names)
    _print_bar_by_title('新增无症状', show_names)

    print('')
    print('')

@ResponseHandler.register('baidu', 'inner')
def hr_baidu_inner(response):
    """查询城市疫情"""

    attr = response.request_builder.argument.attr
    attr = json.loads(attr)
    if attr.get("type") == 'fzf':
        count = 0
        data = response.json()
        for result in data.get("Result", []):
            for item in result.get("items_v2", []):
                #  print(item)
                _results = item.get("aladdin_res", {}).get("DisplayData",
                        {}).get("resultData", {}).get("tplData",
                            {}).get("result", {}).get("result", {}).get("data", [])
                for _result in _results:
                    news = _result.get("result", {}).get("items", [])
                    for new in news:
                        et = new.get("eventTime")
                        new_time = datetime.fromtimestamp(int(et)
                            ).strftime("%Y-%m-%d %H:%M:%S")
                        title = new.get('eventDescription')
                        print(f"{new_time}\t{title}\t{new.get('eventUrl')}")
                        count += 1
                        if count >= 10:
                            break
        return
    super_function.handler_response(response)
