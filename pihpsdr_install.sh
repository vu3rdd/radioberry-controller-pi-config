#!/bin/bash

echo "Installing piHPSDR and dependencies..."

function install_dependency {
    echo "--- Installing dependency: $1"
    sudo apt-get -y install "$1"
}

install_dependency libtool
install_dependency automake
install_dependency autoconf
install_dependency git
install_dependency libfftw3-dev
install_dependency meson
install_dependency ninja-build

# cleanup  for a new build everytime
cd ~
rm  -rf pihpsdr
rm  -rf src

mkdir -p src
cd src
# cleanup of clonned repo files

rm -rf wdsp
rm -rf rnnoise
rm -rf libspecbleach

git clone --depth=1 https://github.com/vu3rdd/rnnoise

echo "Installing rnnoise..."
cd rnnoise
git checkout -b buffering origin/buffering
./autogen.sh
./configure
make
sudo make install

echo "Installing libspecbleach..."
cd ..
git clone --depth=1 https://github.com/vu3rdd/libspecbleach

cd libspecbleach
meson build --buildtype=release --prefix=/usr/local --libdir=lib
meson compile -C build -v
sudo meson install -C build

echo "Installing WDSP library..."
cd ~
cd src
git clone --depth=1 https://github.com/vu3rdd/wdsp
cd wdsp
make -j 4
sudo make install
cd ..

echo "Installing pihpsdr..."
echo ""

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
