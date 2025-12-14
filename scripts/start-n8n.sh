#!/bin/bash
set -euo pipefail

echo "Starting n8n with validation checks..."

N8N_COMPOSE_DIR="$HOME/n8n-compose"

# 1. Check project directory exists
if [ ! -d "$N8N_COMPOSE_DIR" ]; then
  echo "Error: $N8N_COMPOSE_DIR does not exist. Run the setup script first."
  exit 1
fi

cd "$N8N_COMPOSE_DIR"

# 2. Check .env file exists
if [ ! -f ".env" ]; then
  echo "Error: .env file is missing in $N8N_COMPOSE_DIR"
  exit 1
fi

# 3. Check compose.yml file exists
if [ ! -f "compose.yml" ]; then
  echo "Error: compose.yml file is missing in $N8N_COMPOSE_DIR"
  exit 1
fi

# 4. Check Basic Auth file exists
if [ ! -f "auth/.htpasswd" ]; then
  echo "Error: auth/.htpasswd file is missing. Run htpasswd to create credentials."
  exit 1
fi

# 5. Run docker compose
echo "Validation passed. Starting n8n..."
docker compose up -d

echo "n8n is starting. Use 'docker compose logs -f' to monitor startup."
