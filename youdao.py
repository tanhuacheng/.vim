#! /usr/bin/env python3
# -*- coding: utf-8 -*-

"""命令行使用有道翻译

Usage:
    youdao.py <key_word>

Options:
    -h,--help   显示帮助菜单

Example:
    youdao.py 翻译
"""

__author__ = 'Tanhc'

import requests
from docopt import docopt


def translate_print (r):
    if not(('basic' in r) and ('web' in r)):
        print(r['query'])
        print('\n[翻译] ' + '; '.join(r['translation']))
        return

    print(r['query'] + ': ', end = '')
    if 'uk-phonetic' in r['basic']:
        if 'us-phonetic' in r['basic']:
            print(' '.join(['英', '[{}]'.format(r['basic']['uk-phonetic']),
                            '美', '[{}]'.format(r['basic']['us-phonetic'])]))
        else:
            print('[{}]'.format(r['basic']['uk-phonetic']))
    elif 'us-phonetic' in r['basic']:
        print('[{}]'.format(r['basic']['us-phonetic']))
    elif 'phonetic' in r['basic']:
        print('[{}]'.format(r['basic']['phonetic']))
    else:
        print()

    print('\n[基本]\n')
    print('\n'.join(r['basic']['explains']))

    print('\n[网络]\n')
    for d in r['web']:
        print(d['key'] + ': ' + '; '.join(d['value']))

def translate ():
    arguments = docopt(__doc__)
    key_word = arguments['<key_word>']

    url = ''.join(['http://fanyi.youdao.com/openapi.do?',
                   'keyfrom=tinxing&',
                   'key=1312427901&',
                   'type=data&',
                   'doctype=json&',
                   'version=1.1&',
                   'q={}'.format(key_word)])

    translate_print(requests.get(url, verify = False).json())


if __name__ == '__main__':
    translate()
