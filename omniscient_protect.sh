#!/bin/bash
# Source this after defining /opt/omniscient layout and .env

source /opt/omniscient/.env || { echo "Missing .env"; exit 1; }

# Make protected directories immutable and read-only for all but owner
protect_dirs=("$OMNISCIENT_CONF" "$OMNISCIENT_DOCS" "$OMNISCIENT_DB")

for d in "${protect_dirs[@]}"; do
  if [ -d "$d" ]; then
    chmod -R a-w "$d"
    chattr -R +i "$d" 2>/dev/null || echo "Immutable flag requires root: $d"
  fi
done

# Custom cd shortcuts
alias cdbin="cd $OMNISCIENT_BIN"
alias cdai="cd $OMNISCIENT_AI"
alias cdgui="cd $OMNISCIENT_GUI"
alias cdlogs="cd $OMNISCIENT_LOGS"
alias cdconf="cd $OMNISCIENT_CONF"
alias cddb="cd $OMNISCIENT_DB"

echo "[✓] Omniscient environment protected and ready."
