#!/usr/bin/env bash

# Format: "module_name:binary_name:package_name"
MODULES=(
  "hypr:Hyprland:hyprland"
  "waybar:waybar:waybar"
  "pavucontrol:pavucontrol:pavucontrol"
  "blueman:blueman-manager:blueman"
  "mako:mako:mako"
  "swayosd:swayosd-server:swayosd"
  "wlogout:wlogout:wlogout"
  "fuzzel:fuzzel:fuzzel"
  "kitty:kitty:kitty"
  "alacritty:alacritty:alacritty"
  "nvim:nvim:neovim"
  "yazi:yazi:yazi"
)

# Create symlinks
symlink() {
  local src="$1"
  local dest="$2"

  backup "$dest"
  ln -sfn "$src" "$dest"
  log_success "Symlinked: $src -> $dest"
}

# Symlink selected config files to ~/.config
link_modules() {
  local mod="$1"

  local bin=""
  local pkg=""

  # Prase the MODULES array to find bin and pkg names
  for entry in "${MODULES[@]}"; do
    local name="${entry%%:*}"
    local rest="${entry#*:}"
    if [[ "$name" == "$mod" ]]; then
      bin="${rest%%:*}"
      pkg="${rest#*:}"
      break
    fi
  done

  # Check dependencies
  [[ -n "$bin" ]] && check_installed "$bin" "$pkg"

  # If module is GTK based, then add css file and append to gtk.css
  # GTK-3.0
  if [[ "$mod" == "blueman" ]]; then
    local gtk_style="gtk3-$mod.css"
    merge_gtk_css "$DIR/.config/gtk-3.0" "$TARGET_DIR/gtk-3.0" "$gtk_style"
    return
  fi
  # GTK-4.0
  if [[ "$mod" == "pavucontrol" ]]; then
    local gtk_style="gtk4-$mod.css"
    merge_gtk_css "$DIR/.config/gtk-4.0" "$TARGET_DIR/gtk-4.0" "$gtk_style"
    return
  fi

  # Link config files to ~/.config/
  if [[ -d "$DIR/.config/$mod" ]]; then
    symlink "$DIR/.config/$mod" "$TARGET_DIR/$mod"
  else
    log_warn "Module directory '$DIR/.config/$mod' does not exist. Skipping..."
  fi
}

# Selection Menu
select_modules() {
  local mode="$1"
  echo -e "${CYAN}---- Available Dotfiles ----${NC}"
  echo " 0) ALL"
  local i=1
  local mod_names=()
  for mod in "${MODULES[@]}"; do
    local name="${mod%%:*}"
    mod_names+=("$name")
    printf "%2d) %s\n" "$i" "$name"
    ((i++))
  done

  echo ""
  read -rp "Select modules to $mode (eg. 1 2 5 or 0 ): " input

  local selected=()
  input="${input//,/ }"

  for num in $input; do
    if [[ "$num" == "0" ]]; then
      SELECTED_MODULES=("${mod_names[@]}")
      return
    elif [[ "$num" =~ ^[0-9]+$ ]] && ((num >= 1 && num <= ${#mod_names[@]})); then
      selected+=("${mod_names[$((num - 1))]}")
    else
      log_warn "Invalid selection: '$num'"
    fi
  done

  SELECTED_MODULES=("${selected[@]}")
}

# Post install commands
post_install() {
  local wallpaper="$TARGET_DIR/waypaper/fishing_stars.jpg"
  local wal_dir="$HOME/.cache/wal"
  local hypr_theme_dir="$TARGET_DIR/hypr/settings/themes"

  if [[ -f "$wallpaper" ]]; then
    log_info "Generating initial pywal theme from $wallpaper..."
    wal -i "$wallpaper" --cols16 -q || true
    log_success "Pywal colors generated from $wallpaper"
  else
    log_warn "Wallpaper '$wallpaper' not found. Skipping initial Pywal theme generation."
  fi

  # Symlinks from ~/.cache/wal
  mkdir -p "$TARGET_DIR/wal/colors"
  ln -sfn "$wal_dir/colors-waybar.css" "$TARGET_DIR/wal/colors/colors.css"
  log_success "Linked $wal_dir/colors-waybar.css -> $TARGET_DIR/wal/colors/colors.css"

  if [[ -d "$hypr_theme_dir" ]]; then
    ln -sfn "$wal_dir/colors.lua" "$hypr_theme_dir/colors.lua"
    log_success "Linked $wal_dir/colors.lua -> $hypr_theme_dir/colors.lua"
  fi
}

# Main function, run with CLI args or show menu
run_installer() {
  SELECTED_MODULES=()

  if [[ "$#" -gt 0 ]]; then
    SELECTED_MODULES=("$@")
  else
    select_modules "install"
  fi

  if [[ ${#SELECTED_MODULES[@]} -eq 0 ]]; then
    log_warn "No modules selected. Exiting..."
    exit 0
  fi

  install_deps

  echo ""
  log_info "Adding selected modules: ${SELECTED_MODULES[*]}"
  for mod in "${SELECTED_MODULES[@]}"; do
    echo ""
    log_info "Configuring: $mod"
    link_modules "$mod"
  done

  echo ""
  log_success "Running post installation scripts..."
  post_install
  echo ""
  log_success "Installation complete!!!"

}
