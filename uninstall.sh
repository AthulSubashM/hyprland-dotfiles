#!/usr/bin/env bash
set -e

# Get this script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
# Target directory
TARGET_DIR="$HOME/.config"

# Installer Scripts
source "$DIR/setup/utils.sh"
source "$DIR/setup/installer.sh"

# Append modules
MODULES+=(
  "waypaper:waypaper:waypaper"
  "wal:wal:python-pywal16"
)

uninstall() {
  log_info "Starting dotfiles uninstallation..."

  SELECTED_MODULES=()

  if [[ "$#" -gt 0 ]]; then
    SELECTED_MODULES=("$@")
  else
    select_modules "uninstall"
  fi

  if [[ ${#SELECTED_MODULES[@]} -eq 0 ]]; then
    log_warn "No modules selected. Exiting..."
    exit 0
  fi

  echo ""
  log_info "Removing selected modules: ${SELECTED_MODULES[*]}"
  for mod in "${SELECTED_MODULES[@]}"; do

    local target="$TARGET_DIR/$mod"
    # GTK-3.0
    if [[ "$mod" == "blueman" ]]; then
      target="$TARGET_DIR/gtk-3.0/gtk3-$mod.css"
    fi
    # GTK-4.0
    if [[ "$mod" == "pavucontrol" ]]; then
      target="$TARGET_DIR/gtk-4.0/gtk4-$mod.css"
    fi

    if [[ -L "$target" ]]; then
      rm "$target"
      log_success "Removed symlink: $mod"
    elif [[ -d "$target" ]]; then
      log_warn "'$target' is a real directory, not a symlink. Skipping..."
    else
      log_warn "Failed to remove '$target'"
    fi
  done
}

uninstall "$@"
