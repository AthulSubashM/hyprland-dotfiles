#!/bin/bash

# Toggle Bluetooth power state
bluetoothctl show | grep -q 'Powered: yes' && bluetoothctl power off || bluetoothctl power on

# Wait a moment for the state to settle
sleep 0.5

# Check the new state of Bluetooth and send a notification
if bluetoothctl show | grep -q 'Powered: yes'; then
    # Bluetooth is now on
    notify-send "Bluetooth" "Bluetooth has been turned on." --icon=bluetooth
else
    # Bluetooth is now off
    notify-send "Bluetooth" "Bluetooth has been turned off." --icon=bluetooth-disabled
fi