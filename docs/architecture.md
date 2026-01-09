# Architecture

```mermaid
flowchart TB

    User[User / Webhook Clients]

    User -->|HTTPS : 443| Traefik

    subgraph Public["Public Internet"]
        User
    end

    subgraph Proxy["Reverse Proxy Layer"]
        Traefik["Traefik
        - HTTPS (Let's Encrypt)
        - Domain Routing
        - TLS Termination
        Ports: 80, 443"]
    end

    subgraph Docker["Docker Network (Private)"]

        N8N["n8n Container
        - Web UI
        - REST API
        - Webhooks
        - Workflow Engine"]

        SQLite["SQLite Database
        (Single DB File on Volume)"]

        N8N --> SQLite

    end

    Traefik --> N8N
