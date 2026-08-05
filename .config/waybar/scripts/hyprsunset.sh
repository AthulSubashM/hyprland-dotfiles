#!/usr/bin/env bash

STATE_FILE="/tmp/hyprsunset_temp"
LOCK_FILE="/tmp/hyprsunset_scroll.lock"
NOTIF_STATE_FILE="/tmp/hyprsunset_notif.state"
CHANGING_LOCK="/tmp/hyprsunset_changing.lock"

DEFAULT_TEMP=3500 # Default warm temp (K)
STEP=500          # Step for temp changes

# Initialize temp file if missing
if [ ! -f "$STATE_FILE" ]; then
  echo "$DEFAULT_TEMP" >"$STATE_FILE"
fi

CURRENT_TEMP=$(cat "$STATE_FILE")

send_notification() {
  local state=$1
  if [ "$state" = "ON" ]; then
    notify-send -u normal -a "Hyprsunset" \
      "🌙 Night Light Active" "Hyprsunset enabled (${CURRENT_TEMP}K)"
  else
    notify-send -u normal -a "Hyprsunset" \
      "🌙 Night Light Disabled" "Hyprsunset turned off"
  fi
}

set_temp() {
  local target_temp=$1
  echo "$target_temp" >"$STATE_FILE"

  # Create changing lock so 'get' ignores temporary process death
  touch "$CHANGING_LOCK"

  # Force kill any running instances and wait until released
  pkill -9 -x hyprsunset >/dev/null 2>&1
  while pgrep -x hyprsunset >/dev/null; do
    sleep 0.01
  done

  # Launch new instance detached from process tree
  nohup hyprsunset -t "$target_temp" >/dev/null 2>&1 &

  # Give process a brief moment to spawn, then remove lock
  (sleep 0.2 && rm -f "$CHANGING_LOCK") &
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
    echo "OFF" >"$NOTIF_STATE_FILE"
    send_notification "OFF"
  else
    set_temp "$CURRENT_TEMP"
    echo "ON" >"$NOTIF_STATE_FILE"
    send_notification "ON"
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
  PREV_NOTIF_STATE="OFF"
  if [ -f "$NOTIF_STATE_FILE" ]; then
    PREV_NOTIF_STATE=$(cat "$NOTIF_STATE_FILE")
  fi

  # If a temp adjustment is actively restarting the binary, skip state changes & notifications
  if [ -f "$CHANGING_LOCK" ]; then
    echo "{\"text\": \"🌙\", \"tooltip\": \"Hyprsunset: Active (${CURRENT_TEMP}K)\", \"class\": \"active\"}"
    exit 0
  fi

  if pgrep -x "hyprsunset" >/dev/null; then
    if [ "$PREV_NOTIF_STATE" != "ON" ]; then
      echo "ON" >"$NOTIF_STATE_FILE"
      send_notification "ON"
    fi
    echo "{\"text\": \"🌙\", \"tooltip\": \"Hyprsunset: Active (${CURRENT_TEMP}K)\", \"class\": \"active\"}"
  else
    if [ "$PREV_NOTIF_STATE" != "OFF" ]; then
      echo "OFF" >"$NOTIF_STATE_FILE"
      send_notification "OFF"
    fi
    echo "{\"text\": \"☀\", \"tooltip\": \"Hyprsunset: Disabled\", \"class\": \"inactive\"}"
  fi
  ;;
esac
