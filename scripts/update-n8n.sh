#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_DIR"

# Run backup before update
bash scripts/backup-n8n.sh
echo "Backup completed successfully."

# Pull latest version
docker compose pull n8n

# Stop and remove old n8n container
docker compose stop n8n
docker compose rm -f n8n

# Start updated n8n
docker compose up -d n8n

# Clean up old images
docker image prune -f
