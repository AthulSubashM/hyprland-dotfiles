#!/usr/bin/env bash

ON_AC=$(cat /sys/class/power_supply/AC*/online 2>/dev/null)

PROFILE=$(tlp-stat -s | grep "TLP profile" | awk '{print $4}')

case "$1" in
toggle)
  case "$PROFILE" in
  "performance"*)
    sudo tlp balanced >/dev/null
    ;;
  "balanced"*)
    sudo tlp power-saver >/dev/null
    ;;
  *)
    sudo tlp performance >/dev/null
    ;;
  esac
  pkill -RTMIN+8 waybar
  ;;
get)
  if [ "$ON_AC" -eq 1 ]; then
    echo '{"text": "", "tooltip": "Plugged in (AC)", "class": "ac"}'
    exit 0
  fi
  case "$PROFILE" in
  "performance"*)
    echo '{"text": "", "tooltip": "TLP: Performance", "class": "performance"}'
    ;;
  "balanced"*)
    echo '{"text": "", "tooltip": "TLP: Balanced", "class": "balanced"}'
    ;;
  "power-saver"*)
    echo '{"text": "", "tooltip": "TLP: Power Saver", "class": "power-saver"}'
    ;;
  *)
    echo '{"text": "", "tooltip": "TLP: Default", "class": "balanced"}'
    ;;
  esac
  ;;
esac
