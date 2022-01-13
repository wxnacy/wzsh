#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Author: wxnacy <wxnacy@gmail.com>
"""
chrome 相关代码模块
"""

import json
import sys

from os.path import expanduser

bookmarks_path = '~/.config/google-chrome/Default/Bookmarks'
if sys.platform == 'darwin':
    bookmarks_path = "~/Library/Application Support/Google/Chrome/Default/Bookmarks"

BOOKMARKS_PATH = expanduser(bookmarks_path)
with open(BOOKMARKS_PATH, 'r') as f:
    chrome_bookmarks = json.loads(f.read())

def read_chrome_bookmarks():

    items = chrome_bookmarks['roots']['bookmark_bar']['children']
    res = []

    def _children(items):
        for item in items:
            type = item['type']
            name = item['name']
            if type == 'url':
                wf = dict(
                    title = name,
                    subtitle = item['url'],
                    icon = './icon/chrome.png',
                    valid = True,
                )
                wf['arg'] = wf['subtitle']
                res.append(wf)
            if type == 'folder':
                if name == 'vi':
                    continue
                _children(item['children'])

    _children(items)
    return res

def print_bookmarks():
    items = read_chrome_bookmarks()
    for item in items:
        print('{}\t{}'.format(item['title'], item['arg']))

if __name__ == "__main__":
    import sys
    args = sys.argv[1:]
    action = args[0]
    if action == 'print_bookmarks':
        print_bookmarks()
