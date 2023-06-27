#!/bin/bash

# prep an ubuntu20 server instance for project deployment

# update packages
sudo apt-get update

# install unzip
if [ ! -f /usr/bin/unzip ]; then
  sudo apt-get install -y unzip
fi

# install python3
if [ ! -f /usr/bin/python3 ]; then
  sudo apt-get install -y python3-pip
fi

# install docker
sudo groupadd docker
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker ubuntu

# install docker compose
sudo curl \
    -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# install direnv
if [ ! -f /usr/bin/direnv ]; then
  sudo apt-get install -y direnv
  eval "$(direnv hook bash)"
fi


secs=5
echo "setup finished, rebooting in 5 seconds..."
while [ $secs -gt 0 ]; do
  echo -ne "$secs\033[0K\r"
  sleep 1
  : $((secs--))
done
echo "commencing reboot"
sudo shutdown -r now
