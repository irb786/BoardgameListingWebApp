#! bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl start docker 
sudo systemctl enable docker 
docker --version
sudo usermod -aG docker $USER 
newgrp docker
docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community