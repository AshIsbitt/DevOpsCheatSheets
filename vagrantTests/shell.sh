#!/usr/bin/env bash


echo "Set keyboard..."
rm /etc/default/keyboard
touch /etc/default/keyboard
echo 'XKBMODEL="macbook79"' > /etc/default/keyboard
echo 'XKBLAYOUT="gb"' > /etc/default/keyboard
echo 'XKBVARIANT="mac_intl"' > /etc/default/keyboard
echo 'XKBOPTIONS="lv3:alt_switchi/n/n"' > /etc/default/keyboard
echo 'BACKSPACE="guess"' > /etc/default/keyboard

# https://github.com/angel-devicente/Vagrantfiles/blob/main/ubuntu2110/Vagrantfile
echo Installing Mate Desktop
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install -y ubuntu-mate-desktop
sudo rm /usr/share/xsessions/ubuntu.desktop

# Restart to start DE
echo "REBOOTING..."
sudo reboot

echo "Installing virtualbox guest drivers..."
sudo apt install virtualbox-guest-dkms
xrandr --output VGA-1 --mode 1280x800
xrandr --output VGA-1 --mode 2560x1600 

# Change root password
echo "Changing root password"
echo "vagrant:q" | chpasswd

echo "Installing py310..."
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install -y  python3.10

echo "Change default python3..."
sudo unlink /usr/bin/python3
sudo ln -s /usr/bin/python3.10 /usr/bin/python3

echo "Installing Neovim..."
sudo apt-get install -y neovim
echo "Installing tmux..."
sudo apt install -y tmux
echo "installing zsh..."
sudo apt install -y zsh
echo "installing oh-my-zsh..."
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# GH-CLI
echo "installing gh-cli..."
ls -la /usr/lib/python3/dist-packages/apt_pkg.cpython-38m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.so
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

echo "installing neofetch"
sudo apt-get install -y neofetch
echo "neofetch" >> ~/.bashrc

echo "installing btm"
curl -LO https://github.com/ClementTsang/bottom/releases/download/0.6.4/bottom_0.6.4_amd64.deb
sudo dpkg -i bottom_0.6.4_amd64.deb

mkdir ~/tmp

# git clone dotfiles
gh repo clone AshIsbitt/dotfiles ~/tmp/dotfiles

# Set up dotfiles symlinks


echo "PROVISIONING COMPLETE"
echo "UNABLE TO DO FROM TERMINAL: INSTALL FIREFOX ADD-ONS"
