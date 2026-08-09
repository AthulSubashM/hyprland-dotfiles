#!/usr/bin/env bash

# Append custom CSS imports to an existing GTK file
merge_gtk_css() {
  local src="$1"
  local target="$2"
  local file="$3"

  mkdir -p "$target"

  # Symlink the file
  symlink "$src/$file" "$target/$file"

  # Add the import statement to gtk.css
  local target_gtk_css="$target/gtk.css"
  local import_line="@import \"$file\";"

  if [[ ! -f "$target_gtk_css" ]]; then
    echo "$import_line" >"$target_gtk_css"
    log_success "Created new gtk.css with import."
  else
    if ! grep -qF "$import_line" "$target_gtk_css"; then
      echo -e "\n$import_line" >>"$target_gtk_css"
      log_success "Appended import to gtk.css: $import_line"
    else
      log_info "Import already exists in gtk.css."
    fi
  fi
}
