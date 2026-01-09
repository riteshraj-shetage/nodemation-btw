# Why n8n-compose Exists

Self-hosting **n8n** should be simple — but in practice, it rarely is.

Most available guides fall into one of two extremes:

- **Too basic** — `docker run n8n`  
  No HTTPS, no persistence, no backups.
- **Too complex** — Kubernetes, Helm charts, external databases  
  Powerful, but far beyond what most people actually need.

**n8n-compose exists to fill the gap between those two.**

> A **secure, production-ready, self-hosted n8n stack** that can be deployed on any Ubuntu VPS in minutes — with HTTPS, persistence, and backups included by default.

It is designed for people who want **ownership, control, and portability** without DevOps complexity.

---

## The Problem This Solves

Running n8n in production requires more than just starting a container.

You need:
- HTTPS for OAuth, webhooks, and browser security  
- A persistent data store so workflows and credentials survive restarts  
- A way to back up and restore everything  
- A repeatable way to deploy on any server  

Most tutorials ignore at least one of these — until something breaks.

n8n-compose solves all of them from day one.

---

## What This Project Is

n8n-compose is not just a Docker Compose file.

It is a **complete self-hosting system** that gives you:

- A public, HTTPS-secured n8n instance  
- A **SQLite-based persistent data store** (single-file database)  
- Automatic TLS certificates via Let’s Encrypt  
- One-command startup, updates, backups, and recovery  
- A stack that can be moved between servers without downtime  

Everything is designed to behave like a **small SaaS backend**, not a demo.

---

## Why SQLite

Instead of running a separate database service, this stack uses **SQLite**.

This provides:
- A **single database file** containing all workflows, credentials, and history  
- Faster setup (no database container to manage)  
- Easier backups and restores  
- Better portability between servers  

For small teams, SaaS backends, and automation platforms, SQLite offers the **best balance of simplicity and reliability**.

---

## What This Project Is Not

This repository is **not** meant for:

- Local laptop experiments  
- Windows-only setups  
- Shared hosting environments 
- One-click “try n8n” demos  

It assumes:
- You have a VPS  
- You have a domain  
- You want a real, long-running automation server  

---

## The Philosophy

This project follows three core principles:

### 1. Production by Default
Everything is configured the way a real service would run:
- HTTPS  
- Persistent storage  
- Secure public access  

Nothing is left as an “optional later step”.

---

### 2. Simple but Serious
No Kubernetes.  
No external databases.  
No cloud lock-in.  

Just Docker Compose, Traefik, and SQLite — a stack that is small, fast, and dependable.

---

### 3. Portability
You own your stack.

You can:
- Back it up  
- Move it  
- Restore it  
- Bring it back online anywhere  

Your automations are never trapped inside one provider.

---

## Who This Was Built For

This stack is ideal for:

- Automation freelancers & agencies  
- SaaS founders using n8n as a backend  
- Developers who need private workflow automation  
- Teams that don’t want to depend on cloud plans  

If you want to run n8n as a **real service**, this project was built for you.
