# Cloud-Native Automated DevOps Platform

![CI/CD Pipeline](https://github.com/nnadinee-1/devops-automation-platform/actions/workflows/pipeline.yml/badge.svg)

## Overview
A fully automated cloud-native platform simulating a real production environment.
Every code push triggers an automated pipeline with zero manual deployment steps.

---

## Architecture
GitHub Push
↓
GitHub Actions (CI/CD)
↓
Run Tests → Security Scan (Trivy) → Build Docker Image → Push to DockerHub
↓
Kubernetes Deployment (Minikube)
↓
Auto-scaling (HPA) + Self-healing
↓
Monitoring (Prometheus + Grafana)
---

## Tech Stack

| Category | Tools |
|----------|-------|
| Application | Python Flask |
| Containerization | Docker |
| CI/CD | GitHub Actions |
| Container Orchestration | Kubernetes, Helm |
| Infrastructure as Code | Terraform |
| Configuration Management | Ansible |
| Cloud Provider | AWS (VPC, EC2, S3, DynamoDB) |
| Monitoring | Prometheus, Grafana |
| Security | Trivy |

---

## Project Phases

### Phase 1 — CI/CD + Docker
- Python Flask app containerized with Docker
- GitHub Actions pipeline: tests → security scan → build → push to DockerHub
- Zero manual deployment steps

### Phase 2 — Kubernetes Deployment
- Deployed on Kubernetes with 2 replicas
- HPA auto-scales from 2 to 5 pods based on CPU usage
- Self-healing: failed pods restart automatically
- Rolling updates with zero downtime

### Phase 3 — Infrastructure as Code (AWS)
- Terraform provisions full AWS infrastructure:
  - VPC, Subnets, Internet Gateway, Route Tables
  - EC2 instance (t3.micro)
  - Security Groups
- Remote state stored in S3 + DynamoDB locking
- Ansible configures servers automatically after provisioning

### Phase 4 — Monitoring
- Prometheus collects metrics from Kubernetes cluster
- Grafana dashboards visualize CPU, memory, and pod health
- Metrics-server enabled for real-time resource monitoring

### Phase 5 — DevSecOps
- Trivy scans Docker image for vulnerabilities in CI/CD pipeline
- Pipeline automatically blocks deployment if CRITICAL vulnerabilities found
- Proven: pipeline blocked slim image, passed with alpine image

---

## How to Run

### Prerequisites
- Docker
- kubectl
- Minikube
- Terraform
- Ansible
- AWS CLI

### Run Locally
```bash
# Start Minikube
minikube start

# Deploy application
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/hpa.yaml

# Access application
minikube service devops-platform-service --url
```

### Deploy Monitoring
```bash
kubectl create namespace monitoring
kubectl apply -f monitoring/prometheus-config.yaml
kubectl apply -f monitoring/prometheus-deployment.yaml
kubectl apply -f monitoring/grafana-deployment.yaml
```

### Deploy AWS Infrastructure
```bash
cd terraform
terraform init
terraform plan
terraform apply
# Remember to destroy after use:
terraform destroy
```

---

## Key Automation Features
- **Zero manual deployment** — every push triggers full pipeline
- **Auto-scaling** — HPA scales pods based on CPU load
- **Self-healing** — Kubernetes restarts failed containers automatically
- **Security gate** — Trivy blocks vulnerable images from reaching production
- **IaC** — entire AWS infrastructure recreatable from code in minutes
- **Git as source of truth** — all infrastructure and config in version control

---

## Repository Structure
devops-automation-platform/
├── app/                    # Flask application + tests
├── docker/                 # Dockerfile
├── kubernetes/             # K8s manifests (deployment, service, HPA)
├── terraform/              # AWS infrastructure as code
├── ansible/                # Server configuration playbooks
├── monitoring/             # Prometheus + Grafana configs
└── .github/workflows/      # CI/CD pipeline
---

## Author
**Nadine Ibrahim** — DevOps & Cloud Engineer
- GitHub: [nnadinee-1](https://github.com/nnadinee-1)
- LinkedIn: [nadine ibrahim](https://linkedin.com/in/nadineibrahimm)
