#!/bin/bash
echo "This script will setup a Debian-based environment to allow compilation of the necessary components..."
echo "Installing packages..."
sudo apt install libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf llvm fakeroot build-essential devscripts gcc-arm-none-eabi binutils-arm-none-eabi gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi python3 python3-pip python3.11-venv u-boot-tools bc

echo "Configuring pyATK..."
cp files/usbdev.py pyatk/pyatk/channel/
cp files/boot.py pyatk/pyatk/
cd pyatk
python3 -m venv pyatk_venv
source pyatk_venv/bin/activate
pip install pyserial pyusb==1.0.0
sudo pyatk_venv/bin/python3 setup.py install
deactivate
cd ..
