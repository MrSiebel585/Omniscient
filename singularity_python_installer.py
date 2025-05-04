#!/usr/bin/env python3
import os
import shutil
from pathlib import Path
from subprocess import run

INSTALL_DIR = Path("/opt/singularity")
BIN_DIR = INSTALL_DIR / "bin"
AI_DIR = INSTALL_DIR / "lib/ai"
LOG_DIR = INSTALL_DIR / "var/log"
ENV_FILE = INSTALL_DIR / ".env"
SERVICE_FILE = Path("/etc/systemd/system/singularity-ai.service")

def ensure_dir(path):
    path.mkdir(parents=True, exist_ok=True)
    print(f"[+] Created {path}")

def write_file(path, content, mode=0o755):
    path.write_text(content)
    path.chmod(mode)
    print(f"[+] Installed {path}")

def install():
    print("[*] Installing Singularity Python Installer...")

    ensure_dir(BIN_DIR)
    ensure_dir(AI_DIR)
    ensure_dir(LOG_DIR)

    write_file(BIN_DIR / "devcli", "#!/bin/bash\necho 'Singularity CLI Ready.'\n")
    write_file(AI_DIR / "init_ai.sh", "#!/bin/bash\necho '[AI] LLM module loaded.'\n")
    write_file(ENV_FILE, "PROJECT_ENV=production\nPROJECT_NAME=SingularityFramework\n", 0o644)

    service_content = f"""[Unit]
Description=Singularity AI Service
After=network.target

[Service]
ExecStart={AI_DIR}/init_ai.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
"""

    write_file(SERVICE_FILE, service_content, 0o644)

    run(["systemctl", "daemon-reexec"])
    run(["systemctl", "daemon-reload"])
    run(["systemctl", "enable", "singularity-ai"])
    run(["systemctl", "start", "singularity-ai"])

    print("[✓] Singularity Framework installed successfully.")

if __name__ == "__main__":
    install()
