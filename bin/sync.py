#!/usr/bin/python3
# -*- coding:utf-8


import os
import re
import shutil
import threading
import subprocess

from collections import namedtuple


DEFAULT_BRANCH = 'master'
DEFAULT_PREFIX = 'https://github.com/'
DEFAULT_SUFFIX = '.git'

KNOWN_PREFIXES = ('http://', 'https://', 'git@')


Plugin = namedtuple('Plugin', ['giturl', 'branch', 'dirname', 'do'])


def _remove(root, plugins, exists):
    def plugin_reserve(plugin_exist):
        for plugin in plugins:
            if plugin.dirname == plugin_exist:
                plugins.remove(plugin)
                return plugin

        shutil.rmtree(root(plugin_exist), ignore_errors=True)
        print('remove:', plugin_exist)

    plugins_reserved = [y for y in [plugin_reserve(x) for x in exists] if y]
    removed = len(exists) - len(plugins_reserved)
    exists[:] = plugins_reserved

    return removed

def _do(home, plugin, mutex):
    for cmd in plugin.do:
        try:
            subprocess.check_output(cmd.split(), cwd=home, stderr=subprocess.STDOUT)
            mutex.acquire()
            print('do', cmd.join("''"), 'success in', plugin.dirname.join("''"))
            mutex.release()
        except subprocess.CalledProcessError as err:
            mutex.acquire()
            print('do', cmd.join("''"), 'failure in', plugin.dirname.join("''"))
            print(err.output.decode())
            mutex.release()

def _download(root, plugins, mutex, downloaded):
    def download(plg):
        try:
            subprocess.check_output(
                ['git', 'clone', '-b', plg.branch, '--recurse-submodules', plg.giturl, plg.dirname],
                cwd=root(), stderr=subprocess.STDOUT)

            mutex.acquire()
            downloaded[0] += 1
            print('downloaded from', plg.giturl.join("''"), 'into', plg.dirname.join("''"))
            mutex.release()
        except subprocess.CalledProcessError as err:
            mutex.acquire()
            print('failed to download from', plg.giturl.join("''"), 'into', plg.dirname.join("''"))
            print(err.output.decode())
            mutex.release()
            return

        _do(root(plg.dirname), plg, mutex)

    return [threading.Thread(target=download, args=(x,)) for x in plugins]

def _update(root, plugins, mutex, updated):
    def update(plg):
        home = root(plg.dirname)

        try:
            commit_old = subprocess.check_output(
                ['git', 'log', '--oneline', '-n', '1'],
                cwd=home, stderr=subprocess.STDOUT).decode().split()[0]

            subprocess.check_output(
                ['git', 'fetch', '--all'], cwd=home, stderr=subprocess.STDOUT)

            subprocess.check_output(
                ['git', 'checkout', plg.branch], cwd=home, stderr=subprocess.STDOUT)

            branchs = subprocess.check_output(
                ['git', 'branch', '-a'], cwd=home, stderr=subprocess.STDOUT).decode().split('\n')
            if any(x.endswith(plg.branch) for x in branchs):
                subprocess.check_output(['git', 'pull'], cwd=home, stderr=subprocess.STDOUT)

            subprocess.check_output(
                ['git', 'submodule', 'sync', '--recursive'], cwd=home, stderr=subprocess.STDOUT)
            subprocess.check_output(
                ['git', 'submodule', 'update', '--init', '--recursive'],
                cwd=home, stderr=subprocess.STDOUT)

            commit_new = subprocess.check_output(
                ['git', 'log', '--oneline', '-n', '1'],
                cwd=home, stderr=subprocess.STDOUT).decode().split()[0]

            if commit_new != commit_old:
                mutex.acquire()
                updated[0] += 1
                print('updated from', commit_old.join("''"),
                      'to', commit_new.join("''"),
                      'in', plg.dirname.join("''"))
                mutex.release()
            else:
                return
        except subprocess.CalledProcessError as err:
            mutex.acquire()
            updated[1] += 1
            print('failed to update', plg.dirname.join("''"))
            print(err.output.decode())
            mutex.release()
            return

        _do(home, plg, mutex)

    return [threading.Thread(target=update, args=(x,)) for x in plugins]

def _do_sync(root, plugins):
    os.makedirs(root(), exist_ok=True)
    print('syncing on', root().join("''"), '...')

    existing = os.listdir(root())

    removed = _remove(root, plugins, existing)

    mutex = threading.Lock()
    downloaded = [0]
    updated = [0, 0]

    threads = _download(root, plugins, mutex, downloaded) + \
              _update(root, existing, mutex, updated)

    [x.start() for x in threads]
    [x.join() for x in threads]

    print()
    print(removed, 'removed')
    print(downloaded[0], 'downloaded. total:', len(plugins))
    print(updated[0], 'updated,', updated[1], 'failed.', 'total:', len(existing))
    print()

def sync_directory(root, directory):
    '''
    directory: { 'dirname': dirname, 'plugins': [ plugin1, plugin2, ..., pluginn ] }
        dirname: str
        pluginn: str 或 { 'giturl': giturl, 'branch': branch, 'do': do }
            giturl: str
            branch: str
            do: str 或 [ str1, str2, ..., strn ], 可选

    关于 directory['plugins'] 的列表项(plugin)的说明:
    1. plugin 显式或隐式的表示一个 giturl 和一个 branch
    2. 如果 plugin 类型为 str, 则: giturl=plugin, branch=DEFAULT_BRANCH
    3. 如果 plugin 类型为 dict, 则: giturl=plugin['giturl'], branch=plugin['branch']
    4. 如果 giturl 不以 KNOWN_PREFIXES 中的任何一个字符串或 '/' 开始, 则前缀 DEFAULT_PREFIX
    5. 如果 giturl 不以 DEFAULT_SUFFIX 结束, 则后缀 DEFAULT_SUFFIX
    6. 如果 giturl 以 '/' 开始(绝对路径的本地仓库), 则不遵循第 5 条
    '''

    home = os.path.join(root, directory['dirname'])

    plugins = []
    for plugin in directory['plugins']:
        if isinstance(plugin, str):
            giturl = plugin
            branch = DEFAULT_BRANCH
            do = []
        else:
            giturl = plugin['giturl']
            branch = plugin['branch']
            do = plugin.get('do', [])
            if isinstance(do, str):
                do = [do]

        if not any(giturl.startswith(x) for x in KNOWN_PREFIXES + ('/',)):
            giturl = DEFAULT_PREFIX + giturl
        if not giturl.endswith(DEFAULT_SUFFIX) and not giturl.startswith('/'):
            giturl = giturl + DEFAULT_SUFFIX

        if giturl.startswith('/'):
            dirname = re.search('[^/]+(?=/?$)', giturl).group()
        else:
            dirname = re.search('[^/:]+(?=/?\.git$)', giturl).group()

        plugins.append(Plugin(giturl, branch, dirname, filter(None, do)))

    _do_sync(lambda x=None: os.path.join(home, x) if x else home, plugins)

    try:
        os.rmdir(home)
    except:
        pass

def sync_pack(root, pack):
    '''
    pack: { 'packname': packname, 'directories': [directory1, directory2, ..., directoryn] }
        packname: str
        directoryn: dict(参见 sync_directory)
    '''

    home = os.path.join(root, pack['packname'])

    for directory in pack['directories']:
        sync_directory(home, directory)

    try:
        os.rmdir(home)
    except:
        pass


if __name__ == '__main__':
    import json

    ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    CONF = os.path.join(ROOT, 'pack.json')

    home = os.path.join(ROOT, 'pack')

    with open(CONF) as fp:
        sync_pack(home, json.load(fp))

    try:
        os.rmdir(home)
    except:
        pass
