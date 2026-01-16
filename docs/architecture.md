# Architecture

```mermaid
flowchart TB

    User[User / Webhook Clients]

    User -->|HTTPS : 443| Traefik

    subgraph Public["Public Internet"]
        User
    end

    subgraph Server["Linux Server (Ubuntu 24.04)"]
        
        subgraph Docker["Docker Compose Environment"]
            
            Traefik["Traefik Container
            - HTTPS (Let's Encrypt)
            - Domain Routing
            - TLS Termination
            Ports: 80, 443"]
            
            N8N["n8n Container
            - Web UI
            - REST API
            - Webhooks
            - Workflow Engine
            Port:  5678"]
            
            Traefik -->|HTTP : 5678| N8N
            
        end
        
        subgraph Volumes["Docker Volumes"]
            N8NData["n8n_data
            (SQLite + User Data)"]
            TraefikData["traefik_data
            (SSL Certificates)"]
        end
        
        N8N -.->|Reads/Writes| N8NData
        Traefik -.->|Stores Certs| TraefikData
        
    end

    style Docker fill:#1a1a2e,stroke:#16213e,color:#fff
    style Volumes fill:#0f3460,stroke:#16213e,color:#fff
    style Server fill:#0a0a0a,stroke:#333,color:#fff
