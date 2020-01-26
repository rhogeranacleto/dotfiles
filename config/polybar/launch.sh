#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr" >/dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload mainbar-i3 -c ~/.config/polybar/config-main.ini &
    MONITOR=$m polybar --reload bottom -c ~/.config/polybar/config-main.ini &
  done
else
  polybar --reload mainbar-i3 -c ~/.config/polybar/config-main.ini &
  polybar --reload bottom -c ~/.config/polybar/config-main.ini &
fi
