#!/usr/bin/python3
# -*- coding:utf-8
"""\
有道翻译

Usage:
    youdao.py [query]\
"""

import sys
import time
import hashlib
import requests


def translate_print(r: dict):
    if 'errorCode' not in r:
        print('[未知错误]', file=sys.stderr)
        sys.exit(3)
    if (error := r['errorCode']) != '0':
        print(f'[翻译错误: {error}]', file=sys.stderr)
        sys.exit(3)

    # query
    print(r[key][0] if (key := 'returnPhrase') in r else r['query'], end=':')
    if 'basic' in r and 'phonetic' in r['basic']:
        print(f' [{r["basic"]["phonetic"]}]')
    else:
        print()

    # translation
    print('\n'.join(r['translation']))

    # basic
    if 'basic' in r:
        print()
        if wfs := r['basic'].get('wfs'):
            wfs_str = []
            for wf in wfs:
                wf = wf['wf']
                wfs_str.append(f'{wf["name"]}: {wf["value"]}')
            print('; '.join(wfs_str))
            print()
        print('\n'.join(r['basic']['explains']))

    # web
    if 'web' in r:
        print()
        for d in r['web']:
            print(d['key'] + ': ' + '; '.join(d['value']))

def translate(q):
    url    = 'https://openapi.youdao.com/api'
    appKey = '4a04dca27b6f86ae'
    appSec = 'ieZHB7a5NHoTcGWOJrlHMs5nFgoCe7xy'
    salt   = 'cbedf8a7-2c2a-3a13-ab92-9f5a0b7ac042'

    curtime = str(round(time.time()))
    input_q = q if len(q) <= 20 else f'{q[:10]}{len(q)}{q[-10:]}'
    sign    = bytes(appKey + input_q + salt + curtime + appSec, 'utf-8')
    sign    = hashlib.sha256(sign).hexdigest()

    try:
        req = requests.post(url, timeout=8, data={
            'q': q,
            'from': 'auto',
            'to': 'auto',
            'appKey': appKey,
            'salt': salt,
            'sign': sign,
            'signType': 'v3',
            'curtime': curtime,
            'strict': 'false',
        })
    except:
        print('[连接错误]', file=sys.stderr)
        sys.exit(2)

    if req.status_code != requests.codes.ok:
        print(f'[请求错误: {req.status_code}]', file=sys.stderr)
        sys.exit(2)

    translate_print(req.json())


if __name__ == '__main__':
    import readline

    import string
    punctuation = string.punctuation
    try:
        import zhon
        punctuation += zhon.hanzi.punctuation
    except:
        pass

    q = ''

    argc = len(sys.argv)
    if argc == 2:
        q = sys.argv[1]
    elif argc != 1:
        print(__doc__, file=sys.stderr)
        sys.exit(1)

    while True:
        q = q.strip(string.whitespace + punctuation)
        if q:
            break
        if argc == 2:
            print('[无效输入]', file=sys.stderr)
            sys.exit(1)

        try:
            q = input('[youdao]❯ ')
        except:
            print()
            sys.exit(1)

    translate(q)
