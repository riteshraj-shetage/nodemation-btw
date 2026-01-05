#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_DIR"

# Stop only n8n service
docker compose stop n8n

BACKUP_DIR="$PROJECT_DIR/backups"
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/n8n_backup_$TIMESTAMP.tar.gz"

# Backup n8n data volume (adjust volume name if needed)
docker run --rm \
    -v n8n-dcompose_n8n_data:/data \
    -v "$BACKUP_DIR":/backup \
    --user $(id -u):$(id -g) \
    alpine \
    tar czf "/backup/$(basename "$BACKUP_FILE")" -C /data .

# Restart n8n
docker compose up -d n8n
