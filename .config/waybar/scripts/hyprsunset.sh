#!/usr/bin/env bash

STATE_FILE="/tmp/hyprsunset_temp"
NOTIF_STATE_FILE="/tmp/hyprsunset_notif.state"
CHANGING_LOCK="/tmp/hyprsunset_changing.lock"
PENDING_TEMP_FILE="/tmp/hyprsunset_pending.pid"

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

apply_hyprsunset() {
  local target_temp=$1
  touch "$CHANGING_LOCK"

  # Kill existing hyprsunset
  pkill -9 -x hyprsunset >/dev/null 2>&1
  while pgrep -x hyprsunset >/dev/null; do
    sleep 0.01
  done

  # Launch new instance
  nohup hyprsunset -t "$target_temp" >/dev/null 2>&1 &
  (sleep 0.25 && rm -f "$CHANGING_LOCK") &
}

# Schedule a single execution after user stops scrolling for 200ms
schedule_temp_apply() {
  # Kill previous pending timer if user is still scrolling
  if [ -f "$PENDING_TEMP_FILE" ]; then
    kill "$(cat "$PENDING_TEMP_FILE")" >/dev/null 2>&1
    rm -f "$PENDING_TEMP_FILE"
  fi

  (
    sleep 0.2
    TARGET=$(cat "$STATE_FILE")
    if pgrep -x "hyprsunset" >/dev/null; then
      apply_hyprsunset "$TARGET"
    fi
    rm -f "$PENDING_TEMP_FILE"
  ) &
  echo $! >"$PENDING_TEMP_FILE"
}

case "$1" in
toggle)
  if pgrep -x "hyprsunset" >/dev/null; then
    pkill -9 -x hyprsunset >/dev/null 2>&1
    echo "OFF" >"$NOTIF_STATE_FILE"
    send_notification "OFF"
  else
    apply_hyprsunset "$CURRENT_TEMP"
    echo "ON" >"$NOTIF_STATE_FILE"
    send_notification "ON"
  fi
  pkill -RTMIN+9 waybar
  ;;

down)
  NEW_TEMP=$((CURRENT_TEMP + STEP))
  if [ "$NEW_TEMP" -gt 6500 ]; then NEW_TEMP=6500; fi

  echo "$NEW_TEMP" >"$STATE_FILE"
  pkill -RTMIN+9 waybar

  if pgrep -x "hyprsunset" >/dev/null; then
    schedule_temp_apply
  fi
  ;;

up)
  NEW_TEMP=$((CURRENT_TEMP - STEP))
  if [ "$NEW_TEMP" -lt 1000 ]; then NEW_TEMP=1000; fi

  echo "$NEW_TEMP" >"$STATE_FILE"
  pkill -RTMIN+9 waybar

  if pgrep -x "hyprsunset" >/dev/null; then
    schedule_temp_apply
  fi
  ;;

get)
  PREV_NOTIF_STATE="OFF"
  if [ -f "$NOTIF_STATE_FILE" ]; then
    PREV_NOTIF_STATE=$(cat "$NOTIF_STATE_FILE")
  fi

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
    echo "{\"text\": \"🌙\", \"tooltip\": \"Hyprsunset: Disabled\", \"class\": \"inactive\"}"
  fi
  ;;
esac
