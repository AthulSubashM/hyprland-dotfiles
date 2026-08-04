#!/usr/bin/env bash

STATE_FILE="/tmp/hyprsunset_temp"
LOCK_FILE="/tmp/hyprsunset_scroll.lock"
DEFAULT_TEMP=3500 # Default warm temp (K)
STEP=500          # Smaller step for smoother scaling

# Initialize temp file if missing
if [ ! -f "$STATE_FILE" ]; then
  echo "$DEFAULT_TEMP" >"$STATE_FILE"
fi

CURRENT_TEMP=$(cat "$STATE_FILE")

set_temp() {
  local target_temp=$1
  echo "$target_temp" >"$STATE_FILE"

  # Force kill any running instances and wait until CTM lock is fully released
  pkill -9 -x hyprsunset >/dev/null 2>&1
  while pgrep -x hyprsunset >/dev/null; do
    sleep 0.01
  done

  # Launch new instance detached from process tree
  nohup hyprsunset -t "$target_temp" >/dev/null 2>&1 &
}

# Debounce scroll actions using a lockfile to prevent rapid-fire process collisions
debounce_scroll() {
  if [ -f "$LOCK_FILE" ]; then
    return 1
  fi
  touch "$LOCK_FILE"
  (sleep 0.15 && rm -f "$LOCK_FILE") &
  return 0
}

case "$1" in
toggle)
  if pgrep -x "hyprsunset" >/dev/null; then
    pkill -9 -x hyprsunset >/dev/null 2>&1
  else
    set_temp "$CURRENT_TEMP"
  fi
  pkill -RTMIN+9 waybar
  ;;

down)
  debounce_scroll || exit 0

  NEW_TEMP=$((CURRENT_TEMP + STEP))
  if [ "$NEW_TEMP" -gt 6500 ]; then NEW_TEMP=6500; fi

  if pgrep -x "hyprsunset" >/dev/null; then
    set_temp "$NEW_TEMP"
  else
    echo "$NEW_TEMP" >"$STATE_FILE"
  fi
  pkill -RTMIN+9 waybar
  ;;

up)
  debounce_scroll || exit 0

  NEW_TEMP=$((CURRENT_TEMP - STEP))
  if [ "$NEW_TEMP" -lt 1000 ]; then NEW_TEMP=1000; fi

  if pgrep -x "hyprsunset" >/dev/null; then
    set_temp "$NEW_TEMP"
  else
    echo "$NEW_TEMP" >"$STATE_FILE"
  fi
  pkill -RTMIN+9 waybar
  ;;

get)
  if pgrep -x "hyprsunset" >/dev/null; then
    echo "{\"text\": \"🌙\", \"tooltip\": \"Hyprsunset: Active (${CURRENT_TEMP}K)\", \"class\": \"active\"}"
  else
    echo "{\"text\": \"☀\", \"tooltip\": \"Hyprsunset: Disabled\", \"class\": \"inactive\"}"
  fi
  ;;
esac
