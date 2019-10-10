#!/usr/bin/python3
# -*- coding:utf-8


"""\
有道翻译

Usage:
    youdao.py [sentence]\
"""

__author__ = 'tanhuacheng'


import sys
import requests


def translate_print(r):
    if not('errorCode' in r):
        print('[未知错误]', file=sys.stderr)
        sys.exit(2)

    error = r['errorCode']
    if error:
        errorCode = {20: '文本过长', 30: '无法翻译', 40: '不支持的语言', 50: '无效的 key'}
        if error in errorCode:
            print(errorCode[error].join('[]'), file=sys.stderr)
        else:
            print('[未知错误]', file=sys.stderr)
        sys.exit(2)

    if not('query' in r):
        print('[未知错误]', file=sys.stderr)
        sys.exit(2)

    if not(('basic' in r) and ('web' in r)):
        if not('translation' in r):
            print('[未知错误]', file=sys.stderr)
            sys.exit(2)

        print(r['query'] + ':')
        print('\n' + '; '.join(r['translation']))
        sys.exit()

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
            print('\n' + '\n'.join(r['basic']['explains']))
    else:
        print()

    if 'web' in r:
        print()
        for d in r['web']:
            print(d['key'] + ': ' + '; '.join(d['value']))

def translate(sentence):
    url = ''.join(['http://fanyi.youdao.com/openapi.do?',
                   'keyfrom=tanhuacheng&',
                   'key=927344506&',
                   'type=data&',
                   'doctype=json&',
                   'version=1.1&',
                   'q={}'.format(sentence)])

    try:
        req = requests.get(url, verify=False, timeout=10)
    except:
        print('[连接错误]', file=sys.stderr)
        sys.exit(2)

    translate_print(req.json())


if __name__ == '__main__':
    import readline

    sentence = ''

    argc = len(sys.argv)
    if argc == 2:
        sentence = sys.argv[1]
    elif argc != 1:
        print(__doc__, file=sys.stderr)
        sys.exit(1)

    while True:
        sentence = sentence.strip(' \t\r\n,.:;')
        if sentence:
            break

        try:
            sentence = input('请输入> ')
        except:
            sys.exit()

    translate(sentence)
