#!/bin/sh

# Use a lock file to prevent multiple instances from running at once
LOCK_FILE="/tmp/waybar_battery_update.lock"

if [ -f "$LOCK_FILE" ]; then
    exit 0
fi

trap "rm -f $LOCK_FILE" EXIT
touch "$LOCK_FILE"

# NOTE: You may need to change BAT0 to BAT1 or another name.
# Use 'ls /sys/class/power_supply/' to find the correct name.
BATTERY_PATH="/sys/class/power_supply/BAT0"

# Get the battery status from the /sys filesystem
STATUS=$(cat "$BATTERY_PATH/status")


# Tell Waybar to update its modules.
pkill -SIGUSR2 waybar