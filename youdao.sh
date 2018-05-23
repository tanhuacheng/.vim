#!/bin/bash
#
# 在通知中显示鼠标选中文本的翻译结果
#
# 设置一个快捷键来调用该脚本, 可以方便地翻译任意鼠标选中的文本. 例如 <C-s>

text="$(xsel -o)"
if [ -n "$text" ]; then
    notify-send "$text" "$(youdao.py "$text")"
fi
