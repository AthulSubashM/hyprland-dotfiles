#!/bin/bash
# Check if the process or the state file exists
if pgrep -f "hyprsunset_toggle.sh --active" > /dev/null || [ -f "/tmp/hyprsunset_is_on" ]; then
  echo "true"
else
  echo "false"
fi