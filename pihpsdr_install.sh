#!/bin/bash

echo "Installing WDSP library..."

function install_dependency {
    echo "--- Installing dependency: $1"
    sudo apt-get -y install "$1"
}

install_dependency git
install_dependency libfftw3-dev
	
cd /tmp
git clone --depth=1 https://github.com/g0orx/wdsp
cd wdsp
make -j 4
sudo make install
cd ..
rm -rf wdsp
cd ~

echo ""
echo "WDSP installed."

echo ""
echo "Installing pihpsdr..."
echo ""
echo ""
	
function install_dependency {
    echo "--- Installing dependency: $1"
    sudo apt-get -y install $1
}

install_dependency git
install_dependency libpulse-dev
install_dependency libgtk-3-dev
install_dependency libasound2-dev
install_dependency libcurl4-openssl-dev
install_dependency libusb-1.0-0-dev
install_dependency libgpiod-dev
install_dependency gpiod
install_dependency libi2c-dev

# remove any older pihpsdr source code
rm -rf src/pihpsdr
mkdir -p src
cd src
git clone https://github.com/vu3rdd/pihpsdr.git
cd pihpsdr
make -j 4
sudo make install
if [ ! -d "/home/pi/.pihpsdr" ]; then
    mkdir /home/pi/.pihpsdr
fi

rm /home/pi/Desktop/pihpsdr.desktop

file="/home/pi/Desktop/pihpsdr.desktop"
echo "[Desktop Entry]" >> $file
echo "Icon=/home/pi/.pihpsdr/hpsdr.png" >> $file
echo "Exec=/usr/local/bin/pihpsdr" >> $file
echo "Type=Application" >> $file
echo "Terminal=false" >> $file
echo "Path=/home/pi/.pihpsdr" >> $file
cat $file
	
echo ""
echo "pihpsdr installed"
