# n8n-compose

Minimal setup to run n8n using Docker Compose on Ubuntu 24.04.

## ✅ Prerequisites Checklist

- [ ] A Linux server (Ubuntu 24.04 recommended) — cloud VM or local machine  
  _Example: 2+ vCPUs, 4+ GB RAM, 30+ GB SSD_  
  *(See [Hostinger’s n8n VPS requirements](https://www.hostinger.com/tutorials/n8n-vps-requirements) for minimum and recommended specs)*

- [ ] Firewall/security rules allowing ports **80** (HTTP) and **443** (HTTPS)  
  i.e. inbound TCP rules for 80 and 443 enabled

- [ ] A domain name with a DNS **A Record** pointing to your server’s public IP  
  Example: `n8n.example.com → <your-server-ip>` | (here `n8n` is the subdomain/hostname)

- [ ] SSH access to the server

## Step-by-Step Installation

### 1. Connect to Your EC2 Instance

```bash
ssh -i your-key.pem ubuntu@<your-ec2-public-ip>
```

### 2. Clone the Repository

```bash
git clone https://github.com/riteshraj-shetage/n8n-compose.git
cd ~/n8n-compose
```

### 3. Run the Setup Script

```bash
bash scripts/setup-n8n.sh
```

> **Note:** The setup script adds your user to the `docker` group.  
> You must log out and back in (or run `newgrp docker`) before continuing,  
> otherwise you may see `permission denied` errors when running Docker commands.


### 4. Configure Your Environment

```bash
nano .env
```

**Update these values:**
```env
DOMAIN_NAME=example.com        
SUBDOMAIN=n8n                    
SSL_EMAIL=your_email  
GENERIC_TIMEZONE=UTC    
```

### 5. Start n8n

```bash
bash scripts/start-n8n.sh
```

### 6. Access n8n

Open your browser and go to:
```
https://<SUBDOMAIN>.<DOMAIN_NAME>
```

## Demo

### Importing a Template
<img src="docs/import-template.gif" alt="Import Template Demo" width="600"/>

### Executing a Workflow
<img src="docs/execute-workflow.gif" alt="Execute Workflow Demo" width="600"/>


## Useful Commands

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
