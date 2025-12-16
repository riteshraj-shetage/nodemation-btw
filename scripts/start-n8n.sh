#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

[ -f "compose.yml" ] || { echo "Error: compose.yml not found"; exit 1; }
[ -f ".env" ] || { echo "Error: .env not found"; exit 1; }
[ -f "auth/.htpasswd" ] || { echo "Error: auth/.htpasswd not found"; exit 1; }

set -a
source .env
set +a

[ -z "$DOMAIN_NAME" ] && { echo "Error: DOMAIN_NAME not set"; exit 1; }
[ -z "$SUBDOMAIN" ] && { echo "Error: SUBDOMAIN not set"; exit 1; }
[ -z "$SSL_EMAIL" ] && { echo "Error: SSL_EMAIL not set"; exit 1; }

docker compose up -d

echo "n8n is starting at https://${SUBDOMAIN}.${DOMAIN_NAME}"
