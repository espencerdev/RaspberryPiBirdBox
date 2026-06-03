#!/bin/sh

ORIGINAL_PWD=$PWD
sudo cp ./eth-wifi-switch.sh /usr/local/bin/eth-wifi-switch.sh
sudo chmod +x /usr/local/bin/eth-wifi-switch.sh
sudo cp ./eth-wifi-switch.service /etc/systemd/system/eth-wifi-switch.service
sudo systemctl enable eth-wifi-switch.service

sudo apt-get -y install libcamera-apps 

sudo mkdir /usr/local/bin/mediamtx
cd /usr/local/bin/mediamtx
sudo wget https://github.com/bluenviron/mediamtx/releases/download/v1.14.0/mediamtx_v1.14.0_linux_arm64.tar.gz
sudo tar xzf mediamtx_v1.14.0_linux_arm64.tar.gz
cd $ORIGINAL_PWD
sudo cp ./mediamtx.service /etc/systemd/system/mediamtx.service
sudo cp ./mediamtx.yml /usr/local/bin/mediamtx/

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24
cd $ORIGINAL_PWD/bird-interface/backend/
npm i
cd ../frontend/
npm i
