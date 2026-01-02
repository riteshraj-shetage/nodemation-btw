#!/bin/bash
set -euo pipefail

# Navigate to the directory containing your docker compose file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# Stop n8n
docker compose down

# Restore backup into n8n data volume
LATEST_BACKUP=$(ls -t ~/n8n-backups/n8n_backup_*.tar.gz | head -n 1)

docker run --rm \
    -v n8n-compose_n8n_data:/data \
    -v ~/n8n-backups:/backup \
    ubuntu:24.04 \
    tar xzf "/backup/$(basename "$LATEST_BACKUP")" -C /data

# Start n8n
docker compose up -d
