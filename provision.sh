#!/usr/bin/env bash
# Base provisioning for the DevOps VM. Jenkins, SonarQube and Kubernetes come in later steps.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

echo ">>> Updating packages"
apt-get update -y
apt-get install -y git curl unzip ca-certificates

echo ">>> Kernel setting required by SonarQube (embedded Elasticsearch)"
echo "vm.max_map_count=262144" > /etc/sysctl.d/99-sonarqube.conf
sysctl --system

echo ">>> Java 17 and Maven"
apt-get install -y openjdk-17-jdk maven

echo ">>> Docker"
apt-get install -y docker.io
systemctl enable --now docker
usermod -aG docker vagrant   # lets the vagrant user run docker without sudo

echo ">>> Provisioning finished"
java -version
mvn -version
docker --version
