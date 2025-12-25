# n8n-compose

Minimal setup to run n8n using Docker Compose on Ubuntu 24.04.

## Prerequisites Checklist

- [ ] AWS EC2 instance running Ubuntu 24.04 LTS
- [ ] Security group with ports 80 and 443 open
- [ ] Domain name with DNS A record pointing to your EC2 IP
- [ ] SSH access to your EC2 instance

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
