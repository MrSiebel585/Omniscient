#!/bin/bash

OMNI_ROOT="/opt/omniscient"

function list_modules() {
  echo "================= Dynamic Omniscient Modules ================="
  echo "Scanning $OMNI_ROOT for top-level modules..."
  echo
  dirs=()
  for d in "$OMNI_ROOT"/*/; do
    [[ -d "$d" ]] && dirs+=("$(basename "$d")")
  done
  echo "Modules detected: ${#dirs[@]}"
  echo
}

function select_menu() {
  PS3=$'\nSelect a module to explore (or type Ctrl+C to exit): '
  select module in "${dirs[@]}"; do
    if [[ -n "$module" ]]; then
      echo
      echo "🔍 Entering $module..."
      cd "$OMNI_ROOT/$module" || { echo "⚠️ Failed to enter directory."; break; }
      exec bash  # start a subshell in the module dir
    else
      echo "❌ Invalid choice."
    fi
  done
}

list_modules
select_menu
