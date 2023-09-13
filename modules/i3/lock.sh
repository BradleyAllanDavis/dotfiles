#!/bin/bash

tmpfile=/tmp/lock_screenshot.png
scrot "$tmpfile"
[[ -f "$tmpfile" ]] && convert "$tmpfile" -blur 0x4 "$tmpfile"
i3lock -u -i "$tmpfile"
