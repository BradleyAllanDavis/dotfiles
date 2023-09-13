#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Home
polybar lefttop &
polybar leftbottom &

polybar middletop &
polybar middlebottom &

polybar righttop &
polybar rightbottom &

echo "Bars launched..."
