# n8n-compose

Minimal setup to run **n8n** with **Traefik** reverse proxy and Basic Auth on an Ubuntu 24.04 server (tested on Azure VM) using Docker Compose.

## Prerequisites
- Ubuntu Server 24.04 (Azure VM image)
- Domain name with DNS pointing to your VM’s IP
- Docker Engine and Docker Compose plugin (installed by setup script)

## Setup

1. **Clone this repo**
   ```bash
   git clone https://github.com/riteshraj-shetage/n8n-compose.git ~/n8n-compose
   cd ~/n8n-compose
   ```

2. **Prepare environment**
   - Copy `.env.example` to `.env` and edit values:
     ```bash
     cp .env.example .env
     nano .env
     ```
   - Set your domain, subdomain, SSL email, and timezone.

3. **Run setup script**
   ```bash
   bash scripts/n8n-setup.sh
   ```
   - Installs Docker + Compose.
   - Creates required directories (`auth/`, `local-files/`).
   - Prompts you to create Basic Auth credentials (`auth/.htpasswd`).

4. **Start n8n**
   ```bash
   bash scripts/start-n8n.sh
   ```
   - Validates `.env`, `compose.yaml`, and `auth/.htpasswd`.
   - Runs `docker compose up -d`.

## Access

- Open: `https://<SUBDOMAIN>.<DOMAIN_NAME>`
- Login with the Basic Auth credentials you created.
- Certificates are managed automatically by Traefik (Let’s Encrypt).

## Lifecycle

- Monitor logs:
  ```bash
  docker compose logs -f
  ```
- Stop services:
  ```bash
  docker compose down
  ```
- Update images and restart:
  ```bash
  docker compose pull
  docker compose up -d
  ```

## Notes

- `.env` and `auth/.htpasswd` are ignored in Git for security.
- Runtime data (workflows, DB, certs) is stored in Docker volumes (`n8n_data`, `traefik_data`).
