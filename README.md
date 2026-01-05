# n8n-compose

Simple, reproducible setup for running n8n with Docker Compose on Ubuntu 24.04 — designed to make self‑hosting fast, portable, and production‑ready.

## Highlights

- Minimal Docker Compose setup for n8n on a Linux Server
- Secure HTTPS with automatic SSL via Let's Encrypt
- Easy domain + subdomain configuration through `.env`
- Lightweight, reproducible, and production‑ready workflow automation
- Portable deployments with backup and restore support

---

## Prerequisites Checklist

- [ ] A Linux server (Ubuntu 24.04 recommended) — cloud VM  
  _Example: 2+ vCPUs, 4+ GB RAM, 30+ GB SSD_  
  *(See [Hostinger’s n8n VPS requirements](https://www.hostinger.com/tutorials/n8n-vps-requirements) for minimum and recommended specs)*

- [ ] Firewall/security rules allowing ports **80** (HTTP) and **443** (HTTPS)  
  i.e. inbound TCP rules for 80 and 443 enabled

- [ ] A domain name with a DNS **A Record** pointing to your server’s public IP  
  Example: `n8n.example.com → <your-server-ip>` | (here `n8n` is the subdomain/hostname)

- [ ] SSH access to the server

---

## Step-by-Step Installation

### 1. Connect to Your Instance

```bash
ssh -i your-key.pem ubuntu@<your-server-public-ip>
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

### 7. First-Time Login

After starting n8n for the first time, you’ll be prompted to create the owner account by entering:  
**Email · First name · Last name · Password**

Once submitted, you’ll be redirected to the n8n dashboard.  
_(This setup step only appears once — it initializes your admin account for the instance.)_

---

## Usage Examples

### Importing a Template
<img src="docs/import-template.gif" alt="Import Template Demo" width="600"/>

### Executing a Workflow
<img src="docs/execute-workflow.gif" alt="Execute Workflow Demo" width="600"/>

---

## Useful Commands

```bash
# Run initial setup (only once)
bash scripts/setup-n8n.sh

# Start the n8n services
bash scripts/start-n8n.sh

# Stop all running n8n services
bash scripts/stop-n8n.sh

# Create a backup of your n8n instance
bash scripts/backup-n8n.sh

# Restore n8n from a backup file
bash scripts/restore-n8n.sh

# Update n8n to the latest version
bash scripts/update-n8n.sh
```

## Bonus Tip: Backup File Transfer with SFTP

After creating a backup with `bash scripts/backup-n8n.sh`, you can easily download it from your server to your local machine using **SFTP**.

```bash
# first disconnect from your SSH session (return to your local terminal)
exit

# now start an SFTP session from your local machine
sftp ubuntu@<your-server-public-ip>

# navigate to the backups folder on the server
cd n8n-compose/backups

# list files sorted by time (newest first)
ls -t

# download the latest backup file
get n8n_backup_00000000_000000.tar.gz

# disconnect from the SFTP session
exit
```

This will copy the selected backup file into your current local directory.  
You can also use `get -r backups` to download the entire backups folder at once.

---
For more details, see the official n8n Docker Compose guide:  
[https://docs.n8n.io/hosting/installation/server-setups/docker-compose/](https://docs.n8n.io/hosting/installation/server-setups/docker-compose/)
