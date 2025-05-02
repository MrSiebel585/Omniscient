#!/bin/bash

OMNI_ROOT="/opt/omniscient"
LOG="$OMNI_ROOT/logs/omniscient_menu.log"
mkdir -p "$(dirname "$LOG")"
trap "echo -e '\n[INFO] Exiting menu. Goodbye!'; exit 0" SIGINT

function log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG"
}

function is_executable_or_script() {
  [[ -x "$1" || "$1" == *.py ]]
}

function discover_modules() {
  find "$OMNI_ROOT" -type f \( -name "*.py" -o -perm -u+x \) \
    ! -path "*/__pycache__/*" ! -path "*/venv/*" \
    | sort
}

function display_modules_menu() {
  echo "========== OMNISCIENT FRAMEWORK MENU =========="
  echo "Modules found in: $OMNI_ROOT"
  echo

  i=1
  MODULES=()
  for f in $(discover_modules); do
    label=$(basename "$f" | sed 's/.py$//;s/_/ /g' | awk '{ for (i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2); print }')
    echo "$i. $label"
    MODULES+=("$f")
    ((i++))
  done

  echo "$i. View logs"
  VIEW_LOGS_IDX=$i
  ((i++))

  echo "$i. System Health Check"
  HEALTH_IDX=$i
  ((i++))

  echo "$i. Exit"
  EXIT_IDX=$i
  echo "==============================================="
}

function run_module() {
  local filepath="$1"
  if [[ "$filepath" == *.py ]]; then
    python "$filepath"
  else
    bash "$filepath"
  fi
}

function main_menu() {
  while true; do
    clear
    display_modules_menu
    read -rp "Select option: " opt

    if [[ "$opt" =~ ^[0-9]+$ ]]; then
      if (( opt >= 1 && opt <= ${#MODULES[@]} )); then
        run_module "${MODULES[$((opt-1))]}"
      elif (( opt == VIEW_LOGS_IDX )); then
        less "$OMNI_ROOT/logs/omniscient_api.log"
      elif (( opt == HEALTH_IDX )); then
        curl http://localhost:8000/sys/health || log "[ERROR] API not reachable"
      elif (( opt == EXIT_IDX )); then
        echo "Goodbye."
        exit 0
      else
        log "[ERROR] Invalid numeric option: $opt"
      fi
    else
      log "[ERROR] Input must be a number"
    fi

    echo
    read -rp "Press Enter to return to the menu..."
  done
}

main_menu

