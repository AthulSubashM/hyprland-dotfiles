#!/bin/bash
# Dependencies: Fuzzel and arch-wiki-lite
# Indexes search from arch-wiki-lite and then opens on browser if match is found
query=$(fuzzel --dmenu --prompt-only="󰖟 ArchWiki > ")
[ -z "$query" ] && exit

results=$(wiki-search "$query")

if [ -z "$results" ] || [[ "$results" == *"No matches found."* ]]; then
  notify-send "ArchWiki Search" "No results found for '$query'"
  exit
fi

clean_results=$(echo "$results" | awk '{$1=""; $NF=""; sub(/^[ \t]+/, ""); print}')
first_result=$(echo "$clean_results" | head -n1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

if [[ "${first_result,,}" == "${query,,}" ]]; then
  url="https://wiki.archlinux.org/title/$(echo "$first_result" | sed 's/ /_/g')"
else
  choice=$(echo "$clean_results" | fuzzel --dmenu --prompt "Select article > ")
  [ -z "$choice" ] && exit
  url="https://wiki.archlinux.org/title/$(echo "$choice" | sed 's/ /_/g')"
fi

xdg-open "$url"
