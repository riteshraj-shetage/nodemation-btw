#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_DIR"

# Run backup before update
bash scripts/backup-n8n.sh

# Try update process
if docker compose pull n8n && \
   docker compose stop n8n && \
   docker compose rm -f n8n && \
   docker compose up -d n8n; then

    # Clean up old images
    docker image prune -f

    # Load environment variables for URL
    set -a
    source .env
    set +a

    echo "Update complete. n8n is running with the latest image."
    echo "n8n is starting at https://${SUBDOMAIN}.${DOMAIN_NAME}"

else
    echo "Update failed. Restoring from latest backup..."
    bash scripts/restore-n8n.sh
fi
