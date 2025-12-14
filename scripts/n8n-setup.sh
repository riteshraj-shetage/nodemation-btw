#!/bin/bash
set -euo pipefail

echo "Setting up n8n self-hosting with Basic Auth..."

# 1. Update system
sudo apt update && sudo apt upgrade -y

# 2. Install Docker Engine, Docker Compose plugin, and apache2-utils
sudo apt install -y docker.io docker-compose-plugin apache2-utils
sudo systemctl enable --now docker

# 3. Verify installation
docker --version
docker compose version

# 4. Optional: allow current user to run docker without sudo
sudo usermod -aG docker "${USER}"
exec sg docker newgrp
groups

# 5. Create project directories
mkdir -p ~/n8n-compose/local-files ~/n8n-compose/auth
cd ~/n8n-compose

# 6. Reminder: copy your .env and compose.yaml into this directory
echo "Place your .env and compose.yaml files in ~/n8n-compose"

# 7. Create Basic Auth credentials
# Replace 'admin' with your desired username; you will be prompted for the password
htpasswd -c ./auth/.htpasswd admin

echo "Setup complete."
