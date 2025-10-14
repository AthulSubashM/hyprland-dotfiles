#!/bin/bash
if [ "$(cat /sys/class/power_supply/AC0/online)" -eq 0 ]; then
    systemctl suspend
fi
