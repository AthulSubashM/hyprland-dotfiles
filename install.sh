#!/usr/bin/env bash

# ==============================================================================
# Dotfiles Installer
# by Athul Subash
# # ==============================================================================

# Exit if a command fails
set -euo pipefail

# Get this script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
# Target directory to link configerations to
TARGET_DIR="$HOME/.config"
mkdir -p "$TARGET_DIR"
# Backup directory for existing configurations
BKP="$HOME/.local/share/dotfiles/backups_$(date +%Y%m%d_%H%M%S)/.config/"

# Installer Scripts
source "$DIR/setup/utils.sh"
source "$DIR/setup/backup.sh"
source "$DIR/setup/dependencies.sh"
source "$DIR/setup/gtk_merge.sh"
source "$DIR/setup/installer.sh"

# Runs main and pass any CLI arguments
run_installer "$@"
