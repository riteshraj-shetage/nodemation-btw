#!/bin/bash
set -euo pipefail

echo "Setting up n8n self-hosting with Basic Auth..."

# 1. Update system
sudo apt update && sudo apt upgrade -y

# 2. Install prerequisites
sudo apt-get install -y ca-certificates curl gnupg apache2-utils

# 3. Add Docker’s official GPG key and repo
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Install Docker Engine + Compose plugin
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 5. Enable Docker service
sudo systemctl enable --now docker

# 6. Verify installation
docker --version
docker compose version   # note: v2 uses `docker compose` (space)

# 7. Allow current user to run docker without sudo
sudo usermod -aG docker "${USER}"
newgrp docker

# 8. Create project directories
mkdir -p ~/n8n-compose/local-files ~/n8n-compose/auth
cd ~/n8n-compose

# 9. Reminder: copy your .env and compose.yaml into this directory
echo "Place your .env and compose.yaml files in ~/n8n-compose"

# 10. Create Basic Auth credentials
htpasswd -c ./auth/.htpasswd admin

echo "Setup complete."
