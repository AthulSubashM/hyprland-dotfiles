#!/bin/bash

# Create a unique named pipe (FIFO)
pipe=$(mktemp -u)
mkfifo "$pipe"

colors=$"--color='bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8' \
  --color='fg:#CDD6F4,header:#F38BA8,info:#F5E0DC,pointer:#F5E0DC' \
  --color='marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8' \
  --color='selected-bg:#45475A' \
  --color='border:#6C7086,label:#CDD6F4'"

#    - The output of fzf is REDIRECTED (>) directly into the pipe.
alacritty --title "FZF_Search" -e sh -c "
  find \$HOME /usr /etc -type f 2>/dev/null | \
    fzf --prompt='Open File > ' \
      $colors \
      --reverse --margin 4% \
      --preview 'bat --theme \"Catppuccin Mocha\" --color=always {}' --preview-window down,10 \
  > '$pipe'
" &

RESULT=$(cat "$pipe")
rm -f "$pipe"

[ -z "$RESULT" ] && exit

kitty -e nvim "$RESULT"
