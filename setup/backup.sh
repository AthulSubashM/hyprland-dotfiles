#!/usr/bin/env bash

# Backup existing configuration directories
backup() {
  local target="$1"
  if [[ -e "$target" && ! -L "$target" ]]; then
    mkdir -p "$BKP"
    log_warn "Existing config found at $target."
    log_warn "Backing up to: $BKP"
    mv "$target" "$BKP"
  else
    echo "No configs at $target"
  fi
}
