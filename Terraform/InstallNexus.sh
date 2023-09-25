#! /bin/bash

sudo yum update -y
sudo yum install wget -y
sudo yum install java-1.8.0-openjdk.x86_64 -y
sudo mkdir /app && cd /app
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar -xvf nexus.tar.gz
sudo mv nexus-3* nexus
sudo adduser nexus
sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work
echo 'run_as_user="ec2-user"' | sudo tee -a /opt/nexus3/bin/nexus.rc
sudo chkconfig nexus on
sudo systemctl start nexus
sudo chcon -R -t bin_t /app/nexus/bin/nexus
sudo systemctl start nexus
