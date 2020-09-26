#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
for m in $(polybar --list-monitors | cut -d":" -f1); do
    # if [ $m = "eDP-1" ]; then
    #     MONITOR=$m polybar --reload top &
    # elif [ $m = "HDMI-1" ]; then
    #     MONITOR=$m polybar --reload top-secondary &
    # fi
    WIRELESS=$(ls /sys/class/net/ | grep ^wl | awk 'NR==1{print $1}') MONITOR=$m polybar --reload mainbar-bspwm &
done

# MONITOR=$m polybar --reload top &
echo "Bars launched..."


