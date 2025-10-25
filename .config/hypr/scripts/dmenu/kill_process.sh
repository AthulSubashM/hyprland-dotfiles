#!/bin/bash

ps -o pid,%cpu,%mem,cmd -u "$USER" --sort -%mem |
  fuzzel --dmenu --prompt="Kill Process: " |
  awk '{print $1}' |
  xargs -r kill -9
