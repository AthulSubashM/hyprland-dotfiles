#!/usr/bin/env bash

get_aur_helper() {
  if command -v yay >/dev/null 2>&1; then
    echo "yay"
  elif command -v paru >/dev/null 2>&1; then
    echo "paru"
  else
    echo ""
  fi
}

# Check and prompt user to install missing packages
check_installed() {
  local bin="$1"
  local pkg="$2"

  if [[ -n "$bin" && ! -x "$(command -v "$bin")" ]]; then
    log_warn "Dependency '$bin' is not installed."

    local aur_helper
    aur_helper="$(get_aur_helper)"
    if [[ -z "$aur_helper" ]]; then
      log_err "No AUR helper found. Please install yay or paru, or install '$pkg' manually."
      return
    fi

    read -rp "Install '$pkg' using '$aur_helper'? [y/n]: " input
    if [[ "$input" =~ ^[Yy]$ ]]; then
      "$aur_helper" -S --noconfirm "$pkg" || log_err "Failed to install $pkg via $aur_helper."
    fi
  fi
}

# Install dependencies
install_deps() {
  log_info "Checking system dependencies..."

  local aur_helper
  aur_helper="$(get_aur_helper)"

  # Format: "binary_name:package_name"
  local packages=(
    "awww:awww"
    "waypaper:waypaper"
    "wal:python-pywal16"
  )

  for entry in "${packages[@]}"; do
    local bin="${entry%%:*}"
    local pkg="${entry#*:}"

    if ! command -v "$bin" >/dev/null 2>&1; then
      log_warn "'$bin' (package: $pkg) not found, installing..."
      "$aur_helper" -S --noconfirm "$pkg"
    else
      log_info "'$bin' is already installed."
    fi

    if [[ $bin != "awww" ]]; then
      symlink "$DIR/.config/$bin" "$TARGET_DIR/$bin"
    fi
  done
}
