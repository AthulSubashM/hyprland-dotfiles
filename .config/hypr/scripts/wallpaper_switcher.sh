#!/bin/bash

WALLDIR="$HOME/Pictures/Wallpapers"

WALL=$(find "$WALLDIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.webp" \) | shuf -n 1)

swww img "$WALL" --transition-type random --transition-duration 2
