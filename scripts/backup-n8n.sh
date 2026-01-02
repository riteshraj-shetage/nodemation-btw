#!/bin/bash
set -euo pipefail

# Navigate to the directory containing your docker compose file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# Stop n8n before backup
docker compose down

# Create backup directory
BACKUP_DIR="$HOME/n8n-backups"
mkdir -p "$BACKUP_DIR"

# Create backup filename with timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/n8n_backup_$TIMESTAMP.tar.gz"

# Backup n8n data volume
docker run --rm \
    -v n8n-compose_n8n_data:/data \
    -v "$BACKUP_DIR":/backup \
    alpine \
    tar czf "/backup/n8n_backup_$TIMESTAMP.tar.gz" -C /data .

# Restart n8n after backup
docker compose up -d
