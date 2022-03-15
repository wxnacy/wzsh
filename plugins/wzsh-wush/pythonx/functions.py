#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: wxnacy <wxnacy@gmail.com>
# Description: desc

import plotext as plt
from wush.web.response import ResponseHandler
from requests_html import HTML


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

    data = response.json()
    if data.get("status") != 0:
        print(data.get("errmsg"))
        return

    dates = data.get("data", {})[0].get("trend", {}).get("updateDate", [])
    data_list = data.get("data", {})[0].get("trend", {}).get("list", [])
    # 新增本土
    local_data = []
    for _data in data_list:
        if _data.get("name") == '新增本土':
            local_data = _data.get("data")

    days = -7
    show_names = dates[days:]
    show_nums = local_data[days:]
    for i, _name in enumerate(show_names):
        show_names[i] = f"{_name}({show_nums[i]})"


    plt.bar(show_names, show_nums, orientation = "v", width = 0.3) # or shorter orientation = 'h'
    plt.title("Most Favoured Pizzas in the World")
    plt.clc() # to remove colors
    plt.plotsize(100, 2 * len(show_names) - 1 + 4) # 4 = 1 for x numerical ticks + 2 for x axes + 1 for title
    plt.show()

