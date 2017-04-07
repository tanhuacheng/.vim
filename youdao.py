#! /usr/bin/env python3
# -*- coding: utf-8 -*-

"""有道翻译

Usage:
    youdao.py <key_word>

Options:
    -h,--help   显示帮助菜单

Example:
    youdao.py 翻译
"""

__author__ = 'tanhuacheng'

import requests
from docopt import docopt

def translate_print (r):
    if not('errorCode' in r):
        print('未知错误')
        return

    error = r['errorCode']
    if error:
        errorCode = {20: '文本过长', 30: '无法翻译', 40: '不支持的语言', 50: '无效的 key'}
        if error in errorCode:
            print(errorCode[error])
        else:
            print('未知错误')
        return

    if not('query' in r):
        print('未知错误')
        return

    if not(('basic' in r) and ('web' in r)):
        if not('translation' in r):
            print('未知错误')
            return
        print(r['query'] + ':')
        print('\n[翻译] ' + '; '.join(r['translation']))
        return

    print(r['query'], end = ':')
    if 'basic' in r:
        if 'uk-phonetic' in r['basic']:
            if 'us-phonetic' in r['basic']:
                print(' ' + ' '.join(['英', '[{}]'.format(r['basic']['uk-phonetic']),
                                      '美', '[{}]'.format(r['basic']['us-phonetic'])]))
            else:
                print(' ' + '[{}]'.format(r['basic']['uk-phonetic']))
        elif 'us-phonetic' in r['basic']:
            print(' ' + '[{}]'.format(r['basic']['us-phonetic']))
        elif 'phonetic' in r['basic']:
            print(' ' + '[{}]'.format(r['basic']['phonetic']))
        else:
            print()

        if 'explains' in r['basic']:
            print('\n[基本]\n')
            print('\n'.join(r['basic']['explains']))
    else:
        print()

    if 'web' in r:
        print('\n[网络]\n')
        for d in r['web']:
            print(d['key'] + ': ' + '; '.join(d['value']))

def translate ():
    arguments = docopt(__doc__)
    key_word = arguments['<key_word>']

    url = ''.join(['http://fanyi.youdao.com/openapi.do?',
                   'keyfrom=tanhuacheng&',
                   'key=927344506&',
                   'type=data&',
                   'doctype=json&',
                   'version=1.1&',
                   'q={}'.format(key_word)])

    req = requests.get(url, verify = False);
    if req.text[0] != '{':
        print(req.text)
        return

    translate_print(req.json())

if __name__ == '__main__':
    translate()
