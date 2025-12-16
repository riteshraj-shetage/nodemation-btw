#!/bin/bash
set -euo pipefail

# Navigate to the directory containing your docker compose file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# Stop and remove containers, networks, and volumes
docker compose down
