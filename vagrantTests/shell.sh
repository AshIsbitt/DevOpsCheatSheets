#!/usr/bin/env bash

# Change root password
echo "Changing root password"
echo "vagrant:q" | chpasswd

# Add deadsnakes-PPA and install py310
echo "Installing py310"
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install -y  python3.10

echo "HELLO HELLO HELLO HELLO HELLO HELLO HELLO"
