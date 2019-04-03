#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

# Set up base environment
###########################


# If we need to install Docker
if which docker ; then
    install_docker=false
else
    install_docker=true
fi

docker_version=18.06.1


echo "Boot script starting."


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

# Add to docker group
    sudo usermod -aG docker ubuntu


sudo docker swarm init

sudo docker swarm join-token --quiet manager > /home/ubuntu/token


SERVER_COUNT=$(sudo docker node ls | grep Active | wc -l)
echo $SERVER_COUNT
# Add while not eq 3 try again
while [ $SERVER_COUNT -lt 3 ]
do
        echo "Waiting for other Managers to join the swarm..."
        sleep 10
        SERVER_COUNT=$(sudo docker node ls | grep Active | wc -l)
        echo $SERVER_COUNT
done

if [ $SERVER_COUNT -eq 3 ]; then
        echo "All node successfully connected!"

        #Deploy stack
        sudo -E docker stack deploy --compose-file /tmp/stack.yml stack

fi

