#!/bin/bash
set -e

echo "[*] Starting Omniscient modular framework structuring..."

BASE="/opt/omniscient"
mkdir -p \
  "$BASE/core" \
  "$BASE/bin" \
  "$BASE/ai" \
  "$BASE/forensics" \
  "$BASE/osint" \
  "$BASE/db" \
  "$BASE/conf" \
  "$BASE/logs" \
  "$BASE/backups" \
  "$BASE/gui" \
  "$BASE/www" \
  "$BASE/docs"

# Move known modules by logic
mv -v "$BASE"/ai "$BASE/ai/"
mv -v "$BASE"/bin/* "$BASE/bin/" || true
mv -v "$BASE"/compiled/* "$BASE/bin/" || true
mv -v "$BASE"/scripts/* "$BASE/bin/" || true
mv -v "$BASE"/factored_scripts/* "$BASE/bin/" || true
mv -v "$BASE"/init/* "$BASE/core/" || true
mv -v "$BASE"/management/* "$BASE/bin/" || true

mv -v "$BASE"/config/* "$BASE/conf/" || true
mv -v "$BASE"/omniscient.conf "$BASE/conf/" || true
mv -v "$BASE"/crons "$BASE/conf/" || true
mv -v "$BASE"/envs "$BASE/conf/" || true

mv -v "$BASE"/logs/* "$BASE/logs/" || true

mv -v "$BASE"/omnieye "$BASE/osint/" || true
mv -v "$BASE"/duckduckgosearch "$BASE/osint/" || true
mv -v "$BASE"/feedmeseymour "$BASE/osint/" || true
mv -v "$BASE"/pywebscrape "$BASE/osint/" || true
mv -v "$BASE"/crosstrax "$BASE/osint/" || true

mv -v "$BASE"/dockers "$BASE/core/" || true
mv -v "$BASE"/pdf2txtocr "$BASE/forensics/" || true
mv -v "$BASE"/pyfor "$BASE/forensics/" || true
mv -v "$BASE"/python3 "$BASE/forensics/" || true
mv -v "$BASE"/omniscinent_disk "$BASE/forensics/" || true
mv -v "$BASE"/rsysai.py "$BASE/forensics/" || true

mv -v "$BASE"/sql "$BASE/db/" || true
mv -v "$BASE"/sql_db_design_analysis "$BASE/db/" || true

mv -v "$BASE"/tkinter_gui.py "$BASE/gui/" || true
mv -v "$BASE"/templates "$BASE/www/" || true
mv -v "$BASE"/web "$BASE/www/" || true

mv -v "$BASE"/readme "$BASE/docs/" || true
mv -v "$BASE"/manpages "$BASE/docs/" || true
mv -v "$BASE"/framework_structure.log "$BASE/docs/" || true

mv -v "$BASE"/forgitboutit "$BASE/core/" || true
mv -v "$BASE"/for_git_master_repos_list "$BASE/core/" || true
mv -v "$BASE"/formakevenv "$BASE/core/" || true
mv -v "$BASE"/forwardxssh "$BASE/core/" || true

mv -v "$BASE"/omniscient.service "$BASE/core/" || true

mv -v "$BASE"/omniscient_backups "$BASE/backups/" || true
mv -v "$BASE"/omniscient_backup_soc "$BASE/backups/" || true

echo "[✓] Omniscient structure modularized."
tree "$BASE" || find "$BASE"
