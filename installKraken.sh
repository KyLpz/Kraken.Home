#!/bin/bash

#Start install Kraken.Charge 
echo "Install Kraken.Charge"

echo "Get update"
sudo apt-get update

echo "Install Docker"
sudo apt-get install docker-ce docker-ce-cli containerd.io

echo "Configuration of serial port"
raspi-config nonint do_serial 1

echo "Deacticate Bluetooth"
echo "dtoverlay=disable-bt" | sudo tee -a /boot/config.txt
sudo systemctl disable hciuart

echo "The system will reboot in 10 Seconds to finish the installation."
sleep 10
sudo reboot
