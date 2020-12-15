#!/bin/bash

#Start install Kraken.Charge 
echo "Install Kraken.Charge"

echo "Get update"
sudo apt-get update


state=`docker -v`
echo "Docker status:  $state"
echo "Install Docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker pi
docker version
docker info
 
echo "Configuration of serial port"
raspi-config nonint do_serial 1

echo "Deactivate Bluetooth"
echo "dtoverlay=disable-bt" | sudo tee -a /boot/config.txt
sudo systemctl disable hciuart

docker run -it -p 8000:80 --mount source=krakenData,target=/app/database --mount source=krakenLogs,target=/app/wwwroot/logs  --device=/dev/serial0  --restart=always kyle236/krakenhome:latest

echo "The system will reboot in 10 seconds to finish the installation."
sleep 10
sudo reboot
