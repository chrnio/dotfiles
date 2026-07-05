#!/bin/sh

while true; do
  BAT=$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' | head -n1)

  if [ -n "$BAT" ]; then
    printf "[%s%%] %s\n" \
      "$(cat "$BAT/capacity")" \
      "$(date '+%a %d %b | %H:%M')"
  else
    date '+%a %d %b | %H:%M'
  fi

  sleep 30
done
