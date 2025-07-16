⚠️ PRIORITY: Disk Crash Recovery & Resource Triage

🧹 1. Emergency Cleanup: Locate Oversized/Hidden Files

Run this immediately:

sudo du -ahx / | sort -rh | head -n 50

Then scan home dirs and hidden folders:

sudo find / -type f -size +100M -exec ls -lh {} \; 2>/dev/null | sort -k 5 -rh | head -n 50

Key folders to investigate:

/opt/omniscient/ai/ — heavy LLM models

/home/$USER/.cache — Ollama / LMStudio models

/var/lib/docker — bloated Docker volumes if used

/opt/omniscient/backups, /archives — verify if old backups aren’t consuming GBs



---

🧼 2. Purge Temp & Caches

sudo apt clean
rm -rf ~/.cache/*
rm -rf /opt/omniscient/.venv/*/__pycache__/*


---

📦 3. Compress Inactive Assets

You can tarball entire submodules that aren’t used daily:

tar czf ~/omniscient_archives/ai_old_models_$(date +%F).tar.gz /opt/omniscient/ai/old_models/

Then delete original folder after verifying backup.


---

🔧 REBUILD & RESILIENCE HARDENING PLAN

✅ 1. Inject Live Disk Monitor

Script: /opt/omniscient/scripts/monitor_diskspace.sh

#!/bin/bash
# Monitors disk usage and triggers alert if >90%
# Location: /opt/omniscient/scripts/monitor_diskspace.sh

LOG="/opt/omniscient/logs/disk_watch.log"
THRESHOLD=90

USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "$(date): Disk usage critical at $USAGE%" >> "$LOG"
  /usr/bin/omnivoice "Warning. Disk usage is at $USAGE percent."
fi

Then schedule:

(crontab -l 2>/dev/null; echo "*/15 * * * * bash /opt/omniscient/scripts/monitor_diskspace.sh") | crontab -


---

✅ 2. Make Hidden LLM Files Visible & Trackable

Script: /opt/omniscient/scripts/ollama_tracker.sh

#!/bin/bash
# Lists Ollama / LMStudio model sizes and logs them
# Location: /opt/omniscient/scripts/ollama_tracker.sh

LOG="/opt/omniscient/logs/ollama_models.log"
MODEL_DIR="$HOME/.ollama/models"

echo "===== $(date) =====" >> "$LOG"
du -sh "$MODEL_DIR"/* >> "$LOG" 2>/dev/null


---

✅ 3. Rebuild System Map (Manifest Re-Index)

Re-run:

bash /opt/omniscient/init/generate_omniscient_immutable_sql_manifest.sh

If missing, regenerate from template.


---

✅ 4. Enable Auto-Rotation & Archive of Logs

Install logrotate if not already installed:

sudo apt install logrotate

Then configure /etc/logrotate.d/omniscient:

/opt/omniscient/logs/*.log {
    daily
    rotate 7
    compress
    missingok
    notifempty
    sharedscripts
}


---

🛠️ SYSTEM RECOMMENDATIONS MOVING FORWARD

✅ RECOMMENDED CHANGES:

🔁 Cron-scheduled cleanup: run periodic prune on ~/.cache, /tmp, unused LLMs

🧠 AI-powered summarizer: prioritize using lightweight GGUF models where LLMs are integrated — consider swapping out heavier models when not in use.

📊 Log Index: add a Streamlit/Flask “log size dashboard” card

📁 Script categories: Modularize inactive toolchains into ~/scripts_inactive/ and symlink only what’s actively used



---

📋 Checklist Summary (Active Dev Trackers)

Task	Status	Notes

System crash due to disk space	⚠️ URGENT	Run cleanup and monitoring steps above
Generate inject_logging_wrapper.sh	✅ Completed	Integrated across /opt/omniscient
Rebuild manifest	🔄 Re-run now	/opt/omniscient/init/generate_omniscient_immutable_sql_manifest.sh
Global Voice Agent + Dashboard	✅ Done	Installed to /opt/omniscient/ai/ and /web/
Add disk monitor alert via omnivoice	🔜 Pending	Provided script above
Re-enable .deb package tracking	✅ Directory found	Rebuild with: dpkg-deb --build /mnt/data/omniscient_deb_package



---

🧭 Next Steps

Would you like me to:

1. Auto-generate a cleanup script bundle for quick triage and restoration?


2. Package the disk monitor + LLM tracker + log rotator as a .deb?


3. Create a new Streamlit card to visually show disk use by folder?



Let me know and I’ll drop the next modules right away.