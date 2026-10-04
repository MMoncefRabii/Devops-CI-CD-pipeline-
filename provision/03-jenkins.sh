#!/usr/bin/env bash
# Step 3: Jenkins LTS from the official stable apt repository.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

echo ">>> [03-jenkins] Adding the Jenkins LTS apt repository (2026 signing key)"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \
  -o /etc/apt/keyrings/jenkins-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  > /etc/apt/sources.list.d/jenkins.list
apt-get update -y

echo ">>> [03-jenkins] Installing Jenkins (Java 21 is already installed by 01-base.sh)"
apt-get install -y fontconfig jenkins

echo ">>> [03-jenkins] Letting the jenkins user run Docker (needed by the pipeline later)"
usermod -aG docker jenkins

systemctl enable jenkins
systemctl restart jenkins

echo ">>> [03-jenkins] Waiting for Jenkins to answer on port 8080"
for i in $(seq 1 40); do
  code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/login || true)
  if [ "$code" != "000" ]; then break; fi
  sleep 3
done

echo ">>> [03-jenkins] Waiting for the first-login password file"
for i in $(seq 1 40); do
  if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then break; fi
  sleep 3
done

echo ">>> [03-jenkins] Done"
systemctl is-active jenkins
echo "Open http://192.168.33.10:8080 and use this one-time password:"
cat /var/lib/jenkins/secrets/initialAdminPassword
