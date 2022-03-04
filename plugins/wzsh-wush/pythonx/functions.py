#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: wxnacy <wxnacy@gmail.com>
# Description: desc

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

