# n8n-compose

Minimal setup to run n8n using Docker Compose on Ubuntu 24.04.

## Prerequisites

- Ubuntu Server 24.04
- Domain with DNS pointing to your server's IP
- Ports 80 and 443 open

## Setup

1. Clone and navigate:
   ```bash
   git clone https://github.com/riteshraj-shetage/n8n-compose.git
   cd n8n-compose
   ```

2. Run setup:
   ```bash
   bash scripts/setup-n8n.sh
   ```

3. Configure environment:
   ```bash
   nano .env
   ```
   Update: `DOMAIN_NAME`, `SUBDOMAIN`, `SSL_EMAIL`, `GENERIC_TIMEZONE`

4. Start n8n:
   ```bash
   bash scripts/start-n8n.sh
   ```

5. Access at `https://<SUBDOMAIN>.<DOMAIN_NAME>`

## Commands

```bash
# Start
docker compose up -d

# Stop
docker compose down

# Logs
docker compose logs -f

# Update
docker compose pull && docker compose up -d
```

## Notes

- Workflows and data in Docker volumes (`n8n_data`, `traefik_data`)
- SSL certificates managed automatically by Traefik
