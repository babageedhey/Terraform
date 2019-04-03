#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

# Environment
# TODO: This is back level
docker_version=18.06.1

# Update the OS
#################

sudo apt-get update -y

#apt-get upgrade -y
# To eliminate Grub menu https://askubuntu.com/questions/146921/how-do-i-apt-get-y-dist-upgrade-without-a-grub-config-prompt/262445#262445
#DEBIAN_FRONTEND=noninteractive sudo apt-get -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" upgrade


# Baseline packages
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Install Docker
#################

# Add docker official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add repostiory

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update index with new repository
sudo apt-get update -y

# Find the fully qulified package name for the version we want in the repository
docker_fqpn=$(apt-cache madison docker-ce | grep $docker_version | awk 'BEGIN {FS="|"}{print $2}' | awk '{$1=$1};1')

# Install
sudo apt-get install -y docker-ce=$docker_fqpn

sudo usermod -aG docker ubuntu


sudo chmod 600 /home/ubuntu/.ssh/mykey

sleep 60

scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -i /home/ubuntu/.ssh/mykey
ubuntu@172.31.80.10:/home/ubuntu/token .

sudo docker swarm join --token $(cat /home/ubuntu/token) 172.31.80.10:2377