# DevOps CI/CD Pipeline: Spring Boot + Angular on Kubernetes

A complete CI/CD pipeline built for the DevOps module at Esprit. Every push to GitHub triggers an automatic build, code-quality analysis, containerization, and deployment to Kubernetes, with monitoring on top.

> **Status:** 🚧 In progress. See the [Roadmap](#roadmap).

## Architecture

![Architecture](docs/architecture.jpg)

**Flow:** GitHub → Jenkins pulls the code → Maven builds → SonarQube analyzes → Docker image pushed to Docker Hub → Kubernetes deploys the pods (Spring, Angular, MySQL) → Prometheus and Grafana monitor everything.

## Tech stack and why

| Tool | Role | Why this choice | Main alternatives |
|---|---|---|---|
| **VMware + Ubuntu** | Host VM for the CI tools | Free locally, standard Linux for DevOps | VirtualBox, Proxmox, cloud VMs |
| **Vagrant** | Creates the VM from code | Rebuildable and versionable environment | Multipass, Packer, Terraform (cloud) |
| **GitHub** | Source code hosting | Industry standard, webhooks to Jenkins | GitLab, Bitbucket |
| **Maven** | Build and dependencies (Java) | Standard for Spring Boot | Gradle |
| **Jenkins** | CI/CD orchestration | Free, huge plugin ecosystem | GitHub Actions, GitLab CI, ArgoCD |
| **SonarQube** | Static code analysis | Quality gates for bugs and vulnerabilities | Snyk, Codacy, Checkmarx |
| **Docker / Docker Hub** | Packaging and registry | Same environment everywhere | Harbor, ECR, GHCR |
| **Kubernetes** | Orchestration | Self-healing, scaling, rolling updates | Docker Swarm, Nomad, OpenShift |
| **Prometheus + Grafana** | Metrics and dashboards | Open-source standard for Kubernetes | Datadog, ELK, Zabbix |

## Key design decisions

### Vagrant and the hypervisor
- Vagrant is a **remote control** for hypervisors, not a hypervisor itself. The Vagrantfile describes the VM (OS, RAM, ports, setup script).
- **VirtualBox** is supported natively. **VMware Workstation** needs the `vagrant-vmware-desktop` plugin plus the Vagrant VMware Utility (free and open source today).
- Vagrant boxes are provider-specific: the box must support the chosen provider.
- Recommended VM sizing: **6-8 GB RAM, 2-4 CPUs, 40 GB disk**. SonarQube needs `vm.max_map_count=262144`.

### Kubernetes locally
- Minikube can use VM drivers or the Docker driver. By default it creates a **single node** (`--nodes N` simulates more).
- Inside a Vagrant VM, use the **Docker driver** to avoid nested virtualization.
- For a more realistic cluster, three Vagrant VMs plus `kubeadm` is the educational alternative.
- **Chosen approach:** _to be decided (Minikube / k3s / kubeadm)_

## Compared with a large-company pipeline

| Aspect | This project | Large company |
|---|---|---|
| Infrastructure | One local VM | Multi-region cloud |
| Environments | One | Dev, staging, production |
| IaC | Vagrant | Terraform, Ansible, Helm |
| Registry | Docker Hub | Private registry with image scanning |
| Security | SonarQube | SAST + DAST, Trivy, Vault |
| Deployment | Direct | Blue/green, canary, GitOps (ArgoCD) |
| Monitoring | Metrics | Metrics + logs + traces, 24/7 alerting |

## Roadmap

- [x] Understand the architecture and tool choices
- [ ] Vagrantfile and provisioning script
- [ ] Jenkins + GitHub webhook
- [ ] Maven build and SonarQube quality gate
- [ ] Dockerfiles and Docker Hub push
- [ ] Kubernetes manifests (Deployments, Services, Ingress, PVC for MySQL)
- [ ] Prometheus and Grafana dashboards
- [ ] Demo video and screenshots

## Known limitations and improvements

- Add an **Ingress** and Kubernetes **Services** (not shown in the diagram)
- **Persistent volume** for MySQL, otherwise data is lost on pod restart
- **Secrets management** (DB passwords, Docker Hub credentials)
- **Image vulnerability scanning** (Trivy)
- Package with **Helm**, add multiple environments
- Move SonarQube out of the application cluster

## How to run

_Coming soon: step-by-step instructions (`vagrant up` and beyond)._

## Screenshots

_Coming soon: Jenkins pipeline, SonarQube report, `kubectl get pods`, Grafana dashboard._