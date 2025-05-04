#!/bin/bash
set -e

OMNI_ROOT="/opt/omniscient"
VENV_DIR="$OMNI_ROOT/.venv"
PYTHON=$(which python3)

echo "[*] Creating Python virtual environment at $VENV_DIR..."
$PYTHON -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

echo "[*] Scanning for .py scripts and installing requirements where applicable..."

# Install core dependencies
pip install --upgrade pip

# Collect .py scripts and look for requirements.txt in matching folders
find "$OMNI_ROOT" -type f -name "*.py" | while read -r script; do
  script_dir=$(dirname "$script")
  if [[ -f "$script_dir/requirements.txt" ]]; then
    echo "[✓] Installing dependencies from $script_dir/requirements.txt"
    pip install -r "$script_dir/requirements.txt" || echo "[!] Failed: $script_dir"
  fi
done

echo "[✓] Virtual environment ready."
echo "To activate it: source $VENV_DIR/bin/activate"
