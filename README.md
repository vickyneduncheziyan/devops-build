# DevOps Pipeline Setup

A containerized CI/CD pipeline for a static web app using Docker, Jenkins, GitHub, and AWS EC2.

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Docker + Nginx | Containerize and serve the app |
| Jenkins | CI/CD pipeline |
| GitHub | Version control (dev / master branches) |
| Docker Hub | Image registry (dev = public, prod = private) |
| AWS EC2 (t2.micro) | Hosting |
| Uptime Kuma | Health monitoring |

---

## Repository Structure

```
devops-build/
├── build/              # Static app files (index.html)
├── Dockerfile          # Nginx-based container
├── docker-compose.yml  # Run the app container
├── Jenkinsfile         # CI/CD pipeline definition
├── build.sh            # Build Docker image
├── deploy.sh           # Deploy container to server
├── monitoring-setup.sh # Install Uptime Kuma
├── .dockerignore
└── .gitignore
```

---

## Branch → Deployment Flow

```
Push to dev     →  Build image  →  Push to vickyneduncheziyan/dev (public)
Merge to master →  Build image  →  Push to vickyneduncheziyan/prod (private)
```

---

## Quick Start

### 1. Clone & setup
```bash
git clone https://github.com/vickyneduncheziyan/devops-build
cd devops-build
git checkout dev
```

### 2. Build & run locally
```bash
bash build.sh
bash deploy.sh
# App runs at http://localhost
```

### 3. Deploy on EC2
```bash
docker-compose up -d
```

### 4. Setup monitoring
```bash
bash monitoring-setup.sh
# Dashboard at http://<EC2_IP>:3001
```

---

## Jenkins Pipeline

- Auto-triggered on push to `dev` or `master` via GitHub webhook
- Credentials stored as **Username with Password** (`dockerhub-creds`)
- Jenkins runs on port `8080`

---

## AWS Security Group

| Port | Source | Purpose |
|---|---|---|
| 80 | 0.0.0.0/0 | Public app access |
| 8080 | 0.0.0.0/0 | Jenkins UI |
| 3001 | 0.0.0.0/0 | Uptime Kuma |
| 22 | Your IP only | SSH access |

---

## Docker Hub

- **Dev repo:** `vickyneduncheziyan/dev` — Public
- **Prod repo:** `vickyneduncheziyan/prod` — Private
