#!/usr/bin/env bash

# Change root password
echo "Changing root password"
echo "q" | passwd root

# Add deadsnakes-PPA and install py310
echo "Installing py310"
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.10

