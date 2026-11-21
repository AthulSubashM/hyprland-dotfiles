#!/bin/sh
BUS=3
CACHE="/tmp/asus_brightness"

[ -f "$CACHE" ] && val=$(cat "$CACHE") || val=$(ddcutil --bus $BUS --terse getvcp 10 | awk '{print $4}')
val=${val:-50}

# If called with "get" (or no args), output JSON for Waybar and exit
if [ -z "$1" ] || [ "$1" = "get" ]; then
  echo "$val" >"$CACHE"
  printf '{"percentage": %d, "tooltip": "ASUS Brightness: %d%%"}\n' "$val" "$val"
  exit 0
fi

# Otherwise adjust brightness (+10, -10, etc.)
val=$((val + $1))
[ $val -gt 100 ] && val=100
[ $val -lt 0 ] && val=0
echo "$val" >"$CACHE"

# Update Waybar immediately via signal 8
pkill -RTMIN+8 waybar

notify-send -a asus-brightness \
  -t 1500 \
  -h int:value:$val \
  -h string:x-canonical-private-synchronous:asus-brightness \
  "󰃠 ${val}%" &
ddcutil --bus $BUS --noverify setvcp 10 $val &
