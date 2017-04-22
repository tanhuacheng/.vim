#! /bin/bash
# map Caps_Lock to <key> reenterable

function usage {
    echo "Usage: capmap <enter <key>|exit>"
}

# my Caps_Lock's keycode is 66, use "xev" to detect yours, like this:
# 1. xev | ag Caps_Lock
# 2. type Caps_Lock key
KEYCODE=66

TMPFILE="$(echo ~)/.vim/.capmap.tmp"
touch $TMPFILE

count=$(cat "$TMPFILE")
if [ -z "$count" ]; then
    count=0
fi

if [ "$1" = "enter" ]; then
    if [ -z "$2" ]; then
        usage; exit
    fi

    if [ "$count" -eq 0 ]; then
        xmodmap -e "remove Lock = Caps_Lock" -e "keycode $KEYCODE = $2"
    fi

    echo $(echo "$count+1" | bc) > $TMPFILE

elif [ "$1" = "exit" ]; then
    if [ -n "$2" ]; then
        usage; exit
    fi

    if [ "$count" -gt 0 ]; then
        echo $(echo "$count-1" | bc) > $TMPFILE
    fi

    if [ "$count" -eq 1 ]; then
        xmodmap -e "keycode 66 = Caps_Lock" -e "add Lock = Caps_Lock"
    fi
else
    usage
fi

exit
