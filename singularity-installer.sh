#!/bin/bash
set -e

# Define installation directories
INSTALL_DIR="/opt/singularity"
BIN_DIR="$INSTALL_DIR/bin"
SCRIPT_DIR="$INSTALL_DIR/scripts"
LOG_DIR="$INSTALL_DIR/var/log"

# Create necessary directories
echo "[*] Creating directories..."
mkdir -p "$BIN_DIR" "$SCRIPT_DIR" "$LOG_DIR"

# Write example CLI script
echo "[*] Installing CLI..."
cat <<EOF > "$BIN_DIR/devcli"
#!/bin/bash
echo 'Singularity CLI Installed. Use wisely.'
EOF
chmod +x "$BIN_DIR/devcli"

# Write example AI script
echo "[*] Installing AI Module..."
mkdir -p "$INSTALL_DIR/lib/ai"
cat <<EOF > "$INSTALL_DIR/lib/ai/init_ai.sh"
#!/bin/bash
echo '[AI] CodeLlama + WhiteRabbit bootstrapped.'
EOF
chmod +x "$INSTALL_DIR/lib/ai/init_ai.sh"

# Write .env
echo "[*] Writing environment..."
cat <<EOF > "$INSTALL_DIR/.env"
PROJECT_ENV=production
PROJECT_NAME=SingularityFramework
EOF

# Setup systemd service
echo "[*] Configuring services..."
cat <<EOF > /etc/systemd/system/singularity-ai.service
[Unit]
Description=Singularity AI Module
After=network.target

[Service]
ExecStart=$INSTALL_DIR/lib/ai/init_ai.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable singularity-ai
systemctl start singularity-ai

echo "[✓] Singularity installed successfully at $INSTALL_DIR"
