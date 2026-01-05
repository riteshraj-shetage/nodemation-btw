#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_DIR"

# Stop only n8n service
docker compose stop n8n

BACKUP_DIR="$PROJECT_DIR/backups"

# Pick the latest backup file
LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/n8n_backup_*.tar.gz | head -n 1 || true)
if [[ -z "$LATEST_BACKUP" ]]; then
  echo "No backup files found in $BACKUP_DIR"
  exit 1
fi

# Restore backup into n8n data volume
docker run --rm \
    -v n8n-compose_n8n_data:/data \
    -v "$BACKUP_DIR":/backup \
    --user $(id -u):$(id -g) \
    alpine \
    tar xzf "/backup/$(basename "$LATEST_BACKUP")" -C /data

# Restart n8n
docker compose up -d n8n

# Feedback message
echo "Restored from backup: $(basename "$LATEST_BACKUP")"

set -a
source .env 
set +a

echo "n8n is starting at https://${SUBDOMAIN}.${DOMAIN_NAME}"
