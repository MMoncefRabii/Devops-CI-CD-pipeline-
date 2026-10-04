#!/usr/bin/env bash
# Step 1: base tools (Git, Java, Maven) and the kernel setting SonarQube needs.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

echo ">>> [01-base] Updating packages"
apt-get update -y
apt-get install -y git curl unzip ca-certificates gnupg

echo ">>> [01-base] Kernel setting for SonarQube (embedded Elasticsearch)"
echo "vm.max_map_count=262144" > /etc/sysctl.d/99-sonarqube.conf
sysctl --system > /dev/null

echo ">>> [01-base] Java 21 and Maven"
apt-get install -y openjdk-21-jdk maven

echo ">>> [01-base] Done"
git --version
java -version
mvn -version
sysctl vm.max_map_count
