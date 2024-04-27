#!/bin/bash

# ln -s /media/fred/EHD1/Fred/Code code

# Variables
USER="$(whoami)"

# Basic Installs
sudo apt update

sudo apt install nala

sudo nala install git

# Install homebrew - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-homebrew-on-linux
sudo apt install build-essential

curl -fsSL -o brewInstall.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

/bin/bash brewInstall.sh

if command -v brew &>/dev/null; then
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/home/${USER}/.bashrc
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

	brew doctor
else
	echo "Homebrew installation failed"
fi

# Install Neovim with current config (Lazyvim)
if command -v brew &>/dev/null; then
	brew install node
	brew install neovim
else
	echo "Homebrew not available/installed to install node and neovim"
fi

git clone https://github.com/fred-gutierrez/lazyvim-myconfig ~/.config/nvim

# Install tmux
sudo nala install tmux

git clone https://github.com/fred-gutierrez/tmux-myconfig ~/.config/tmux

# Install ScreenKey for detecting key input for Videos
sudo nala install screenkey

# Install Virtual Machine Manager and QEMU
sudo nala install qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager -y

sudo systemctl status libvirtd.service

sudo virsh net-start default

sudo virsh net-autostart default

sudo virsh net-list --all

sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
sudo usermod -aG kvm $USER
sudo usermod -aG input $USER
sudo usermod -aG disk $USER

# Install Razer Genie (Optional)
sudo gpasswd -a $USER plugdev

# Remove shiet libreoffice and install onlyoffice
sudo nala remove --purge "libreoffice*"

# Install Redshift and set it automatically

# --- END --- #
echo "Please remember to restart for some of the installations to work (like Razergenie, QEMU, etc.)"
