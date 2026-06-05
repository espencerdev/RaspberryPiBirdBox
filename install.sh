#!/bin/sh

ORIGINAL_PWD=$PWD

# Install service to auto disable wifi if ethernet was successfully detected
sudo cp ./eth-wifi-switch.sh /usr/local/bin/eth-wifi-switch.sh
sudo chmod +x /usr/local/bin/eth-wifi-switch.sh
sudo cp ./eth-wifi-switch.service /etc/systemd/system/eth-wifi-switch.service
sudo systemctl enable eth-wifi-switch.service
sudo systemctl start eth-wifi-switch.service

# Install camera tools and sqlite
sudo apt-get -y install libcamera-apps sqlite3

# Download, configure and install mediamtx to start on boot
sudo mkdir /usr/local/bin/mediamtx
cd /usr/local/bin/mediamtx
sudo wget https://github.com/bluenviron/mediamtx/releases/download/v1.19.0/mediamtx_v1.19.0_linux_arm64.tar.gz
sudo tar xzf mediamtx_v1.19.0_linux_arm64.tar.gz
cd $ORIGINAL_PWD
sudo cp ./mediamtx.service /etc/systemd/system/mediamtx.service
sudo cp ./mediamtx.yml /usr/local/bin/mediamtx/
sudo systemctl enable mediamtx.service
sudo systemctl start mediamtx.service

# Install NodeJS 24
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24

# Install libraries and build web ui
cd $ORIGINAL_PWD/bird-interface/frontend/
npm i -D
npm run build
cd ../backend/
npm i -D
npm run build
cd $ORIGINAL_PWD
sudo cp ./bird-interface.service /etc/systemd/system/bird-interface.service
sudo systemctl enable bird-interface.service
sudo systemctl start bird-interface.service

