#!/bin/sh
#source https://github.com/x70b1/polybar-scripts


if ! updates=$(apt list --upgradable 2>/dev/null | grep "\-security" | wc -l); then
    updates=0
fi

if [ "$updates" -gt 0 ]; then
    echo " $updates"
else
    echo "0"
fi

