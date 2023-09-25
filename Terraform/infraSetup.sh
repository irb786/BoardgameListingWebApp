#! bin/bash

#install Docker
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl start docker 
sudo systemctl enable docker 
docker --version
sudo usermod -aG docker $USER 
newgrp docker

#install Jenkins
sudo apt update -y
sudo apt install openjdk-17-jre -y
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y

#install Trivy
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin